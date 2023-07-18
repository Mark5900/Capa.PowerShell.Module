param($RootPath, $TestNumber)
$LogFilePath = 'C:\Temp\Exit-PpRebootRequested.log'

Import-Module "$RootPath\Capa.PowerShell.Module.PowerPack.Exit\Dev\Exit-PpRebootRequested.ps1"
Import-Module "$RootPath\Capa.PowerShell.Module.PowerPack\Dev\Add-PSDll.ps1"
Import-Module "$RootPath\Capa.PowerShell.Module.PowerPack.Exit\Dev\Exit-PpScript.ps1"
Import-Module "$RootPath\Capa.PowerShell.Module.PowerPack.Job\Dev\Job_Start.ps1"
Import-Module "$RootPath\Capa.PowerShell.Module.PowerPack.Job\Dev\Job_WriteLog.ps1"

$LogFilePath = 'C:\Temp\Exit-PpRebootRequested.log'
$Global:Cs = Add-PSDll -DllPath 'C:\Temp\CapaOne.ScriptingLibrary.dll'
Job_Start -JobType 'WS' -PackageName 'PesterTest' -PackageVersion 'v1.0' -LogPath $LogFilePath -Action 'INSTALL'

switch ($TestNumber) {
    1 {  
        Exit-PpRebootRequested
    }
    2 {
        Exit-PpRebootRequested -ExitMessage 'Test where I set ExitMessage'
    }
}