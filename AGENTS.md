# AGENTS.md

## Cursor Cloud specific instructions

This is a **7-Zip (BetterIcon fork)** codebase — a pure C/C++ native project. No package managers, Docker, or runtime services are used. The toolchain is GCC/G++ and GNU Make.

### Building on Linux

The primary Linux build target is the `Alone2` bundle, which produces the `7zz` standalone console binary supporting all archive formats:

```
cd CPP/7zip/Bundles/Alone2
make -j -f makefile.gcc
```

The output binary is at `_o/7zz` (basic) or `b/g/7zz` (optimized via `cmpl_gcc.mak`).

Other useful bundles:
- `Bundles/Alone` → `7za` (limited formats: 7z/xz/cab/zip/gzip/bzip2/tar)
- `Bundles/Alone7z` → `7zr` (7z only, reduced)

See `DOC/readme.txt` for full build options including `cmpl_gcc.mak` (GCC optimized), `cmpl_clang.mak` (Clang), and assembler-accelerated variants.

### Testing

There is no formal test suite. Verify builds by:
1. Running `7zz` with no arguments (shows version/help).
2. Compress: `7zz a test.7z <file>`
3. Extract: `7zz x test.7z -o<output_dir>`
4. Benchmark: `7zz b`

### Lint / Static Analysis

No linter or static analysis tooling is configured in this repo. The build itself uses `-Werror -Wall -Wextra` (via `cmpl_gcc.mak`), so compiler warnings are treated as errors in the optimized build path.

### Notes

- Build artifacts go into `_o/` (basic makefile.gcc) or `b/g/` (cmpl_gcc.mak). These directories are not tracked by git.
- Windows GUI components (File Manager, Explorer shell extension) cannot be built on Linux.
- The `makefile` (no extension) files are for Windows `nmake`; use `makefile.gcc` for Linux/macOS.
