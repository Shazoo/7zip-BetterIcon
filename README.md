# 7zip-BetterIcon


！！！本项目全面改为AI自动话跟踪完成 ！！！



-----------------------------------



7Zip Windows Client (https://www.7-zip.org ) , re-build with better icons. 



当前基于 **7-Zip 26.03**（x64）。历次版本见 git tags（v19.00 / v21.04 / v22.01 / v24.08）。

## 换了什么

只替换 `CPP/7zip/Archive/Icons/` 下的 **27 个归档类型图标**——就是 Explorer 里
`.7z` / `.zip` / `.rar` / `.iso` 这些文件显示的图标。

程序本体图标（`FM.ico`）、"关于"对话框的 logo（`7zipLogo.ico`，110×63 宽版）、
SFX 与安装器图标**全部保持官方原样**。范围和历次版本一致：改动面小，也避免升级时出错。

27 个图标用的是**同一张图**，这是刻意的。资源 ID 0..26 与
`CPP/7zip/Bundles/Format7zF/resource.rc` 里的 `STRINGTABLE 100` 扩展名映射必须保持对齐，
所以换图标时**只覆盖文件内容，不要改文件名、不要增删文件**。

> 想给不同格式配不同图标？改 `STRINGTABLE 100` 里的索引就行，**不需要动 C++**——
> 映射链是纯资源层的：`STRINGTABLE 100` → `CCodecIcons::LoadIcons()`
> （`CPP/7zip/UI/Agent/ArchiveFolderOpen.cpp`）→ 按索引载入资源。
>
> 顺带一提：只要所有扩展名都指向同一个索引，并把 `.rc` 里多余的 `N ICON` 行删掉，
> 图标数据就只存一份，`7z.dll` 能从 6.5 MB 回到约 2.1 MB。（`rc.exe` 不做去重，
> 27 行 `ICON` 即使指向同一个文件也会嵌 27 份。）

## How to Build

* **必须用 Visual Studio 的 Native Tools 命令提示符（x64）**，不要用 Git Bash / MSYS。

  ```bash
  cd <project_root>\CPP\7zip
  ```

  原因：`CPP\Build.mak` 调用的是裸 `link`。在 Git Bash 里 PATH 优先级会让它解析到
  Git 自带的 `/usr/bin/link`（一个做硬链接的小工具），链接阶段必然失败。
  `vcvars64.bat` 会把 MSVC 的目录前置，问题就没了。

* 用 nmake 编译。架构宏是 **`PLATFORM`**：

  x64:
  ```
  nmake PLATFORM=x64
  ```

  x86:
  ```
  nmake PLATFORM=x86
  ```

  > 旧文档里的 `NEW_COMPILER=1 MY_STATIC_LINK=1 CPU=AMD64` **是错的**——
  > 这三个宏在 24.08 和 26.03 的 `Build.mak` 里都不存在。
  > `CPU=AMD64` 会被静默忽略，产物落到 `o\` 而不是 `x64\`，随后打包报一堆找不到文件。
  > （静态链接现在是默认行为，只有反向的 `MY_DYNAMIC_LINK`。）

* **如果编译器崩了**，报这个：

  ```
  fatal error C1001: Internal compiler error
  (compiler file '...\vctools\Compiler\Utc\src\p2\main.cpp', line 262)
  ```

  那是 MSVC 19.51 在默认的 `-MP16` 并行 + 预编译头组合下不稳定，**而且是非确定性的**
  （同一个文件重编一次可能就过）。`Build.mak` 会把并行度下调到 `$(NUMBER_OF_PROCESSORS)`
  （只有当它比 16 小时），所以限流即可：

  ```
  set NUMBER_OF_PROCESSORS=4
  nmake PLATFORM=x64
  ```

  ICE 还有两个连带伤害，重试前要处理：

  1. cl 崩在写 obj 中途会留下 **0 字节的 `.obj`**，下次 nmake 认为它是最新的，
     链接报 `LNK1136: invalid or corrupt file`。**删掉空的 `*.obj`** 再重试。
  2. nmake 的资源规则是 `$O\resource.res: $(*B).rc`，**只依赖 `.rc` 不依赖 `.ico`**。
     换完图标如果不删旧的 `*.res`，rc 根本不会重跑，旧图标会被原样链进去——
     看起来"换了但没生效"。**换图标后务必删掉所有 `*.res`。**

* Check the `readme.md` in build folder for the self-install file

  打包（NSIS，需要 CWD 在 `Build\`，因为脚本里全是相对路径）：

  ```
  cd <project_root>\Build
  makensis 7zip-64.nsi
  ```

  产出 `Build\7z<VERSION_MAJOR><VERSION_MINOR>-x64.exe`。
  两个 `.nsi` 里的 `VERSION_MINOR` **必须写两位**（`03` 而不是 `3`），
  否则粗心的字符串拼接会产出 `7z263-x64.exe`。

  > `Build\misc_files\`（`7-zip.chm`、`History.txt`、`Lang\*.txt` 等）来自**官方二进制安装包**，
  > 官方源码包和 `-extra` 包里都没有。升级时用任意 7-Zip 解官方安装包即可：
  > `7z x 7z<版本>-x64.exe -oextract -y`

If you don't like these icons , check the git log for the detail of how to replace icons .

Be free to send pull request or issue for YOUR better icons . 
