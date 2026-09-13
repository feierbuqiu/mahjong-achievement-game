// Independent shallow validation of the physical one-bit global retrograde table.
// The reference recursion uses the original solver's full State keys and moves;
// it never reads the generated P/N table to decide a reference outcome.
#include "global_index.hpp"
#include <filesystem>
#include <regex>
#include <set>
#include <limits>
#include <iomanip>
#include <memory>
#include <random>

namespace fs = std::filesystem;
namespace verification {

struct BudgetExceeded : std::runtime_error { using std::runtime_error::runtime_error; };
struct Incomplete : std::runtime_error { using std::runtime_error::runtime_error; };
using IDs = std::array<uint32_t, 3>;
const auto process_start = Clock::now();
double max_seconds = 60;
uint64_t reference_calls = 0, memo_resets = 0, checked_states = 0;
uint64_t checked_edges = 0, p_checked = 0, n_checked = 0;
std::unordered_map<State, bool, Hash> reference_memo;

void require(bool yes, const std::string& message) {
    if (!yes) throw std::runtime_error(message);
}
void budget() {
    if (std::chrono::duration<double>(Clock::now() - process_start).count() > max_seconds)
        throw BudgetExceeded("time budget exhausted; remaining checks UNKNOWN");
}
std::string quoted(const std::string& s) {
    std::string r = "\"";
    for (unsigned char c : s) {
        if (c == '\\' || c == '"') { r += '\\'; r += char(c); }
        else if (c == '\n') r += "\\n";
        else if (c == '\r') r += "\\r";
        else if (c == '\t') r += "\\t";
        else if (c >= 32) r += char(c);
    }
    return r + "\"";
}
int tiles(const State& s) {
    int n = 0;
    for (uint32_t code : s.c) for (; code; code /= 5) n += code % 5;
    return n;
}

bool reference_p(const State& s, unsigned depth = 0) {
    if ((++reference_calls & 255) == 0) budget();
    if (depth > 6) throw BudgetExceeded("unexpected shallow recursion depth; no outcome committed");
    const auto found = reference_memo.find(s);
    if (found != reference_memo.end()) return found->second;
    require(::safe(s), "unsafe state in reference recursion " + ::repr(s));
    const auto children = ::moves(s);
    for (const State& t : children) {
        require(tiles(t) == tiles(s) + 1, "baseline edge does not add one tile");
        if (reference_p(t, depth + 1)) {
            reference_memo.emplace(s, false);
            return false;
        }
    }
    reference_memo.emplace(s, true);
    return true;
}

std::string read_text(const fs::path& filename) {
    std::ifstream input(filename, std::ios::binary);
    require(bool(input), "cannot open completion record: " + filename.string());
    return std::string(std::istreambuf_iterator<char>(input), std::istreambuf_iterator<char>());
}
std::string property(const std::string& json, const std::string& name, const std::string& value_regex) {
    const std::regex expression("\\\"" + name + "\\\"\\s*:\\s*(" + value_regex + ")\\s*(?=[,}])");
    std::sregex_iterator begin(json.begin(), json.end(), expression), end;
    require(begin != end, "missing or malformed completion property " + name);
    const std::string value = (*begin)[1].str();
    require(++begin == end, "duplicate completion property " + name);
    return value;
}
uint64_t number_property(const std::string& json, const std::string& name) {
    return std::stoull(property(json, name, "[0-9]+"));
}
std::string string_property(const std::string& json, const std::string& name) {
    const auto value = property(json, name, "\\\"[^\\\"\\\\]*\\\"");
    return value.substr(1, value.size() - 2);
}
std::string fingerprint_text(const retro::Index& index) {
    std::ostringstream out; out << std::hex << std::setw(16) << std::setfill('0') << index.fingerprint;
    return out.str();
}
std::string stem(int n, int h) {
    std::ostringstream s;
    s << 'n' << std::setw(2) << std::setfill('0') << n << "_h" << std::setw(3) << h;
    return s.str();
}
uint64_t popcount(uint64_t x) {
#ifdef __GNUC__
    return __builtin_popcountll(x);
#else
    uint64_t n = 0; for (; x; x &= x - 1) ++n; return n;
#endif
}
struct BitTable {
    std::vector<uint64_t> words;
    uint64_t size = 0;
    BitTable(const fs::path& directory, const retro::Index& index, const retro::Bucket& bucket) {
        size = bucket.size;
        if (!size) return;
        const std::string base = stem(bucket.n, bucket.h);
        const fs::path complete = directory / (base + ".complete.json");
        if (!fs::exists(complete)) throw Incomplete("missing complete record " + complete.string());
        const std::string json = read_text(complete);
        require(string_property(json, "schema") == "MJGLOBAL_PN_V1", "wrong table schema " + base);
        require(property(json, "completed", "true|false") == "true", "bucket not completed " + base);
        const std::string fingerprint = string_property(json, "index_fingerprint");
        require(!fingerprint.empty() && fingerprint.size() <= 16 &&
                fingerprint.find_first_not_of("0123456789abcdefABCDEF") == std::string::npos &&
                std::stoull(fingerprint, nullptr, 16) == index.fingerprint, "index fingerprint mismatch " + base);
        require(number_property(json, "n") == uint64_t(bucket.n), "layer mismatch " + base);
        require(number_property(json, "h") == uint64_t(bucket.h), "honor ID mismatch " + base);
        require(number_property(json, "honor_code") == index.honors.at(bucket.h).code, "honor code mismatch " + base);
        require(number_property(json, "states") == size, "state count mismatch " + base);
        const uint64_t count = (size + 63) / 64;
        require(number_property(json, "word_count") == count, "word count mismatch " + base);
        const fs::path filename = directory / (base + ".bits");
        require(fs::exists(filename) && fs::file_size(filename) == count * 8, "payload length mismatch " + base);
        words.resize(size_t(count));
        std::ifstream input(filename, std::ios::binary);
        require(bool(input.read(reinterpret_cast<char*>(words.data()), std::streamsize(count * 8))), "payload read failure " + base);
        const uint16_t endian_probe = 1;
        if (*reinterpret_cast<const uint8_t*>(&endian_probe) != 1) {
            for (auto& w : words) {
                uint64_t r = 0; for (int j = 0; j < 8; ++j) r = (r << 8) | ((w >> (8 * j)) & 255);
                w = r;
            }
        }
        if (size % 64) require((words.back() >> (size % 64)) == 0, "nonzero padding bits " + base);
        uint64_t p = 0, hash = 1469598103934665603ULL;
        for (uint64_t w : words) { p += popcount(w); hash ^= w; hash *= 1099511628211ULL; }
        require(number_property(json, "p_states") == p, "P popcount mismatch " + base);
        const std::string recorded_hash = string_property(json, "payload_hash64");
        require(!recorded_hash.empty() && recorded_hash.size() <= 16 &&
                recorded_hash.find_first_not_of("0123456789abcdefABCDEF") == std::string::npos &&
                std::stoull(recorded_hash, nullptr, 16) == hash, "payload word hash mismatch " + base);
    }
    bool is_p(uint64_t rank) const {
        require(rank < size, "table query out of bounds");
        return (words[size_t(rank / 64)] >> (rank % 64)) & 1;
    }
};

// Only child buckets of a single parent are retained. A physical honor
// histogram has at most four honor successors, plus its unchanged bucket.
struct ChildBuckets {
    retro::Index& index;
    int n;
    std::map<int, std::unique_ptr<retro::Bucket>> buckets;
    ChildBuckets(retro::Index& i, int child_layer) : index(i), n(child_layer) {}
    const retro::Bucket& get(int h) {
        auto it = buckets.find(h);
        if (it != buckets.end()) return *it->second;
        require(buckets.size() < 5, "more than five child honor buckets");
        auto value = std::make_unique<retro::Bucket>(index.make_bucket(n, h));
        return *buckets.emplace(h, std::move(value)).first->second;
    }
};
State check_roundtrip(retro::Index& index, const retro::Bucket& bucket, uint64_t rank, const IDs& cursor_ids) {
    const IDs decoded = index.decode(bucket, rank);
    require(decoded == cursor_ids, "cursor/decode mismatch");
    const State s = ::canon(index.physical(decoded, bucket.h));
    require(tiles(s) == bucket.n, "indexed state has wrong tile count");
    require(::safe(s), "index accepted unsafe state " + ::repr(s));
    const auto encoded = index.encode(s);
    require(encoded.second == bucket.h && encoded.first == decoded, "physical encode/decode mismatch");
    require(index.rank(bucket, encoded.first) == rank, "physical roundtrip rank mismatch");
    require(index.rank_sorted(bucket, decoded) == rank, "sorted rank mismatch");
    return s;
}
bool check_one(retro::Index& index, const retro::Bucket& bucket, uint64_t rank, const IDs& ids,
               ChildBuckets& child_buckets, const BitTable* table) {
    if ((checked_states & 255) == 0) budget();
    const State s = check_roundtrip(index, bucket, rank, ids);
    const auto children = ::moves(s);
    if (bucket.n == 34) require(children.empty(), "34-tile state has SAFE successor " + ::repr(s));
    for (const State& t : children) {
        ++checked_edges;
        require(tiles(t) == bucket.n + 1, "baseline successor size mismatch");
        const auto encoded = index.encode(t);
        const auto& target = child_buckets.get(encoded.second);
        const uint64_t r = index.rank(target, encoded.first);
        require(r < target.size, "baseline SAFE successor absent from index " + ::repr(t));
        require(::canon(index.physical(index.decode(target, r), encoded.second)) == t,
                "child rank/decode physical mismatch " + ::repr(t));
    }
    if (bucket.n < 34) {
        std::set<std::array<uint32_t, 4>> expected_children, indexed_children;
        for (const auto& t : children) expected_children.insert(t.c);
        auto insert_if_valid = [&](IDs next_ids, int next_h) {
            const auto& target = child_buckets.get(next_h);
            const uint64_t child_rank = index.rank(target, next_ids);
            if (child_rank < target.size) indexed_children.insert(::canon(index.physical(next_ids, next_h)).c);
        };
        for (int suit = 0; suit < 3; ++suit) {
            const auto& local = index.numeric[ids[suit]];
            for (unsigned j = 0; j < local.next_count; ++j) {
                auto next = ids; next[suit] = local.next[j];
                insert_if_valid(next, bucket.h);
            }
        }
        const auto& honor = index.honors[bucket.h];
        for (unsigned j = 0; j < honor.next_count; ++j) insert_if_valid(ids, honor.next[j]);
        require(indexed_children == expected_children, "indexed/baseline complete successor sets differ " + ::repr(s));
    }
    if (reference_memo.size() > 250000) { reference_memo.clear(); ++memo_resets; }
    const bool expected = bucket.n == 34 ? true : reference_p(s);
    if (table) require(table->is_p(rank) == expected,
        "P/N mismatch n=" + std::to_string(bucket.n) + " h=" + std::to_string(bucket.h) +
        " rank=" + std::to_string(rank) + " state=" + ::repr(s));
    ++checked_states;
    if (expected) ++p_checked; else ++n_checked;
    return expected;
}

struct BucketPlan {
    int h;
    uint64_t size;
    std::set<uint64_t> selected;
};
uint64_t expected_layer_size(int n) {
    if (n == 34) return 587901;
    if (n == 33) return 21924455;
    if (n == 32) return 280542509;
    throw std::runtime_error("only 34, 33, 32 are supported by the bounded checker");
}
void verify_layer(retro::Index& index, int n, uint64_t sample_count, uint64_t seed,
                  const fs::path& data, bool index_only, bool allow_incomplete) {
    budget();
    const auto layer_start = Clock::now();
    const uint64_t old_checked = checked_states, old_p = p_checked, old_n = n_checked;
    std::vector<BucketPlan> plans;
    std::vector<uint64_t> ends;
    uint64_t total = 0;
    for (int h = 0; h < int(index.honors.size()); ++h) {
        budget();
        const auto bucket = index.make_bucket(n, h);
        total += bucket.size;
        if (!bucket.size) continue;
        BucketPlan plan{h, bucket.size, {0, bucket.size - 1}};
        // Stratified first/last block ranks expose cursor block-boundary errors.
        const size_t block_samples = std::min<size_t>(8, bucket.blocks.size());
        for (size_t j = 0; j < block_samples; ++j) {
            const auto& b = bucket.blocks[j * bucket.blocks.size() / block_samples];
            plan.selected.insert(b.offset);
            plan.selected.insert(b.offset + b.size - 1);
        }
        plans.push_back(std::move(plan));
        ends.push_back(total);
    }
    require(total == expected_layer_size(n), "layer cardinality differs from immutable independent count");
    std::mt19937_64 generator(seed ^ uint64_t(n));
    if (n != 34) for (uint64_t j = 0; j < sample_count; ++j) {
        const uint64_t global_rank = generator() % total;
        const size_t k = std::upper_bound(ends.begin(), ends.end(), global_rank) - ends.begin();
        const uint64_t offset = k ? ends[k - 1] : 0;
        plans[k].selected.insert(global_rank - offset);
    }
    uint64_t completed_buckets = 0, missing_buckets = 0;
    for (const auto& plan : plans) {
        budget();
        const auto bucket = index.make_bucket(n, plan.h);
        std::unique_ptr<BitTable> table;
        if (!index_only) {
            try { table = std::make_unique<BitTable>(data, index, bucket); }
            catch (const Incomplete&) { if (!allow_incomplete) throw; ++missing_buckets; continue; }
        }
        ChildBuckets children(index, n + 1);
        if (n == 34) {
            auto cursor = index.cursor(bucket, 0);
            for (uint64_t r = 0; r < bucket.size; ++r) {
                check_one(index, bucket, r, cursor.ids, children, table.get());
                if (r + 1 < bucket.size) cursor.advance();
            }
        } else {
            for (uint64_t r : plan.selected) {
                auto cursor = index.cursor(bucket, r);
                check_one(index, bucket, r, cursor.ids, children, table.get());
                if (r + 1 < bucket.size) {
                    cursor.advance();
                    require(cursor.ids == index.decode(bucket, r + 1), "sampled cursor advance mismatch");
                }
            }
        }
        ++completed_buckets;
    }
    std::cout << "{\"kind\":\"layer_verification\",\"n\":" << n
              << ",\"scope\":" << quoted(n == 34 ? "exhaustive" : "seeded samples plus bucket/block boundaries")
              << ",\"layer_states\":" << total << ",\"checked_states\":" << checked_states - old_checked
              << ",\"P_checked\":" << p_checked - old_p << ",\"N_checked\":" << n_checked - old_n
              << ",\"complete_buckets_checked\":" << completed_buckets << ",\"missing_buckets\":" << missing_buckets
              << ",\"table_bits_compared\":" << (index_only ? "false" : "true")
              << ",\"seconds\":" << std::chrono::duration<double>(Clock::now() - layer_start).count() << "}" << std::endl;
}

} // namespace verification

int main(int argc, char** argv) {
    using namespace verification;
    try {
        fs::path data;
        uint64_t samples = 1000, seed = 0x6d61686a6f6e6739ULL;
        std::vector<int> layers{34, 33, 32};
        bool index_only = false, allow_incomplete = false;
        for (int i = 1; i < argc; ++i) {
            const std::string arg = argv[i];
            auto value = [&]() { require(i + 1 < argc, "missing value for " + arg); return std::string(argv[++i]); };
            if (arg == "--data") data = value();
            else if (arg == "--max-seconds") max_seconds = std::stod(value());
            else if (arg == "--samples") samples = std::stoull(value());
            else if (arg == "--seed") seed = std::stoull(value());
            else if (arg == "--index-only") index_only = true;
            else if (arg == "--allow-incomplete") allow_incomplete = true;
            else if (arg == "--layers") {
                layers.clear(); std::istringstream input(value()); std::string item;
                while (std::getline(input, item, ',')) layers.push_back(std::stoi(item));
            } else throw std::runtime_error("unknown argument " + arg);
        }
        require(max_seconds > 0 && max_seconds <= 3600, "invalid time budget");
        require(index_only || !data.empty(), "--data is required unless --index-only");
        for (int n : layers) expected_layer_size(n);
        retro::Index index;
        budget();
        std::cout << "{\"kind\":\"verification_start\",\"index_fingerprint\":" << quoted(fingerprint_text(index))
                  << ",\"max_seconds\":" << max_seconds << ",\"random_samples_per_layer\":" << samples
                  << ",\"seed\":" << seed << ",\"reference\":\"original safe/moves, complete State-key memo, no P/N leaf table\"}" << std::endl;
        reference_memo.reserve(262144);
        for (int n : layers) verify_layer(index, n, samples, seed, data, index_only, allow_incomplete);
        struct rusage usage{}; getrusage(RUSAGE_SELF, &usage);
        std::cout << "{\"status\":" << quoted(index_only ? "PASS_INDEX_AND_REFERENCE_ONLY" : allow_incomplete ? "PASS_COMPLETED_BUCKETS_ONLY" : "PASS")
                  << ",\"checked_states\":" << checked_states << ",\"P_checked\":" << p_checked
                  << ",\"N_checked\":" << n_checked << ",\"checked_indexed_edges\":" << checked_edges
                  << ",\"reference_calls\":" << reference_calls << ",\"reference_memo_entries\":" << reference_memo.size()
                  << ",\"memo_resets\":" << memo_resets << ",\"mismatches\":0,\"payload_hash64_checked\":" << (index_only ? "false" : "true")
                  << ",\"payload_sha256_checked\":false"
                  << ",\"max_rss_kib\":" << usage.ru_maxrss
                  << ",\"seconds\":" << std::chrono::duration<double>(Clock::now() - process_start).count() << "}" << std::endl;
        return 0;
    } catch (const BudgetExceeded& error) {
        std::cout << "{\"status\":\"UNKNOWN_BUDGET\",\"checked_states\":" << checked_states << ",\"reason\":" << quoted(error.what()) << "}" << std::endl;
        return 2;
    } catch (const Incomplete& error) {
        std::cout << "{\"status\":\"INCOMPLETE_TABLE\",\"checked_states\":" << checked_states << ",\"reason\":" << quoted(error.what()) << "}" << std::endl;
        return 2;
    } catch (const std::exception& error) {
        std::cout << "{\"status\":\"FAIL\",\"checked_states\":" << checked_states << ",\"reason\":" << quoted(error.what()) << "}" << std::endl;
        return 1;
    }
}
