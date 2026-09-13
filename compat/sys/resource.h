#ifndef MAHJONG_WINDOWS_RESOURCE_COMPAT_H
#define MAHJONG_WINDOWS_RESOURCE_COMPAT_H
// Windows-only telemetry adapter. The solver uses only peak resident memory.
// This header changes no game rules, recursion, indices, or checkpoint formats.
#ifndef NOMINMAX
#define NOMINMAX
#endif
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <windows.h>
#include <psapi.h>
#include <cerrno>
#include <cstdint>
constexpr int RUSAGE_SELF = 0;
struct rusage { std::int64_t ru_maxrss = 0; };
inline int getrusage(int who, struct rusage* usage) {
    if (who != RUSAGE_SELF || usage == nullptr) { errno = EINVAL; return -1; }
    PROCESS_MEMORY_COUNTERS pmc{};
    pmc.cb = sizeof(pmc);
    if (!GetProcessMemoryInfo(GetCurrentProcess(), &pmc, sizeof(pmc))) {
        errno = EIO; return -1;
    }
    usage->ru_maxrss = static_cast<std::int64_t>(pmc.PeakWorkingSetSize / 1024);
    return 0;
}
#endif
