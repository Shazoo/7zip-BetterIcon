# 7zip-BetterIcon
7Zip Windows Client (https://www.7-zip.org ) , re-build with better icons. 

![Better icons](https://img.0w0.io/u/s!AkNcBZ_PlzzpgrBYxPV1-fncwF6y5g/7zip-beautiful-icons.png)

### How to Build 

* Use the `Visual Studio 2017 Community` or  `Visual Studio 2019 Community`  to build . (both test well)

* Use the `Native tool chain`,  for x86 and x64 build . you could find them in :`C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Visual Studio 2017\Visual Studio Tools\VC` . it is a useful `cmd` console window with perfect tool chain configuration.

* Use the nmake to build .

  x64:

  ```
  nmake NEW_COMPILER=1 MY_STATIC_LINK=1 CPU=AMD64
  ```

  x86:

  ```
  nmake NEW_COMPILER=1 MY_STATIC_LINK=1
  ```

* Check the `readme.md` in build folder for the self-install file 



If you don't like these icons , check the git log for the detail of how to replace icons .

Be free to send pull request or issue for better icons . 