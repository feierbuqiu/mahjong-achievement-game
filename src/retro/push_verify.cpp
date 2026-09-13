// Independent reverse-direction validation of physical SAFE P/N layer tables.
// For each target honor bucket, scan every P child in the relevant next-layer
// buckets, delete a physical tile, and mark its parent N. No Numeric.next or
// Honor.next transition table is used to generate moves.
#include "global_index.hpp"
#include <filesystem>
#include <regex>
#include <set>
#include <iomanip>
#include <memory>

namespace fs = std::filesystem;
namespace push_check {
using u64 = uint64_t;
struct Budget : std::runtime_error { using std::runtime_error::runtime_error; };
struct Incomplete : std::runtime_error { using std::runtime_error::runtime_error; };
const auto push_started = Clock::now();
double seconds_limit = 60;
u64 child_visits = 0, deletion_candidates = 0, unique_n = 0, compared_states = 0;
u64 loaded_payload_bytes = 0, completed_target_buckets = 0;

void require(bool condition, const std::string& reason) {
    if (!condition) throw std::runtime_error(reason);
}
void check_budget() {
    if (std::chrono::duration<double>(Clock::now() - push_started).count() > seconds_limit)
        throw Budget("time budget exhausted; unfinished target buckets remain unverified");
}
std::string quote(const std::string& s) {
    std::string out = "\"";
    for (char c : s) {
        if (c == '"' || c == '\\') { out += '\\'; out += c; }
        else if (c == '\n') out += "\\n";
        else if (c == '\r') out += "\\r";
        else if (static_cast<unsigned char>(c) >= 32) out += c;
    }
    return out + '"';
}
std::string hex(u64 v) {
    std::ostringstream out; out << std::hex << std::setfill('0') << std::setw(16) << v;
    return out.str();
}
std::string stem(int n, int h) {
    std::ostringstream out; out << 'n' << std::setw(2) << std::setfill('0') << n << "_h" << std::setw(3) << h;
    return out.str();
}
std::string property(const std::string& json, const std::string& name, const std::string& pattern) {
    const std::regex expr("\\\"" + name + "\\\"\\s*:\\s*(" + pattern + ")\\s*(?=[,}])");
    std::sregex_iterator begin(json.begin(), json.end(), expr), end;
    require(begin != end, "missing/malformed metadata property " + name);
    const std::string value = (*begin)[1].str();
    require(++begin == end, "duplicate metadata property " + name);
    return value;
}
std::string text_property(const std::string& json, const std::string& name) {
    const auto value = property(json, name, "\\\"[^\\\"\\\\]*\\\"");
    return value.substr(1, value.size() - 2);
}
u64 number_property(const std::string& json, const std::string& name) {
    return std::stoull(property(json, name, "[0-9]+"));
}
u64 popcount(u64 w) { return __builtin_popcountll(w); }
unsigned first_bit(u64 w) {
    if (!w) throw std::runtime_error("ctz called on zero");
    return __builtin_ctzll(w);
}
u64 low_mask(unsigned count) { return count == 64 ? ~u64(0) : (u64(1) << count) - 1; }

struct Table {
    std::vector<u64> p_bits;
    u64 p_count = 0, states = 0;
    Table(const fs::path& directory, const retro::Index& index, const retro::Bucket& bucket) {
        states = bucket.size;
        if (!states) return;
        const auto name = stem(bucket.n, bucket.h);
        const auto metadata_file = directory / (name + ".complete.json");
        if (!fs::exists(metadata_file)) throw Incomplete("missing completed table " + metadata_file.u8string());
        std::ifstream metadata(metadata_file, std::ios::binary);
        require(bool(metadata), "cannot read metadata " + name);
        const std::string json(std::istreambuf_iterator<char>(metadata), {});
        require(text_property(json, "schema") == "MJGLOBAL_PN_V1", "schema mismatch " + name);
        if (property(json, "completed", "true|false") != "true") throw Incomplete("incomplete bucket " + name);
        require(text_property(json, "index_fingerprint") == hex(index.fingerprint), "fingerprint mismatch " + name);
        require(number_property(json, "n") == u64(bucket.n) && number_property(json, "h") == u64(bucket.h), "n/h mismatch " + name);
        require(number_property(json, "honor_code") == index.honors[bucket.h].code, "honor code mismatch " + name);
        require(number_property(json, "states") == states, "state count mismatch " + name);
        const u64 word_count = (states + 63) / 64;
        require(number_property(json, "word_count") == word_count, "word count mismatch " + name);
        const auto payload = directory / (name + ".bits");
        require(fs::exists(payload) && fs::file_size(payload) == word_count * 8, "payload length mismatch " + name);
        p_bits.resize(size_t(word_count));
        std::ifstream input(payload, std::ios::binary);
        require(bool(input.read(reinterpret_cast<char*>(p_bits.data()), std::streamsize(word_count * 8))), "payload read error " + name);
        const uint16_t endian_probe = 1;
        if (*reinterpret_cast<const uint8_t*>(&endian_probe) != 1) {
            for (auto& w : p_bits) {
                u64 reversed = 0; for (int j = 0; j < 8; ++j) reversed = (reversed << 8) | ((w >> (8 * j)) & 255);
                w = reversed;
            }
        }
        u64 hash = 1469598103934665603ULL;
        for (u64 w : p_bits) { p_count += popcount(w); hash ^= w; hash *= 1099511628211ULL; }
        require(p_count == number_property(json, "p_states"), "P popcount mismatch " + name);
        require(hex(hash) == text_property(json, "payload_hash64"), "word hash mismatch " + name);
        if (states & 63) require((p_bits.back() >> (states & 63)) == 0, "nonzero padding " + name);
        loaded_payload_bytes += word_count * 8;
    }
};

struct Source { int h; int honor_delete_power; };
// -1 means numeric deletions. Otherwise one physical honor deletion represents
// all identically counted honors that canonicalize to the target histogram.
std::vector<Source> sources_for(const retro::Index& index, int target_h) {
    std::map<uint32_t, int> by_code;
    for (int h = 0; h < int(index.honors.size()); ++h) by_code.emplace(index.honors[h].code, h);
    const uint32_t target_code = index.honors[target_h].code;
    std::map<int, int> selected;
    selected.emplace(target_h, -1);
    uint32_t digits = target_code;
    for (unsigned p = 0; p < 7; ++p) {
        const unsigned count = digits % 5; digits /= 5;
        if (count == 4) continue;
        const uint32_t code = ::ho[target_code + ::pw[p]].canonical;
        const auto found = by_code.find(code);
        if (found == by_code.end()) {
            State honor_only{}; honor_only.c[3] = code;
            require(!::safe(honor_only), "index omits a SAFE honor-only source");
            continue;
        }
        if (selected.count(found->second)) continue;
        int delete_power = -1;
        uint32_t source_digits = code;
        for (unsigned q = 0; q < 7; ++q) {
            const unsigned present = source_digits % 5; source_digits /= 5;
            if (present && ::ho[code - ::pw[q]].canonical == target_code) { delete_power = int(q); break; }
        }
        require(delete_power >= 0, "physical honor addition has no reverse deletion");
        selected.emplace(found->second, delete_power);
    }
    require(selected.size() <= 5, "more than five physically derived source buckets");
    std::vector<Source> result;
    for (auto [h, delete_power] : selected) result.push_back({h, delete_power});
    return result;
}

void mark_parent(const retro::Index& index, const retro::Bucket& target,
                 const State& parent, std::vector<u64>& marked_n) {
    ++deletion_candidates;
    const State canonical = ::canon(parent);
    const auto encoded = index.encode(canonical);
    if (encoded.second != target.h) throw std::runtime_error("physical deletion entered the wrong target honor bucket");
    const u64 rank = index.rank(target, encoded.first);
    if (rank >= target.size) throw std::runtime_error("SAFE child deletion missing from parent index " + ::repr(canonical));
    u64& word = marked_n[size_t(rank >> 6)];
    const u64 mask = u64(1) << (rank & 63);
    unique_n += !(word & mask);
    word |= mask;
}

struct BucketCounts { u64 p = 0, n = 0, states = 0; };
BucketCounts verify_bucket(retro::Index& index, const fs::path& directory, int n, int h) {
    check_budget();
    const auto began = Clock::now();
    const auto target = index.make_bucket(n, h);
    if (!target.size) return {};
    const Table pull(directory, index, target);
    std::vector<u64> marked_n(size_t((target.size + 63) / 64), 0);
    const u64 initial_visits = child_visits, initial_deletions = deletion_candidates, initial_unique = unique_n;
    const auto sources = sources_for(index, h);
    u64 used_source_buckets = 0;
    for (const Source source_spec : sources) {
        check_budget();
        const auto source = index.make_bucket(n + 1, source_spec.h);
        if (!source.size) continue;
        const Table children(directory, index, source);
        ++used_source_buckets;
        for (u64 wi = 0; wi < children.p_bits.size(); ++wi) {
            if ((wi & 1023) == 0) check_budget();
            u64 present_p = children.p_bits[size_t(wi)];
            while (present_p) {
                const unsigned bit = first_bit(present_p);
                present_p &= present_p - 1;
                const u64 child_rank = wi * 64 + bit;
                const auto child_ids = index.decode(source, child_rank);
                const State child = index.physical(child_ids, source.h);
                ++child_visits;
                if (source_spec.honor_delete_power >= 0) {
                    State parent = child;
                    parent.c[3] -= ::pw[source_spec.honor_delete_power];
                    mark_parent(index, target, parent, marked_n);
                } else {
                    // Every remaining numeric kind is considered physically,
                    // including duplicate canonical parents. Repeated marks
                    // have existential meaning and do not affect correctness.
                    for (unsigned suit = 0; suit < 3; ++suit) {
                        uint32_t digits = child.c[suit];
                        for (unsigned p = 0; p < 9; ++p) {
                            const unsigned count = digits % 5; digits /= 5;
                            if (!count) continue;
                            State parent = child; parent.c[suit] -= ::pw[p];
                            mark_parent(index, target, parent, marked_n);
                        }
                    }
                }
            }
        }
    }
    u64 p_count = 0;
    for (u64 wi = 0; wi < marked_n.size(); ++wi) {
        if ((wi & 65535) == 0) check_budget();
        const unsigned width = unsigned(std::min<u64>(64, target.size - wi * 64));
        const u64 pushed_p = ~marked_n[size_t(wi)] & low_mask(width);
        const u64 difference = pushed_p ^ pull.p_bits[size_t(wi)];
        if (difference) {
            const u64 rank = wi * 64 + first_bit(difference);
            const State state = index.physical(index.decode(target, rank), h);
            throw std::runtime_error("PUSH/PULL mismatch n=" + std::to_string(n) + " h=" + std::to_string(h) +
                " rank=" + std::to_string(rank) + " state=" + ::repr(state));
        }
        p_count += popcount(pushed_p);
    }
    require(p_count == pull.p_count && target.size - p_count == unique_n - initial_unique, "reverse aggregate mismatch");
    compared_states += target.size;
    ++completed_target_buckets;
    std::cout << "{\"kind\":\"push_bucket\",\"n\":" << n << ",\"h\":" << h
              << ",\"states_compared\":" << target.size << ",\"P\":" << p_count
              << ",\"N\":" << target.size - p_count << ",\"source_buckets\":" << used_source_buckets
              << ",\"P_child_visits\":" << child_visits - initial_visits
              << ",\"physical_deletions\":" << deletion_candidates - initial_deletions
              << ",\"seconds\":" << std::chrono::duration<double>(Clock::now() - began).count() << "}" << std::endl;
    return {p_count, target.size - p_count, target.size};
}
} // namespace push_check

int main(int argc, char** argv) {
    using namespace push_check;
    try {
        fs::path data;
        std::vector<int> layers{33, 32};
        int only_h = -1;
        for (int i = 1; i < argc; ++i) {
            const std::string arg = argv[i];
            auto value = [&]() { require(i + 1 < argc, "missing option value " + arg); return std::string(argv[++i]); };
            if (arg == "--data") data = fs::u8path(value());
            else if (arg == "--max-seconds") seconds_limit = std::stod(value());
            else if (arg == "--only-h") only_h = std::stoi(value());
            else if (arg == "--layers") {
                layers.clear(); std::istringstream input(value()); std::string item;
                while (std::getline(input, item, ',')) layers.push_back(std::stoi(item));
            } else throw std::runtime_error("unknown option " + arg);
        }
        require(!data.empty(), "--data is required");
        require(seconds_limit > 0 && seconds_limit <= 3600, "invalid time budget");
        require(!layers.empty(), "no layers requested");
        for (int n : layers) require(n >= 0 && n <= 34, "invalid layer");
        retro::Index index;
        require(only_h >= -1 && only_h < int(index.honors.size()), "invalid --only-h");
        check_budget();
        std::cout << "{\"kind\":\"push_start\",\"index_fingerprint\":" << quote(hex(index.fingerprint))
                  << ",\"max_seconds\":" << seconds_limit
                  << ",\"reference_direction\":\"physical child deletion; no Numeric.next or Honor.next\"}" << std::endl;
        for (int n : layers) {
            BucketCounts sums;
            for (int h = 0; h < int(index.honors.size()); ++h) {
                if (only_h >= 0 && h != only_h) continue;
                const auto checked = verify_bucket(index, data, n, h);
                sums.p += checked.p; sums.n += checked.n; sums.states += checked.states;
            }
            if (only_h < 0) require(sums.states == index.layer_size(n), "incomplete target-layer comparison");
            std::cout << "{\"kind\":\"push_layer\",\"n\":" << n << ",\"states_compared\":" << sums.states
                      << ",\"P\":" << sums.p << ",\"N\":" << sums.n << ",\"scope\":"
                      << quote(only_h < 0 ? "entire layer" : "selected honor bucket") << "}" << std::endl;
        }
        struct rusage usage{}; getrusage(RUSAGE_SELF, &usage);
        std::cout << "{\"status\":" << quote(only_h < 0 ? "PASS_ALL_REQUESTED_LAYERS" : "PASS_SELECTED_BUCKETS")
                  << ",\"states_compared\":" << compared_states << ",\"completed_target_buckets\":" << completed_target_buckets
                  << ",\"P_child_visits\":" << child_visits << ",\"physical_deletions\":" << deletion_candidates
                  << ",\"unique_N_marks\":" << unique_n << ",\"loaded_payload_bytes\":" << loaded_payload_bytes
                  << ",\"mismatches\":0,\"max_rss_kib\":" << usage.ru_maxrss
                  << ",\"seconds\":" << std::chrono::duration<double>(Clock::now() - push_started).count() << "}" << std::endl;
        return 0;
    } catch (const Budget& error) {
        struct rusage usage{}; getrusage(RUSAGE_SELF, &usage);
        std::cout << "{\"status\":\"UNKNOWN_BUDGET\",\"states_compared\":" << compared_states
                  << ",\"physical_deletions\":" << deletion_candidates
                  << ",\"max_rss_kib\":" << usage.ru_maxrss
                  << ",\"seconds\":" << std::chrono::duration<double>(Clock::now() - push_started).count()
                  << ",\"reason\":" << quote(error.what()) << "}" << std::endl;
        return 2;
    } catch (const Incomplete& error) {
        std::cout << "{\"status\":\"INCOMPLETE_TABLE\",\"states_compared\":" << compared_states << ",\"reason\":" << quote(error.what()) << "}" << std::endl;
        return 2;
    } catch (const std::exception& error) {
        std::cout << "{\"status\":\"FAIL\",\"states_compared\":" << compared_states << ",\"reason\":" << quote(error.what()) << "}" << std::endl;
        return 1;
    }
}
