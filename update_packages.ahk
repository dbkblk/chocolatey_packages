; This is the script which will be run automatically on Appveyor on each git commit.
; The goal is to automatically build nupkg and push them. It allows to maintain packages from any platform.

; Loop packages
Loop, Files, %A_ScriptDir%/pkg/*, D
{
    name = %A_LoopFileName%

    ;debug
    ;MsgBox, pkg_test : %name%

    ; Get local version
    FileRead, f_tmp, %A_ScriptDir%\pkg\%name%\%name%.nuspec
    RegExMatch(f_tmp, "<version>(.*)<\/version>", version)
    version_local = %version1%
    ;MsgBox, %name% (local) : %version_local%

    ; Get distant version
    ; RunWait, %comspec% /c choco info -r --pre %name% > tmp,,Hide
    ; FileReadLine, version_distant, tmp, 1
    ; FileDelete, tmp
    ; StringSplit, version_distant, version_distant, |
    ; version_distant = %version_distant2%

    ;debug
    ;MsgBox, %name% (distant) : %version_distant%

    ; Break if one of the version is unreachable
    ; If !version_local
    ; {
    ;     ExitApp, 1
    ; }
    ;     If !version_distant
    ; {
    ;     ExitApp, 1
    ; }

    ; Test if distant version exist
    RunWait, %comspec% /c choco info -r %name% --version=%version_local% > tmp,,Hide
    FileReadLine, version_distant, tmp, 1
    FileDelete, tmp
    StringSplit, version_distant, version_distant, |
    version_distant = %version_distant2%
    if !version_distant
    {
        ; Break because it could lend to weird errors if the servers are offline
        ExitApp, 1
    }

    ;debug
    ;MsgBox, %name% %version_distant% %version_local%

    ; If different, build the package
    IfEqual, version_distant, %version_local%
    {
        SetWorkingDir, %A_ScriptDir%\pkg\%name%\
        RunWait, %comspec% /c choco pack,,Hide
        ;MsgBox, %name% %version_distant% %version_local%
        SetWorkingDir, %A_ScriptDir%
    } 
}