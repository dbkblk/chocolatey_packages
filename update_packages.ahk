Menu, Tray, Tip, PackageUpdater

; This script will automatically update the packages. It needs "checksum" and "git" to work.
; Note : To test package locally, use "cinst -y packageName -dv -s ."

scripts_dir = %A_ScriptDir%\src\scripts

RunWait, %scripts_dir%\homebank.ahk

RunWait, %scripts_dir%\microsoft-r-open.ahk

RunWait, %scripts_dir%\rawtherapee.ahk

RunWait, %scripts_dir%\terminus.ahk