#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

RunWait, %ComSpec% /c git pull,,hide
RunWait, python check.py,,hide
RunWait, python pack.py,,hide
RunWait, python push.py,,hide
RunWait, %ComSpec% /c git push,,hide