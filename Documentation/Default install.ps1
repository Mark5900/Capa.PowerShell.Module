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

Import-Module Capa.PowerShell.Module.PowerPack
##################
### PARAMETERS ###
##################
# DO NOT CHANGE
[bool]$global:DownloadPackage = $true
# Change as needed

#################
### FUNCTIONS ###
#################
function Begin {
  param($InputObject,
    $Packageroot,
    $AppName,
    $AppRelease,
    $LogFile,
    $TempFolder,
    $DllPath
  )

  ##############################################
  #load core PS lib - don't mess with this!
  if ($InputObject) { $pgkit = '' }else { $pgkit = 'kit' }
  Import-Module (Join-Path $Packageroot $pgkit 'PSlib.psm1') -ErrorAction stop
  #load Library dll
  $Global:cs = Add-PSDll
  ##############################################

  Job_Start -JobType WS -AppName $AppName -AppRelease $AppRelease -LogFile $LogFile -JobAction INSTALL
  Job_WriteLog -Message ("[Init]: Starting package: '" + $AppName + "' Release: '" + $AppRelease + "'")
  If (!(Sys_IsMinimumRequiredDiskspaceAvailable -DriveLetter 'c:' -RequiredSpace 1500)) { Exit-PSScript 3333 }
  If ($global:DownloadPackage -and $InputObject) { Start-PSDownloadPackage }

  Job_WriteLog -Message ("[Init]: `$PackageRoot:` '" + $Packageroot + "'")
  Job_WriteLog -Message ("[Init]: `$AppName:` '" + $AppName + "'")
  Job_WriteLog -Message ("[Init]: `$AppRelease:` '" + $AppRelease + "'")
  Job_WriteLog -Message ("[Init]: `$LogFile:` '" + $LogFile + "'")
  Job_WriteLog -Message ("[Init]: `$TempFolder:` '" + $TempFolder + "'")
  Job_WriteLog -Message ("[Init]: `$DllPath:` '" + $DllPath + "'")
  Job_WriteLog -Message ("[Init]: `$global:DownloadPackage`: '" + $global:DownloadPackage + "'")
}


##############
### SCRIPT ###
##############
try {
  Begin -InputObject $InputObject -Packageroot $Packageroot -AppName $AppName -AppRelease $AppRelease -LogFile $LogFile -TempFolder $TempFolder -DllPath $DllPath
  Exit-PSScript $Error
} catch {
  $line = $_.InvocationInfo.ScriptLineNumber
  Job_WriteLog -FunctionName '*****************' -Message ("Something bad happend at line $($line): $($_.Exception.Message)")
  Exit-PSScript $_.Exception.HResult
}