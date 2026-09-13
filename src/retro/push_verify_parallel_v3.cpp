// Parallel verifier v3: bounded Win32 atomic-replacement retries and explicit
// audited compatibility with frozen v2 records. The physical kernel is unchanged.
// Bounded parallel physical-delete verifier. The v2 single-thread checker is
// included only to reuse its already tested read-only table loader and source
// histogram derivation. Its main is renamed; its hot loop is not called.
#include "global_index.hpp"
#define main frozen_single_thread_push_main
#include "push_verify.cpp"
#undef main
#include <atomic>
#include <thread>
#include <mutex>
#include <csignal>
#include <cstdio>
#include <ctime>
#include <cmath>
#include <functional>
#ifdef _WIN32
#include <io.h>
#else
#include <unistd.h>
#endif

namespace parallel_check {
using u64 = uint64_t;
using push_check::quote;
using push_check::hex;
using push_check::stem;
static constexpr const char* RECORD_SCHEMA = "MJGLOBAL_PUSH_VERIFY_V1";
static constexpr const char* COMPATIBLE_V2_BUILD = "9ff1b21b0583625f9ac98c69e4d265d461b5f4a33fdf2e51a85276bb348db20c";
// This identifier is tied to the exact source/component comparison manifest.
static constexpr const char* COMPATIBILITY_AUDIT = "MJGLOBAL_V2_V3_UNCHANGED_CORE_V1";
static std::atomic<bool> signal_stop{false};
static void handle_signal(int) { signal_stop.store(true, std::memory_order_relaxed); }

struct Options {
    fs::path data, verified_dir = "runs/global_retro/parallel_verification", stop_file, progress_file;
    std::string build_id, compatible_build_id;
    std::vector<int> layers{33, 32};
    int threads = 16, only_h = -1;
    double seconds = 60;
    u64 deadline_epoch = 0, memory_limit = 15500000000ULL, source_chunk_words = 4096;
    bool resume = true;
};
struct Limit : std::runtime_error { using std::runtime_error::runtime_error; };
struct Stats {
    u64 verified_states = 0, new_buckets = 0, reused_buckets = 0, reused_states = 0;
    std::atomic<u64> child_visits{0}, deletions{0}, new_n_marks{0};
};
u64 private_bytes() {
#ifdef _WIN32
    PROCESS_MEMORY_COUNTERS_EX info{}; info.cb = sizeof(info);
    if (GetProcessMemoryInfo(GetCurrentProcess(), reinterpret_cast<PROCESS_MEMORY_COUNTERS*>(&info), sizeof(info))) return info.PrivateUsage;
    throw std::runtime_error("cannot read process memory usage");
#else
    struct rusage usage{}; getrusage(RUSAGE_SELF, &usage);
    return u64(usage.ru_maxrss) * 1024;
#endif
}
class Limits {
    const Options& options;
    const Clock::time_point began;
    std::function<void()> progress_tick;
public:
    explicit Limits(const Options& o, Clock::time_point start = Clock::now()) : options(o), began(start) {}
    void on_check(std::function<void()> callback) { progress_tick = std::move(callback); }
    double elapsed() const { return std::chrono::duration<double>(Clock::now() - began).count(); }
    void check() const {
        if (progress_tick) progress_tick(); // Called only by the existing main thread.
        check_without_progress();
    }
    void check_without_progress() const {
        if (signal_stop.load(std::memory_order_relaxed)) throw Limit("signal");
        if (!options.stop_file.empty() && fs::exists(options.stop_file)) throw Limit("stop file");
        if (elapsed() >= options.seconds) throw Limit("time budget");
        if (options.deadline_epoch && u64(std::time(nullptr)) >= options.deadline_epoch) throw Limit("UTC deadline");
        if (private_bytes() > options.memory_limit) throw Limit("memory limit");
    }
    void reserve(u64 bytes) const {
        check();
        const u64 used = private_bytes(), margin = 64ULL << 20;
        if (used > options.memory_limit || bytes > options.memory_limit - used ||
            margin > options.memory_limit - used - bytes) throw Limit("memory reservation would exceed limit");
    }
};
struct Input {
    int n = 0, h = 0;
    u64 states = 0, p = 0, hash = 0;
};
Input identity(const retro::Bucket& bucket, const push_check::Table& table, const Limits& limits) {
    u64 hash = 1469598103934665603ULL;
    for (size_t j = 0; j < table.p_bits.size(); ++j) {
        if ((j & ((1U << 20) - 1)) == 0) limits.check();
        hash ^= table.p_bits[j]; hash *= 1099511628211ULL;
    }
    return {bucket.n, bucket.h, bucket.size, table.p_count, hash};
}
u64 input_signature(std::vector<Input> inputs) {
    std::sort(inputs.begin(), inputs.end(), [](const Input& a, const Input& b) {
        return std::tie(a.n, a.h) < std::tie(b.n, b.h);
    });
    u64 hash = 14695981039346656037ULL;
    for (const auto& in : inputs) for (u64 value : {u64(in.n), u64(in.h), in.states, in.p, in.hash})
        for (unsigned byte = 0; byte < 8; ++byte) { hash ^= uint8_t(value); hash *= 1099511628211ULL; value >>= 8; }
    return hash;
}
retro::Bucket make_bucket(const retro::Index& index, int n, int h, const Limits& limits) {
    if (index.bucket_size(n, h)) limits.reserve(index.triple_count() * (sizeof(u64) + sizeof(retro::Block)));
    return index.make_bucket(n, h);
}
push_check::Table load(const Options& options, const retro::Index& index, const retro::Bucket& bucket, const Limits& limits) {
    limits.reserve(((bucket.size + 63) / 64) * sizeof(u64));
    push_check::Table result(options.data, index, bucket);
    limits.check();
    return result;
}
std::string read_file(const fs::path& path) {
    std::ifstream input(path, std::ios::binary);
    if (!input) throw std::runtime_error("cannot read " + path.u8string());
    return std::string(std::istreambuf_iterator<char>(input), {});
}
void publish_record(const fs::path& path, const std::string& content, const Limits* limits = nullptr) {
    if (!path.parent_path().empty()) fs::create_directories(path.parent_path());
    auto temporary = path; temporary += ".tmp";
#ifdef _WIN32
    FILE* file = _wfopen(temporary.c_str(), L"wb");
#else
    FILE* file = std::fopen(temporary.c_str(), "wb");
#endif
    if (!file) throw std::runtime_error("cannot create verification record");
    if (std::fwrite(content.data(), 1, content.size(), file) != content.size() || std::fflush(file)) {
        std::fclose(file); throw std::runtime_error("verification record write failed");
    }
#ifdef _WIN32
    const int synced = _commit(_fileno(file));
#else
    const int synced = fsync(fileno(file));
#endif
    std::fclose(file);
    if (synced) throw std::runtime_error("verification record sync failed");
#ifdef _WIN32
    const auto retry_started = Clock::now();
    unsigned attempts = 0;
    DWORD first_error = 0, last_error = 0;
    auto diagnostic = [&] {
        return std::string("atomic replacement failed: GetLastError=") + std::to_string(last_error) +
            " first_error=" + std::to_string(first_error) + " attempts=" + std::to_string(attempts) +
            " retry_ms=" + std::to_string(std::chrono::duration_cast<std::chrono::milliseconds>(Clock::now() - retry_started).count()) +
            " path=" + path.u8string();
    };
    for (;;) {
        ++attempts;
        if (MoveFileExW(temporary.c_str(), path.c_str(), MOVEFILE_REPLACE_EXISTING | MOVEFILE_WRITE_THROUGH)) {
            if (attempts > 1) std::cout << "{\"kind\":\"atomic_replace_recovered\",\"path\":" << quote(path.u8string())
                << ",\"attempts\":" << attempts << ",\"first_win32_error\":" << first_error
                << ",\"last_win32_error\":" << last_error << ",\"retry_ms\":"
                << std::chrono::duration_cast<std::chrono::milliseconds>(Clock::now() - retry_started).count() << "}" << std::endl;
            break;
        }
        last_error = GetLastError(); // Capture immediately, before any other call.
        if (!first_error) first_error = last_error;
        if (attempts == 1) std::cout << "{\"kind\":\"atomic_replace_retry\",\"path\":" << quote(path.u8string())
            << ",\"win32_error\":" << last_error << "}" << std::endl;
        const bool retryable = last_error == ERROR_SHARING_VIOLATION || last_error == ERROR_LOCK_VIOLATION || last_error == ERROR_ACCESS_DENIED;
        if (!retryable || Clock::now() - retry_started >= std::chrono::seconds(2)) throw std::runtime_error(diagnostic());
        if (limits) try { limits->check_without_progress(); }
        catch (const Limit& error) { throw Limit(std::string(error.what()) + " during " + diagnostic()); }
        std::this_thread::sleep_for(std::chrono::milliseconds(20));
    }
#else
    fs::rename(temporary, path);
#endif
}

// This has no background thread. The existing main-thread limit polling calls
// tick(), and phase transitions publish immediately. Synchronous source I/O can
// delay the next heartbeat; the external controller still measures engine time.
class Progress {
    const Options& options;
    const Limits& limits;
    const Stats& stats;
    double last_write = -10;
    int n = -1, h = -1, source_h = -1;
    std::string phase = "starting", status = "RUNNING", reason;
    bool final = false;
public:
    Progress(const Options& o, const Limits& l, const Stats& s) : options(o), limits(l), stats(s) {}
    void write(bool force = false) {
        if (options.progress_file.empty() || (!force && limits.elapsed() - last_write < 10)) return;
        std::ostringstream out;
        out << "{\"schema\":\"MJGLOBAL_PUSH_PROGRESS_V2\",\"verified_states\":" << stats.verified_states
            << ",\"new_verified_states\":" << stats.verified_states - stats.reused_states
            << ",\"reused_verified_states\":" << stats.reused_states
            << ",\"physical_deletions\":" << stats.deletions.load(std::memory_order_relaxed)
            << ",\"P_child_visits\":" << stats.child_visits.load(std::memory_order_relaxed)
            << ",\"new_verified_buckets\":" << stats.new_buckets << ",\"reused_verified_buckets\":" << stats.reused_buckets
            << ",\"elapsed\":" << limits.elapsed() << ",\"n\":" << n << ",\"h\":" << h << ",\"source_h\":" << source_h
            << ",\"phase\":" << quote(phase) << ",\"status\":" << quote(status) << ",\"reason\":" << quote(reason)
            << ",\"final\":" << (final ? "true" : "false") << ",\"build_id\":" << quote(options.build_id) << "}\n";
        try { publish_record(options.progress_file, out.str(), &limits); }
        catch (const Limit&) { throw; }
        catch (const std::exception& error) { throw std::runtime_error(std::string("progress write failed: ") + error.what()); }
        last_write = limits.elapsed();
    }
    void stage(std::string value, int layer, int honor, int source = -1) {
        phase = std::move(value); n = layer; h = honor; source_h = source; write(true);
    }
    void finish(const std::string& value, const std::string& explanation = {}) {
        status = value; reason = explanation; final = true;
        phase = value.rfind("PASS_", 0) == 0 ? "complete" : value == "UNKNOWN_LIMIT" ? "stopped" : "failed";
        write(true);
    }
};

// Every marking operation has existential meaning. fetch_or is atomic even
// when two worker threads reach different parent bits in the same uint64 word.
inline void mark(const retro::Index& index, const retro::Bucket& target, const State& parent,
                 std::atomic<u64>* marked_n, u64& fresh) {
    const auto encoded = index.encode(::canon(parent));
    if (encoded.second != target.h) throw std::runtime_error("physical deletion changed target honor bucket");
    const u64 rank = index.rank(target, encoded.first);
    if (rank >= target.size) throw std::runtime_error("deleted SAFE parent missing from index " + ::repr(parent));
    const u64 mask = u64(1) << (rank & 63);
    const u64 before = marked_n[rank >> 6].fetch_or(mask, std::memory_order_relaxed);
    fresh += !(before & mask);
}

void push_source(const Options& options, const retro::Index& index,
                 const retro::Bucket& target, const retro::Bucket& source,
                 const push_check::Table& table, int honor_delete_power,
                 std::atomic<u64>* marked_n, Limits& limits, Stats& stats) {
    if (!table.p_count) return;
    std::atomic<u64> next_word{0};
    std::atomic<int> running{options.threads};
    std::atomic<bool> stop{false};
    std::exception_ptr failure;
    std::mutex failure_mutex;
    std::vector<std::thread> workers;
    auto worker = [&] {
        u64 visits = 0, deletions = 0, fresh = 0;
        try {
            for (;;) {
                if (stop.load(std::memory_order_relaxed)) break;
                const u64 first = next_word.fetch_add(options.source_chunk_words, std::memory_order_relaxed);
                if (first >= table.p_bits.size()) break;
                const u64 last = std::min<u64>(table.p_bits.size(), first + options.source_chunk_words);
                for (u64 wi = first; wi < last; ++wi) {
                    if (stop.load(std::memory_order_relaxed)) break;
                    u64 remaining = table.p_bits[size_t(wi)];
                    while (remaining) {
                        const unsigned bit = __builtin_ctzll(remaining); remaining &= remaining - 1;
                        const auto ids = index.decode(source, wi * 64 + bit);
                        const State child = index.physical(ids, source.h);
                        ++visits;
                        if (honor_delete_power >= 0) {
                            State parent = child; parent.c[3] -= ::pw[honor_delete_power];
                            mark(index, target, parent, marked_n, fresh); ++deletions;
                        } else {
                            for (unsigned suit = 0; suit < 3; ++suit) {
                                uint32_t digits = child.c[suit];
                                for (unsigned p = 0; p < 9; ++p) {
                                    const unsigned count = digits % 5; digits /= 5;
                                    if (!count) continue;
                                    State parent = child; parent.c[suit] -= ::pw[p];
                                    mark(index, target, parent, marked_n, fresh); ++deletions;
                                }
                            }
                        }
                    }
                }
                stats.child_visits.fetch_add(visits, std::memory_order_relaxed); visits = 0;
                stats.deletions.fetch_add(deletions, std::memory_order_relaxed); deletions = 0;
                stats.new_n_marks.fetch_add(fresh, std::memory_order_relaxed); fresh = 0;
            }
        } catch (...) {
            std::lock_guard<std::mutex> lock(failure_mutex);
            if (!failure) failure = std::current_exception();
            stop.store(true, std::memory_order_relaxed);
        }
        stats.child_visits.fetch_add(visits, std::memory_order_relaxed);
        stats.deletions.fetch_add(deletions, std::memory_order_relaxed);
        stats.new_n_marks.fetch_add(fresh, std::memory_order_relaxed);
        running.fetch_sub(1, std::memory_order_release);
    };
    try {
        for (int t = 0; t < options.threads; ++t) workers.emplace_back(worker);
    } catch (...) {
        stop.store(true, std::memory_order_relaxed);
        for (auto& thread : workers) thread.join();
        throw;
    }
    std::exception_ptr limit_failure;
    double last_report = limits.elapsed();
    while (running.load(std::memory_order_acquire)) {
        if (!limit_failure) try { limits.check(); } catch (...) {
            limit_failure = std::current_exception(); stop.store(true, std::memory_order_relaxed);
        }
        if (!limit_failure && limits.elapsed() - last_report >= 10) try {
                std::cout << "{\"kind\":\"parallel_push_progress\",\"n\":" << target.n << ",\"h\":" << target.h
                          << ",\"source_h\":" << source.h << ",\"elapsed\":" << limits.elapsed()
                          << ",\"verified_states\":" << stats.verified_states << ",\"physical_deletions\":" << stats.deletions.load()
                          << ",\"private_bytes\":" << private_bytes() << "}" << std::endl;
                last_report = limits.elapsed();
            } catch (...) {
                limit_failure = std::current_exception(); stop.store(true, std::memory_order_relaxed);
            }
        std::this_thread::sleep_for(std::chrono::milliseconds(50));
    }
    for (auto& thread : workers) thread.join();
    if (failure) std::rethrow_exception(failure);
    if (limit_failure) std::rethrow_exception(limit_failure);
    limits.check();
}

bool reusable_record(const Options& options, const retro::Index& index, const retro::Bucket& target,
                     const fs::path& record, Limits& limits, Progress& progress, std::string& reused_build) {
    if (!options.resume || !fs::exists(record)) return false;
    const auto json = read_file(record);
    const auto record_build = push_check::text_property(json, "build_id");
    const bool accepted_build = record_build == options.build_id ||
        (options.compatible_build_id == COMPATIBLE_V2_BUILD && record_build == COMPATIBLE_V2_BUILD);
    if (push_check::text_property(json, "schema") != RECORD_SCHEMA ||
        push_check::property(json, "completed", "true|false") != "true" ||
        push_check::text_property(json, "status") != "VERIFIED_EQUAL" ||
        !accepted_build ||
        push_check::text_property(json, "index_fingerprint") != hex(index.fingerprint) ||
        push_check::number_property(json, "n") != u64(target.n) ||
        push_check::number_property(json, "h") != u64(target.h) ||
        push_check::number_property(json, "honor_code") != index.honors[target.h].code ||
        push_check::number_property(json, "states") != target.size) return false;
    // Rehash actual input payloads before accepting a previous equality proof.
    // Metadata alone is insufficient when an old .bits file was corrupted.
    std::vector<Input> inputs;
    {
        progress.stage("resume_read_parent", target.n, target.h);
        const auto table = load(options, index, target, limits);
        inputs.push_back(identity(target, table, limits));
    }
    for (const auto spec : push_check::sources_for(index, target.h)) {
        progress.stage("resume_read_source", target.n, target.h, spec.h);
        const auto source = make_bucket(index, target.n + 1, spec.h, limits);
        if (!source.size) continue;
        const auto table = load(options, index, source, limits);
        inputs.push_back(identity(source, table, limits));
    }
    const bool accepted_inputs = push_check::text_property(json, "input_signature") == hex(input_signature(inputs));
    if (accepted_inputs) reused_build = record_build;
    return accepted_inputs;
}

void verify_bucket(const Options& options, retro::Index& index, int n, int h, Limits& limits, Stats& stats, Progress& progress) {
    if (!index.bucket_size(n, h)) return;
    progress.stage("build_parent_directory", n, h);
    const auto target = make_bucket(index, n, h, limits);
    if (!target.size) return;
    const auto record = options.verified_dir / (stem(n, h) + ".verified.json");
    std::string reused_build;
    if (reusable_record(options, index, target, record, limits, progress, reused_build)) {
        stats.verified_states += target.size; stats.reused_states += target.size; ++stats.reused_buckets;
        progress.stage("reused_verified_bucket", n, h);
        std::cout << "{\"kind\":\"reused_verified_bucket\",\"n\":" << n << ",\"h\":" << h << ",\"states\":" << target.size
                  << ",\"original_build_id\":" << quote(reused_build) << ",\"verifier_build_id\":" << quote(options.build_id)
                  << ",\"compatibility_audit\":" << quote(reused_build == options.build_id ? "" : COMPATIBILITY_AUDIT) << "}" << std::endl;
        return;
    }
    if (fs::exists(record)) throw std::runtime_error("existing verification record was not accepted; preserve it and choose a new record directory or the audited compatible build ID");
    const double bucket_start = limits.elapsed();
    const u64 first_deletions = stats.deletions.load(), first_visits = stats.child_visits.load();
    const u64 first_n = stats.new_n_marks.load();
    const u64 word_count = (target.size + 63) / 64;
    progress.stage("initialize_parent_marks", n, h);
    limits.reserve(word_count * sizeof(std::atomic<u64>));
    auto marked_n = std::make_unique<std::atomic<u64>[]>(size_t(word_count));
    for (u64 w = 0; w < word_count; ++w) {
        if ((w & ((1U << 20) - 1)) == 0) limits.check();
        marked_n[w].store(0, std::memory_order_relaxed);
    }
    std::vector<Input> inputs;
    for (const auto spec : push_check::sources_for(index, h)) {
        progress.stage("build_source_directory", n, h, spec.h);
        const auto source = make_bucket(index, n + 1, spec.h, limits);
        if (!source.size) continue;
        progress.stage("read_source", n, h, spec.h);
        const auto children = load(options, index, source, limits);
        progress.stage("hash_source", n, h, spec.h);
        inputs.push_back(identity(source, children, limits));
        progress.stage("physical_delete", n, h, spec.h);
        push_source(options, index, target, source, children, spec.honor_delete_power, marked_n.get(), limits, stats);
    }
    // No source table remains resident here. The parent pull bitmap is loaded
    // only for the final comparison, after all physical predecessor generation.
    progress.stage("read_parent", n, h);
    const auto parent = load(options, index, target, limits);
    inputs.push_back(identity(target, parent, limits));
    progress.stage("compare_parent", n, h);
    u64 p_count = 0;
    for (u64 w = 0; w < word_count; ++w) {
        if ((w & ((1U << 20) - 1)) == 0) limits.check();
        const unsigned width = unsigned(std::min<u64>(64, target.size - w * 64));
        const u64 pushed_p = ~marked_n[w].load(std::memory_order_relaxed) & push_check::low_mask(width);
        const u64 difference = pushed_p ^ parent.p_bits[size_t(w)];
        if (difference) {
            const u64 rank = w * 64 + __builtin_ctzll(difference);
            const auto physical = index.physical(index.decode(target, rank), h);
            throw std::runtime_error("parallel PUSH/PULL mismatch n=" + std::to_string(n) + " h=" + std::to_string(h) +
                " rank=" + std::to_string(rank) + " state=" + ::repr(physical));
        }
        p_count += __builtin_popcountll(pushed_p);
    }
    if (p_count != parent.p_count || target.size - p_count != stats.new_n_marks.load() - first_n)
        throw std::runtime_error("parallel aggregate mismatch");
    limits.check();
    std::ostringstream out;
    out << "{\"schema\":" << quote(RECORD_SCHEMA) << ",\"completed\":true,\"status\":\"VERIFIED_EQUAL\""
        << ",\"build_id\":" << quote(options.build_id) << ",\"compatible_build_id\":" << quote(options.compatible_build_id)
        << ",\"compatibility_audit\":" << quote(options.compatible_build_id.empty() ? "" : COMPATIBILITY_AUDIT)
        << ",\"index_fingerprint\":" << quote(hex(index.fingerprint))
        << ",\"input_signature\":" << quote(hex(input_signature(inputs))) << ",\"n\":" << n << ",\"h\":" << h
        << ",\"honor_code\":" << index.honors[h].code << ",\"states\":" << target.size
        << ",\"P\":" << p_count << ",\"N\":" << target.size - p_count << ",\"threads\":" << options.threads
        << ",\"physical_deletions\":" << stats.deletions.load() - first_deletions
        << ",\"P_child_visits\":" << stats.child_visits.load() - first_visits
        << ",\"seconds\":" << limits.elapsed() - bucket_start << ",\"verified_epoch\":" << std::time(nullptr) << ",\"inputs\":[";
    for (size_t k = 0; k < inputs.size(); ++k) {
        const auto& in = inputs[k];
        if (k) out << ',';
        out << "{\"input_layer\":" << in.n << ",\"input_honor_id\":" << in.h << ",\"input_states\":" << in.states
            << ",\"input_P\":" << in.p << ",\"payload_hash64\":" << quote(hex(in.hash)) << '}';
    }
    out << "]}\n";
    progress.stage("publish_verified_bucket", n, h);
    publish_record(record, out.str(), &limits); // Only whole, equal buckets become reusable.
    stats.verified_states += target.size; ++stats.new_buckets;
    progress.stage("verified_bucket", n, h);
    std::cout << out.str() << std::flush;
}
Options parse(int argc, char** argv) {
    Options o;
    for (int i = 1; i < argc; ++i) {
        const std::string arg = argv[i];
        if (arg == "--no-resume") { o.resume = false; continue; }
        auto value = [&]() { if (i + 1 >= argc) throw std::runtime_error("missing option value"); return std::string(argv[++i]); };
        if (arg == "--data") o.data = fs::u8path(value());
        else if (arg == "--verified-dir") o.verified_dir = fs::u8path(value());
        else if (arg == "--stop-file") o.stop_file = fs::u8path(value());
        else if (arg == "--progress") o.progress_file = fs::u8path(value());
        else if (arg == "--build-id") o.build_id = value();
        else if (arg == "--compatible-build-id") o.compatible_build_id = value();
        else if (arg == "--threads") o.threads = std::stoi(value());
        else if (arg == "--only-h") o.only_h = std::stoi(value());
        else if (arg == "--max-seconds") o.seconds = std::stod(value());
        else if (arg == "--deadline-epoch") o.deadline_epoch = std::stoull(value());
        else if (arg == "--memory-limit-bytes") o.memory_limit = std::stoull(value());
        else if (arg == "--source-chunk-words") o.source_chunk_words = std::stoull(value());
        else if (arg == "--layers") {
            o.layers.clear(); std::istringstream list(value()); std::string part;
            while (std::getline(list, part, ',')) o.layers.push_back(std::stoi(part));
        } else throw std::runtime_error("unknown option " + arg);
    }
    if (o.data.empty() || o.verified_dir.empty() || o.build_id.empty()) throw std::runtime_error("--data and --build-id are required");
    if (o.threads < 1 || o.threads > 64 || !std::isfinite(o.seconds) || o.seconds <= 0 || o.seconds > 43200 ||
        o.memory_limit < 1300000000ULL || o.memory_limit > 19000000000ULL ||
        !o.source_chunk_words || o.source_chunk_words > (1U << 20) || o.layers.empty())
        throw std::runtime_error("invalid threads, budget, memory limit, chunk size, or layers");
    for (int n : o.layers) if (n < 0 || n > 34) throw std::runtime_error("invalid layer");
    if (o.build_id.find_first_not_of("0123456789abcdefABCDEF-_:.abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ") != std::string::npos)
        throw std::runtime_error("invalid build ID characters");
    if (!o.compatible_build_id.empty() && o.compatible_build_id != COMPATIBLE_V2_BUILD)
        throw std::runtime_error("--compatible-build-id is restricted to the audited frozen v2 binary");
    return o;
}
void low_cpu_self_test() {
    // No Index construction, file I/O, or Mahjong enumeration. Two threads
    // repeatedly OR distinct bits into the same words, then join before read.
    std::array<std::atomic<u64>, 8> words;
    for (auto& word : words) word.store(0, std::memory_order_relaxed);
    auto fill = [&](unsigned parity) {
        for (unsigned repeat = 0; repeat < 8; ++repeat)
            for (auto& word : words) for (unsigned bit = parity; bit < 64; bit += 2)
                word.fetch_or(u64(1) << bit, std::memory_order_relaxed);
    };
    std::thread even(fill, 0), odd(fill, 1);
    even.join(); odd.join();
    for (auto& word : words) if (word.load(std::memory_order_relaxed) != ~u64(0)) throw std::runtime_error("atomic OR self-test failed");
    if (push_check::low_mask(1) != 1 || push_check::low_mask(63) != (~u64(0) >> 1) || push_check::low_mask(64) != ~u64(0))
        throw std::runtime_error("padding mask self-test failed");
    std::vector<Input> inputs{{33, 148, 20, 10, 42}, {32, 148, 30, 15, 84}};
    const auto signature = input_signature(inputs); std::reverse(inputs.begin(), inputs.end());
    if (input_signature(inputs) != signature) throw std::runtime_error("input identity order self-test failed");
    std::cout << "{\"status\":\"PASS_LOW_CPU_SELF_TEST\",\"atomic_OR_operations\":4096,\"Index_constructed\":false,\"table_states_verified\":0}"
              << std::endl;
}
} // namespace parallel_check

int main(int argc, char** argv) {
    using namespace parallel_check;
    const auto process_start = Clock::now();
    Stats stats;
    Options options; // Remains alive while all failure paths publish final progress.
    std::unique_ptr<Limits> limits;
    std::unique_ptr<Progress> progress;
    auto report_failure = [&](std::string status, const std::exception& error, int code) {
        std::string reason = error.what();
        if (progress) try { progress->finish(status, reason); }
        catch (const std::exception& progress_error) {
            status = "FAIL"; code = 1; reason += "; "; reason += progress_error.what();
        }
        std::cout << "{\"status\":" << quote(status) << ",\"verified_states\":" << stats.verified_states
                  << ",\"new_verified_buckets\":" << stats.new_buckets << ",\"physical_deletions\":" << stats.deletions.load()
                  << ",\"seconds\":" << std::chrono::duration<double>(Clock::now() - process_start).count()
                  << ",\"reason\":" << quote(reason) << "}" << std::endl;
        return code;
    };
    try {
        if (argc == 2 && std::string(argv[1]) == "--self-test") { low_cpu_self_test(); return 0; }
        if (argc == 3 && std::string(argv[1]) == "--self-test-progress") {
            // Synthetic counters test atomic JSON publication; no Index/table.
            options.progress_file = fs::u8path(argv[2]); options.build_id = "synthetic-progress-self-test";
            limits = std::make_unique<Limits>(options, process_start);
            progress = std::make_unique<Progress>(options, *limits, stats);
            progress->stage("self_test_synthetic_initial", -1, -1);
            stats.verified_states = 7; stats.deletions.store(13);
            progress->stage("self_test_synthetic_updated", 33, 148, 148);
            progress->finish("PASS_SYNTHETIC_PROGRESS_SELF_TEST");
            std::cout << "{\"status\":\"PASS_SYNTHETIC_PROGRESS_SELF_TEST\",\"Index_constructed\":false,\"table_states_verified\":0}" << std::endl;
            return 0;
        }
        options = parse(argc, argv);
        limits = std::make_unique<Limits>(options, process_start);
        progress = std::make_unique<Progress>(options, *limits, stats);
        limits->on_check([&] { progress->write(); });
        std::signal(SIGINT, handle_signal); std::signal(SIGTERM, handle_signal);
        progress->stage("index_initialization", -1, -1);
        retro::Index index;
        if (options.only_h < -1 || options.only_h >= int(index.honors.size())) throw std::runtime_error("invalid --only-h");
        limits->check();
        progress->stage("ready", -1, -1);
        std::cout << "{\"kind\":\"parallel_push_start\",\"index_fingerprint\":" << quote(hex(index.fingerprint))
                  << ",\"build_id\":" << quote(options.build_id) << ",\"threads\":" << options.threads
                  << ",\"compatible_build_id\":" << quote(options.compatible_build_id)
                  << ",\"compatibility_audit\":" << quote(options.compatible_build_id.empty() ? "" : COMPATIBILITY_AUDIT)
                  << ",\"seconds_budget\":" << options.seconds << ",\"deadline_epoch\":" << options.deadline_epoch
                  << ",\"memory_limit_bytes\":" << options.memory_limit
                  << ",\"atomic_u64_lock_free\":" << (std::atomic<u64>::is_always_lock_free ? "true" : "false") << "}" << std::endl;
        for (int n : options.layers) {
            const u64 before = stats.verified_states;
            for (int h = 0; h < int(index.honors.size()); ++h) {
                if (options.only_h >= 0 && h != options.only_h) continue;
                verify_bucket(options, index, n, h, *limits, stats, *progress);
            }
            if (options.only_h < 0 && stats.verified_states - before != index.layer_size(n)) throw std::runtime_error("incomplete layer comparison");
        }
        struct rusage usage{}; getrusage(RUSAGE_SELF, &usage);
        const std::string final_status = options.only_h < 0 ? "PASS_ALL_REQUESTED_LAYERS" : "PASS_SELECTED_BUCKETS";
        progress->finish(final_status); // A failed progress write must never return PASS.
        std::cout << "{\"status\":" << quote(final_status)
                  << ",\"verified_states\":" << stats.verified_states << ",\"new_verified_buckets\":" << stats.new_buckets
                  << ",\"reused_verified_buckets\":" << stats.reused_buckets
                  << ",\"new_verified_states\":" << stats.verified_states - stats.reused_states
                  << ",\"reused_verified_states\":" << stats.reused_states
                  << ",\"physical_deletions\":" << stats.deletions.load() << ",\"P_child_visits\":" << stats.child_visits.load()
                  << ",\"new_N_marks\":" << stats.new_n_marks.load() << ",\"mismatches\":0,\"max_rss_kib\":" << usage.ru_maxrss
                  << ",\"seconds\":" << limits->elapsed() << "}" << std::endl;
        return 0;
    } catch (const Limit& error) {
        return report_failure("UNKNOWN_LIMIT", error, 2);
    } catch (const push_check::Incomplete& error) {
        return report_failure("INCOMPLETE_TABLE", error, 2);
    } catch (const std::exception& error) {
        return report_failure("FAIL", error, 1);
    }
}
