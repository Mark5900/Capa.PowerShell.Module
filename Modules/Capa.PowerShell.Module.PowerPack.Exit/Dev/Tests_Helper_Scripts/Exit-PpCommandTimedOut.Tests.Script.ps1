param($RootPath, $TestNumber)
$LogFilePath = 'C:\Temp\Exit-PpCommandTimedOut.log'

Import-Module "$RootPath\Capa.PowerShell.Module.PowerPack.Exit\Dev\Exit-PpCommandTimedOut.ps1"
Import-Module "$RootPath\Capa.PowerShell.Module.PowerPack\Dev\Add-PpDll.ps1"
Import-Module "$RootPath\Capa.PowerShell.Module.PowerPack.Exit\Dev\Exit-PpScript.ps1"
Import-Module "$RootPath\Capa.PowerShell.Module.PowerPack.Job\Dev\Job_Start.ps1"
Import-Module "$RootPath\Capa.PowerShell.Module.PowerPack.Job\Dev\Job_WriteLog.ps1"

$LogFilePath = 'C:\Temp\Exit-PpCommandTimedOut.log'
$Global:Cs = Add-PpDll -DllPath 'C:\Temp\CapaOne.ScriptingLibrary.dll'
Job_Start -JobType 'WS' -PackageName 'PesterTest' -PackageVersion 'v1.0' -LogPath $LogFilePath -Action 'INSTALL'

switch ($TestNumber) {
    1 {
        Exit-PpCommandTimedOut
    }
    2 {
        Exit-PpCommandTimedOut -ExitMessage 'Test where I set ExitMessage'
    }
}