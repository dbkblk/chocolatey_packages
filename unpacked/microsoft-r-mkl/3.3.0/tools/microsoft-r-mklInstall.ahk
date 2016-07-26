; Set a timer to exit script if chocolatey has ended without reaching the end of the script
SetTimer, chocoCheck, 5000

; Function
WinWait, RevoMath Installer, Next
WinActivate, RevoMath Installer
ControlClick, Next, RevoMath Installer
WinWait, RevoMath Installer, I accept the license agreement
WinActivate, RevoMath Installer
ControlClick, I accept the license agreement, RevoMath Installer
WinWait, RevoMath Installer, Next
WinActivate, RevoMath Installer
ControlClick, Next, RevoMath Installer
WinWait, RevoMath Installer, Enter a path to MRO
WinActivate, RevoMath Installer
ControlClick, Next, RevoMath Installer
WinWait, RevoMath Installer, Please select the installation
WinActivate, RevoMath Installer
ControlClick, Install, RevoMath Installer
WinWait, RevoMath Installer, The library installation was successful
WinActivate, RevoMath Installer
ControlClick, Exit, RevoMath Installer
ExitApp, 0
return

chocoCheck:
{
    Process, Exist, cinst.exe
    If (Errorlevel = 0)
    {
        ExitApp, 0
    }        
}
return