Menu, Tray, Tip, PackageUpdater

; This script will automatically update the packages. It needs "checksum" and "git" to work.
; Note : To test package locally, use "cinst -y packageName -dv -s ."

SetWorkingDir, %A_ScriptDir%\src\scripts

RunWait, homebank.ahk

RunWait, microsoft-r-open.ahk