;--------------------------------
;Defines

!define WIN64

!define VERSION_MAJOR 21
!define VERSION_MINOR 06
!define VERSION_POSTFIX_FULL ""
!ifdef WIN64
!ifdef IA64
!define VERSION_SYS_POSTFIX_FULL " for Windows IA-64"
!else
!define VERSION_SYS_POSTFIX_FULL " for Windows x64"
!endif
!else
!define VERSION_SYS_POSTFIX_FULL ""
!endif
!define NAME_FULL "7-Zip ${VERSION_MAJOR}.${VERSION_MINOR}${VERSION_POSTFIX_FULL}${VERSION_SYS_POSTFIX_FULL}"
!define VERSION_POSTFIX ""
!ifdef WIN64
!ifdef IA64
!define VERSION_SYS_POSTFIX "-ia64"
!else
!define VERSION_SYS_POSTFIX "-x64"
!endif
!else
!define VERSION_SYS_POSTFIX ""
!endif



!define FM_LINK "7-Zip File Manager.lnk"
!define HELP_LINK "7-Zip Help.lnk"

!define CLSID_CONTEXT_MENU {23170F69-40C1-278A-1000-000100020000}

#!define NO_COMPRESSION

  !include "Library.nsh"
  !include "MUI.nsh"
!define MUI_ICON "7zip.ico"

;--------------------------------
;Configuration

  ;General
  Name "${NAME_FULL}"
  BrandingText "www.7-zip.org"
  OutFile "7z${VERSION_MAJOR}${VERSION_MINOR}${VERSION_POSTFIX}${VERSION_SYS_POSTFIX}.exe"

  ;Folder selection page
  !ifdef WIN64
  InstallDir "$PROGRAMFILES64\7-Zip"
  !else
  InstallDir "$PROGRAMFILES\7-Zip"
  !endif

  ;Get install folder from registry if available
  InstallDirRegKey HKCU "Software\7-Zip" "Path32"

  ;Compressor
!ifndef NO_COMPRESSION
  SetCompressor /solid lzma
  ; SetCompressorFilter 1
!ifdef IA64
  SetCompressorDictSize 8
!else
  SetCompressorDictSize 4
!endif
!else
  SetCompress off
!endif


;--------------------------------
;Variables

;--------------------------------
;Interface Settings


  !define MUI_ABORTWARNING

;--------------------------------
;Pages

  #!insertmacro MUI_PAGE_LICENSE "License.txt"
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH
  
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH
  
;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Reserve Files
  
  ;These files should be inserted before other files in the data block
  ;Keep these lines before any File command
  ;Only for solid compression (by default, solid compression is enabled for BZIP2 and LZMA)
  
  !insertmacro MUI_RESERVEFILE_LANGDLL

;--------------------------------
;Installer Sections

Section
  !ifndef WIN64
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\App Paths\7zFMn.exe"
  !endif

  # delete old unwanted files

  Delete $INSTDIR\7zFMn.exe
  Delete $INSTDIR\7zgn.exe
  Delete $INSTDIR\7zn.exe
  Delete $INSTDIR\7zan.exe
  Delete $INSTDIR\7zC.sfx
  Delete $INSTDIR\7-zipn.dll
  Delete $INSTDIR\7zipDoc.txt
  Delete $INSTDIR\file_id.diz
  Delete $INSTDIR\7zip_pad.xml
  Delete $INSTDIR\copying.txt

  Delete $INSTDIR\Codecs\7zAES.dll
  Delete $INSTDIR\Codecs\AES.dll
  Delete $INSTDIR\Codecs\Branch.dll
  Delete $INSTDIR\Codecs\BZip2.dll
  Delete $INSTDIR\Codecs\Copy.dll
  Delete $INSTDIR\Codecs\Deflate.dll
  Delete $INSTDIR\Codecs\Implode.dll
  Delete $INSTDIR\Codecs\LZMA.dll
  Delete $INSTDIR\Codecs\PPMD.dll
  Delete $INSTDIR\Codecs\Rar29.dll
  Delete $INSTDIR\Codecs\Swap.dll

  RMDir $INSTDIR\Codecs

  Delete $INSTDIR\Formats\7z.dll
  Delete $INSTDIR\Formats\arj.dll
  Delete $INSTDIR\Formats\bz2.dll
  Delete $INSTDIR\Formats\cab.dll
  Delete $INSTDIR\Formats\chm.dll
  Delete $INSTDIR\Formats\cpio.dll
  Delete $INSTDIR\Formats\deb.dll
  Delete $INSTDIR\Formats\gz.dll
  Delete $INSTDIR\Formats\iso.dll
  Delete $INSTDIR\Formats\lzh.dll
  Delete $INSTDIR\Formats\nsis.dll
  Delete $INSTDIR\Formats\rar.dll
  Delete $INSTDIR\Formats\rpm.dll
  Delete $INSTDIR\Formats\split.dll
  Delete $INSTDIR\Formats\tar.dll
  Delete $INSTDIR\Formats\z.dll
  Delete $INSTDIR\Formats\zip.dll

  RMDir $INSTDIR\Formats

  Delete $INSTDIR\Lang\no.txt

  # install files

  SetOutPath $INSTDIR

  File misc_files\descript.ion
  File misc_files\History.txt
  File misc_files\License.txt
  File misc_files\readme.txt
  File misc_files\7-zip.chm

  # File files\7-zip.dll

  File ..\CPP\7zip\Bundles\Format7zF\x64\7z.dll
  File ..\CPP\7zip\UI\FileManager\x64\7zFM.exe
  File ..\CPP\7zip\UI\GUI\x64\7zG.exe
  File ..\CPP\7zip\UI\Console\x64\7z.exe
  File ..\CPP\7zip\Bundles\SFXWin\x64\7z.sfx
  File ..\CPP\7zip\Bundles\SFXCon\x64\7zCon.sfx
  File /oname=7-zip32.dll ..\CPP\7zip\UI\Explorer\x86\7-zip.dll 

  
  SetOutPath $INSTDIR\Lang

  File misc_files\lang\en.ttt
  File misc_files\lang\af.txt
  File misc_files\lang\an.txt
  File misc_files\lang\ar.txt
  File misc_files\lang\ast.txt
  File misc_files\lang\az.txt
  File misc_files\lang\ba.txt
  File misc_files\lang\be.txt
  File misc_files\lang\bg.txt
  File misc_files\lang\bn.txt
  File misc_files\lang\br.txt
  File misc_files\lang\ca.txt
  File misc_files\lang\co.txt
  File misc_files\lang\cs.txt
  File misc_files\lang\cy.txt
  File misc_files\lang\da.txt
  File misc_files\lang\de.txt
  File misc_files\lang\el.txt
  File misc_files\lang\eo.txt
  File misc_files\lang\es.txt
  File misc_files\lang\et.txt
  File misc_files\lang\eu.txt
  File misc_files\lang\ext.txt
  File misc_files\lang\fa.txt
  File misc_files\lang\fi.txt
  File misc_files\lang\fr.txt
  File misc_files\lang\fur.txt
  File misc_files\lang\fy.txt
  File misc_files\lang\ga.txt
  File misc_files\lang\gl.txt
  File misc_files\lang\gu.txt
  File misc_files\lang\he.txt
  File misc_files\lang\hi.txt
  File misc_files\lang\hr.txt
  File misc_files\lang\hu.txt
  File misc_files\lang\hy.txt
  File misc_files\lang\id.txt
  File misc_files\lang\io.txt
  File misc_files\lang\is.txt
  File misc_files\lang\it.txt
  File misc_files\lang\ja.txt
  File misc_files\lang\ka.txt
  File misc_files\lang\kaa.txt
  File misc_files\lang\kab.txt
  File misc_files\lang\kk.txt
  File misc_files\lang\ko.txt
  File misc_files\lang\ku.txt
  File misc_files\lang\ku-ckb.txt
  File misc_files\lang\ky.txt
  File misc_files\lang\lij.txt
  File misc_files\lang\lt.txt
  File misc_files\lang\lv.txt
  File misc_files\lang\mk.txt
  File misc_files\lang\mn.txt
  File misc_files\lang\mng.txt
  File misc_files\lang\mng2.txt
  File misc_files\lang\mr.txt
  File misc_files\lang\ms.txt
  File misc_files\lang\ne.txt
  File misc_files\lang\nl.txt
  File misc_files\lang\nb.txt
  File misc_files\lang\nn.txt
  File misc_files\lang\pa-in.txt
  File misc_files\lang\pl.txt
  File misc_files\lang\ps.txt
  File misc_files\lang\pt.txt
  File misc_files\lang\pt-br.txt
  File misc_files\lang\ro.txt
  File misc_files\lang\ru.txt
  File misc_files\lang\sa.txt
  File misc_files\lang\si.txt
  File misc_files\lang\sk.txt
  File misc_files\lang\sl.txt
  File misc_files\lang\sq.txt
  File misc_files\lang\sr-spc.txt
  File misc_files\lang\sr-spl.txt
  File misc_files\lang\sv.txt
  File misc_files\lang\ta.txt
  File misc_files\lang\th.txt
  File misc_files\lang\tr.txt
  File misc_files\lang\tt.txt
  File misc_files\lang\ug.txt
  File misc_files\lang\uk.txt
  File misc_files\lang\uz.txt
  File misc_files\lang\va.txt
  File misc_files\lang\vi.txt
  File misc_files\lang\yo.txt
  File misc_files\lang\zh-cn.txt
  File misc_files\lang\zh-tw.txt
  File misc_files\lang\sw.txt
  File misc_files\lang\tg.txt
  File misc_files\lang\tk.txt
  File misc_files\lang\uz-cyrl.txt


  SetOutPath $INSTDIR

  # delete "current user" menu items

  Delete "$SMPROGRAMS\7-Zip\${FM_LINK}"
  Delete "$SMPROGRAMS\7-Zip\${HELP_LINK}"
  RMDir $SMPROGRAMS\7-Zip

  # set "all users" mode

  SetShellVarContext all

  !insertmacro InstallLib DLL NOTSHARED REBOOT_NOTPROTECTED ..\CPP\7zip\UI\Explorer\x64\7-zip.dll $INSTDIR\7-zip.dll $INSTDIR

  ClearErrors

  # create start menu icons

  SetOutPath $INSTDIR

  CreateDirectory $SMPROGRAMS\7-Zip
  CreateShortCut "$SMPROGRAMS\7-Zip\${FM_LINK}" $INSTDIR\7zFM.exe
  CreateShortCut "$SMPROGRAMS\7-Zip\${HELP_LINK}" $INSTDIR\7-zip.chm

  IfErrors 0 noScErrors

  SetShellVarContext current

  CreateDirectory $SMPROGRAMS\7-Zip
  CreateShortCut "$SMPROGRAMS\7-Zip\${FM_LINK}" $INSTDIR\7zFM.exe
  CreateShortCut "$SMPROGRAMS\7-Zip\${HELP_LINK}" $INSTDIR\7-zip.chm

noScErrors:

  # store install folder

  WriteRegStr HKLM Software\7-Zip Path32 $INSTDIR
  WriteRegStr HKLM Software\7-Zip Path   $INSTDIR
  WriteRegStr HKCU Software\7-Zip Path32 $INSTDIR
  WriteRegStr HKCU Software\7-Zip Path   $INSTDIR

  # write reg entries

  WriteRegStr HKCR "CLSID\${CLSID_CONTEXT_MENU}" "" "7-Zip Shell Extension"
  WriteRegStr HKCR "CLSID\${CLSID_CONTEXT_MENU}\InprocServer32" "" $INSTDIR\7-zip.dll
  WriteRegStr HKCR "CLSID\${CLSID_CONTEXT_MENU}\InprocServer32" ThreadingModel Apartment
  DeleteRegValue HKCR "CLSID\${CLSID_CONTEXT_MENU}\InprocServer32" "InprocServer32"

  WriteRegStr HKCR "*\shellex\ContextMenuHandlers\7-Zip" "" "${CLSID_CONTEXT_MENU}"
  WriteRegStr HKCR "Directory\shellex\ContextMenuHandlers\7-Zip" "" "${CLSID_CONTEXT_MENU}"
  WriteRegStr HKCR "Folder\shellex\ContextMenuHandlers\7-Zip" "" "${CLSID_CONTEXT_MENU}"

  WriteRegStr HKCR "Directory\shellex\DragDropHandlers\7-Zip" "" "${CLSID_CONTEXT_MENU}"
  WriteRegStr HKCR "Drive\shellex\DragDropHandlers\7-Zip" "" "${CLSID_CONTEXT_MENU}"

  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved" "${CLSID_CONTEXT_MENU}" "7-Zip Shell Extension"
  
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\App Paths\7zFM.exe" "" $INSTDIR\7zFM.exe
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\App Paths\7zFM.exe" Path $INSTDIR

  # create uninstaller

  WriteRegStr HKLM Software\Microsoft\Windows\CurrentVersion\Uninstall\7-Zip DisplayName "${NAME_FULL}"
  WriteRegStr HKLM Software\Microsoft\Windows\CurrentVersion\Uninstall\7-Zip UninstallString '"$INSTDIR\Uninstall.exe"'
  WriteRegDWORD HKLM Software\Microsoft\Windows\CurrentVersion\Uninstall\7-Zip NoModify 1
  WriteRegDWORD HKLM Software\Microsoft\Windows\CurrentVersion\Uninstall\7-Zip NoRepair 1

  WriteUninstaller $INSTDIR\Uninstall.exe

  !ifdef WIN64
  ExecWait 'regsvr32 /s "$INSTDIR\7-zip.dll"'
  !endif

SectionEnd
 

;--------------------------------
;Installer Functions

/*
Function .onInit

  !insertmacro MUI_LANGDLL_DISPLAY

FunctionEnd
*/




;--------------------------------
;Uninstaller Section

Section Uninstall

  ExecWait 'regsvr32 /u /s "$INSTDIR\7-zip.dll"'

  # delete files

  Delete $INSTDIR\descript.ion
  Delete $INSTDIR\History.txt
  Delete $INSTDIR\License.txt
  Delete $INSTDIR\readme.txt
  Delete $INSTDIR\7-zip.chm

  Delete $INSTDIR\7z.dll
  Delete $INSTDIR\7zFM.exe
  Delete $INSTDIR\7zG.exe
  Delete $INSTDIR\7z.exe
  Delete $INSTDIR\7z.sfx
  Delete $INSTDIR\7zCon.sfx

  Delete $INSTDIR\Lang\en.ttt
  Delete $INSTDIR\Lang\af.txt
  Delete $INSTDIR\Lang\an.txt
  Delete $INSTDIR\Lang\ar.txt
  Delete $INSTDIR\Lang\ast.txt
  Delete $INSTDIR\Lang\az.txt
  Delete $INSTDIR\Lang\ba.txt
  Delete $INSTDIR\Lang\be.txt
  Delete $INSTDIR\Lang\bg.txt
  Delete $INSTDIR\Lang\bn.txt
  Delete $INSTDIR\Lang\br.txt
  Delete $INSTDIR\Lang\ca.txt
  Delete $INSTDIR\Lang\co.txt
  Delete $INSTDIR\Lang\cs.txt
  Delete $INSTDIR\Lang\cy.txt
  Delete $INSTDIR\Lang\da.txt
  Delete $INSTDIR\Lang\de.txt
  Delete $INSTDIR\Lang\el.txt
  Delete $INSTDIR\Lang\eo.txt
  Delete $INSTDIR\Lang\es.txt
  Delete $INSTDIR\Lang\et.txt
  Delete $INSTDIR\Lang\eu.txt
  Delete $INSTDIR\Lang\ext.txt
  Delete $INSTDIR\Lang\fa.txt
  Delete $INSTDIR\Lang\fi.txt
  Delete $INSTDIR\Lang\fr.txt
  Delete $INSTDIR\Lang\fur.txt
  Delete $INSTDIR\Lang\fy.txt
  Delete $INSTDIR\Lang\ga.txt
  Delete $INSTDIR\Lang\gl.txt
  Delete $INSTDIR\Lang\gu.txt
  Delete $INSTDIR\Lang\he.txt
  Delete $INSTDIR\Lang\hi.txt
  Delete $INSTDIR\Lang\hr.txt
  Delete $INSTDIR\Lang\hu.txt
  Delete $INSTDIR\Lang\hy.txt
  Delete $INSTDIR\Lang\id.txt
  Delete $INSTDIR\Lang\io.txt
  Delete $INSTDIR\Lang\is.txt
  Delete $INSTDIR\Lang\it.txt
  Delete $INSTDIR\Lang\ja.txt
  Delete $INSTDIR\Lang\ka.txt
  Delete $INSTDIR\Lang\kaa.txt
  Delete $INSTDIR\Lang\kab.txt
  Delete $INSTDIR\Lang\kk.txt
  Delete $INSTDIR\Lang\ko.txt
  Delete $INSTDIR\Lang\ku.txt
  Delete $INSTDIR\Lang\ku-ckb.txt
  Delete $INSTDIR\Lang\ky.txt
  Delete $INSTDIR\Lang\lij.txt
  Delete $INSTDIR\Lang\lt.txt
  Delete $INSTDIR\Lang\lv.txt
  Delete $INSTDIR\Lang\mk.txt
  Delete $INSTDIR\Lang\mn.txt
  Delete $INSTDIR\Lang\mng.txt
  Delete $INSTDIR\Lang\mng2.txt
  Delete $INSTDIR\Lang\mr.txt
  Delete $INSTDIR\Lang\ms.txt
  Delete $INSTDIR\Lang\ne.txt
  Delete $INSTDIR\Lang\nl.txt
  Delete $INSTDIR\Lang\nb.txt
  Delete $INSTDIR\Lang\nn.txt
  Delete $INSTDIR\Lang\pa-in.txt
  Delete $INSTDIR\Lang\pl.txt
  Delete $INSTDIR\Lang\ps.txt
  Delete $INSTDIR\Lang\pt.txt
  Delete $INSTDIR\Lang\pt-br.txt
  Delete $INSTDIR\Lang\ro.txt
  Delete $INSTDIR\Lang\ru.txt
  Delete $INSTDIR\Lang\sa.txt
  Delete $INSTDIR\Lang\si.txt
  Delete $INSTDIR\Lang\sk.txt
  Delete $INSTDIR\Lang\sl.txt
  Delete $INSTDIR\Lang\sq.txt
  Delete $INSTDIR\Lang\sr.txt
  Delete $INSTDIR\Lang\sr-spc.txt
  Delete $INSTDIR\Lang\sr-spl.txt
  Delete $INSTDIR\Lang\sv.txt
  Delete $INSTDIR\Lang\ta.txt
  Delete $INSTDIR\Lang\th.txt
  Delete $INSTDIR\Lang\tr.txt
  Delete $INSTDIR\Lang\tt.txt
  Delete $INSTDIR\Lang\ug.txt
  Delete $INSTDIR\Lang\uk.txt
  Delete $INSTDIR\Lang\uz.txt
  Delete $INSTDIR\Lang\va.txt
  Delete $INSTDIR\Lang\vi.txt
  Delete $INSTDIR\Lang\vr.txt
  Delete $INSTDIR\Lang\yo.txt
  Delete $INSTDIR\Lang\zh-cn.txt
  Delete $INSTDIR\Lang\zh-tw.txt
  Delete $INSTDIR\lang\sw.txt
  Delete $INSTDIR\lang\tg.txt
  Delete $INSTDIR\lang\tk.txt
  Delete $INSTDIR\lang\uz-cyrl.txt
  RMDir $INSTDIR\Lang

  Delete /REBOOTOK $INSTDIR\7-zip.dll
  Delete $INSTDIR\Uninstall.exe

  RMDir $INSTDIR

  # delete start menu entires

  SetShellVarContext all

  # ClearErrors

  Delete "$SMPROGRAMS\7-Zip\${FM_LINK}"
  Delete "$SMPROGRAMS\7-Zip\${HELP_LINK}"
  RMDir $SMPROGRAMS\7-Zip

  # IfErrors 0 noScErrors

  SetShellVarContext current

  Delete "$SMPROGRAMS\7-Zip\${FM_LINK}"
  Delete "$SMPROGRAMS\7-Zip\${HELP_LINK}"
  RMDir $SMPROGRAMS\7-Zip

  # noScErrors:


  # delete registry entries

  DeleteRegKey HKLM Software\Microsoft\Windows\CurrentVersion\Uninstall\7-Zip
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\App Paths\7zFM.exe"

  DeleteRegKey HKLM Software\7-Zip
  DeleteRegKey HKCU Software\7-Zip

  DeleteRegKey HKCR CLSID\${CLSID_CONTEXT_MENU}

  DeleteRegKey HKCR *\shellex\ContextMenuHandlers\7-Zip
  DeleteRegKey HKCR Directory\shellex\ContextMenuHandlers\7-Zip
  DeleteRegKey HKCR Folder\shellex\ContextMenuHandlers\7-Zip

  DeleteRegKey HKCR Drive\shellex\DragDropHandlers\7-Zip
  DeleteRegKey HKCR Directory\shellex\DragDropHandlers\7-Zip
  DeleteRegKey HKCR Folder\shellex\DragDropHandlers\7-Zip

  DeleteRegValue HKLM "Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved" "${CLSID_CONTEXT_MENU}"

  DeleteRegKey HKCR 7-Zip.001
  DeleteRegKey HKCR 7-Zip.7z
  DeleteRegKey HKCR 7-Zip.arj
  DeleteRegKey HKCR 7-Zip.bz2
  DeleteRegKey HKCR 7-Zip.bzip2
  DeleteRegKey HKCR 7-Zip.tbz
  DeleteRegKey HKCR 7-Zip.tbz2
  DeleteRegKey HKCR 7-Zip.cab
  DeleteRegKey HKCR 7-Zip.cpio
  DeleteRegKey HKCR 7-Zip.deb
  DeleteRegKey HKCR 7-Zip.dmg
  DeleteRegKey HKCR 7-Zip.fat
  DeleteRegKey HKCR 7-Zip.gz
  DeleteRegKey HKCR 7-Zip.gzip
  DeleteRegKey HKCR 7-Zip.hfs
  DeleteRegKey HKCR 7-Zip.iso
  DeleteRegKey HKCR 7-Zip.lha
  DeleteRegKey HKCR 7-Zip.lzh
  DeleteRegKey HKCR 7-Zip.lzma
  DeleteRegKey HKCR 7-Zip.ntfs
  DeleteRegKey HKCR 7-Zip.rar
  DeleteRegKey HKCR 7-Zip.rpm
  DeleteRegKey HKCR 7-Zip.split
  DeleteRegKey HKCR 7-Zip.squashfs
  DeleteRegKey HKCR 7-Zip.swm
  DeleteRegKey HKCR 7-Zip.tar
  DeleteRegKey HKCR 7-Zip.taz
  DeleteRegKey HKCR 7-Zip.tgz
  DeleteRegKey HKCR 7-Zip.tpz
  DeleteRegKey HKCR 7-Zip.txz
  DeleteRegKey HKCR 7-Zip.vhd
  DeleteRegKey HKCR 7-Zip.wim
  DeleteRegKey HKCR 7-Zip.xar
  DeleteRegKey HKCR 7-Zip.xz
  DeleteRegKey HKCR 7-Zip.z
  DeleteRegKey HKCR 7-Zip.zip

SectionEnd
