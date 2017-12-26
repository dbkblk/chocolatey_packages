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
    MsgBox, This will push %last_name%.
    Run %comspec% /k choco push "%A_WorkingDir%\%last_name%" --source https://push.chocolatey.org/
} else {
    MsgBox, The package doesn't exist.
}