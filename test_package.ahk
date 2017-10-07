; Get name of the package as argument
IfExist, %A_ScriptDir%\packed\%1%
{
    SetWorkingDir, %A_ScriptDir%\packed\%1%

    ; Try to find the latest version of the package by requesting creation date
    Loop, Files, *.nupkg
    {
        name = %A_LoopFileName%
        created = %A_LoopFileTimeCreated%
        IfGreater, created, %last_created%
        {
            last_name = %name%
            last_created = %created%
        }
    }
    
    ; Try to install the package with command line
    MsgBox, This will install %last_name%.
    Run  *RunAs %comspec% /k cinst -y "%A_WorkingDir%\%last_name%" -dv -s .
} else {
    MsgBox, The package doesn't exist.
}