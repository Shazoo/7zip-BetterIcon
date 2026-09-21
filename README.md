# 7zip-BetterIcon
7Zip Windows Client (https://www.7-zip.org ) , re-build with better icons. 

![Better icons](https://img.0w0.io/u/s!AkNcBZ_PlzzpgrBYxPV1-fncwF6y5g/7zip-beautiful-icons.png)

### How to Build

* Use the `Visual Studio` **Native Tools command prompt** (x64). The bare `link`
  that `CPP\Build.mak` calls must resolve to MSVC's linker — running nmake from a
  Git Bash / MSYS shell picks up Git's `link.exe` instead and the build fails.

* Use nmake to build.

  ```bash
  cd <project_root>\CPP\7zip
  ```

  x64 (`PLATFORM` is the only architecture macro; the older
  `NEW_COMPILER` / `MY_STATIC_LINK` / `CPU=AMD64` names no longer exist —
  `CPU=AMD64` is silently ignored and the output lands in `o\` instead of `x64\`):

  ```
  nmake PLATFORM=x64
  ```

  x86:

  ```
  nmake PLATFORM=x86
  ```

  If the compiler dies with `fatal error C1001: Internal compiler error`
  (`Utc\src\p2\main.cpp`), it is the default `-MP16` parallel build being
  unstable with the precompiled header. `Build.mak` lowers the parallel width
  to `$(NUMBER_OF_PROCESSORS)` when that is smaller, so throttle it:

  ```
  set NUMBER_OF_PROCESSORS=4
  nmake PLATFORM=x64
  ```

  An ICE can also leave a 0-byte `.obj` behind, which makes the next link fail
  with `LNK1136: invalid or corrupt file`. Delete empty `*.obj` before retrying.
  Note that nmake's resource rule (`$O\resource.res: $(*B).rc`) does **not**
  depend on the `.ico` files, so after replacing icons you must also delete the
  stale `*.res` — otherwise the old icons get relinked and it looks like nothing
  changed.

* Check the `readme.md` in build folder for the self-install file



If you don't like these icons , check the git log for the detail of how to replace icons .

Be free to send pull request or issue for YOUR better icons . 