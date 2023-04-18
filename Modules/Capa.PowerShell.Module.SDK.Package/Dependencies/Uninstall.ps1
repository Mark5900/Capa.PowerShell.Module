
[CmdletBinding()]
Param(
    [Parameter(Mandatory = $true)]
    [string]$Packageroot,
    [Parameter(Mandatory = $true)]
    [string]$AppName,
    [Parameter(Mandatory = $true)]
    [string]$AppRelease,
    [Parameter(Mandatory = $true)]
    [string]$LogFile,
    [Parameter(Mandatory = $true)]
    [string]$TempFolder,
    [Parameter(Mandatory = $true)]
    [string]$DllPath,
    [Parameter(Mandatory = $false)]
    [Object]$InputObject = $null
)

try {
    ### Download package kit
    [bool]$global:DownloadPackage = $true

    ##############################################
    #load core PS lib - don't mess with this!
    if ($InputObject) { $pgkit = '' }else { $pgkit = 'kit' }
    Import-Module (Join-Path $Packageroot $pgkit 'PSlib.psm1') -ErrorAction stop
    #load Library dll
    $cs = Add-PSDll
    ##############################################

    #Begin
    $cs.Job_Start('WS', $AppName, $AppRelease, $LogFile, 'INSTALL')
    $cs.Job_WriteLog("[Init]: Starting package: '" + $AppName + "' Release: '" + $AppRelease + "'")
    if (!$cs.Sys_IsMinimumRequiredDiskspaceAvailable('c:', 1500)) { Exit-PSScript 3333 }
    if ($global:DownloadPackage -and $InputObject) { Start-PSDownloadPackage }
  
    $cs.Job_WriteLog("[Init]: `$PackageRoot:` '" + $Packageroot + "'")
    $cs.Job_WriteLog("[Init]: `$AppName:` '" + $AppName + "'")
    $cs.Job_WriteLog("[Init]: `$AppRelease:` '" + $AppRelease + "'")
    $cs.Job_WriteLog("[Init]: `$LogFile:` '" + $LogFile + "'")
    $cs.Job_WriteLog("[Init]: `$TempFolder:` '" + $TempFolder + "'")
    $cs.Job_WriteLog("[Init]: `$DllPath:` '" + $DllPath + "'")
    $cs.Job_WriteLog("[Init]: `$global:DownloadPackage`: '" + $global:DownloadPackage + "'")
  
    #Sample of copying file from Package Kit folder
    #$cs.File_CopyFile("$Packageroot\kit\test.exe","C:\Temp\Test.exe")

    #Sample of executing msi file
    #$retvalue=$cs.Shell_Execute("msiexec","/i `"$Packageroot\kit\GoogleChromeStandaloneEnterprise64.Msi`" /QN REBOOT=REALLYSUPPRESS ALLUSERS=1")
    #if ($retvalue -ne 0){Exit-PSScript $retvalue}
    #$cs.Job_WriteLog("Install:","$AppName completed with status: $retvalue")

    #Sample of executing installer
    #$retvalue=$cs.Shell_Execute(`"$Packageroot\kit\ProgramInstall.exe`","/SILENT")
    #if ($retvalue -ne 0){Exit-PSScript $retvalue}
    #$cs.Job_WriteLog("Install:","$AppName completed with status: $retvalue")


    # examples of return codes that are handled by agent caller
    # 3326 = Retry Later
    # 3330 = Application already installed
    # 3010 = Reboot requested
    # 3333 = Missing disk space

    Exit-PSScript $Error

} catch {
    $line = $_.InvocationInfo.ScriptLineNumber
    $cs.Job_WriteLog('*****************', "Something bad happend at line $($line): $($_.Exception.Message)")
    Exit-PSScript $_.Exception.HResult
}
