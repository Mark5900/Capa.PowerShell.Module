[CmdletBinding()]
Param(
	[Parameter(Mandatory = $false)]
	[string]$Packageroot,
	[Parameter(Mandatory = $false)]
	[string]$AppName,
	[Parameter(Mandatory = $false)]
	[string]$AppRelease,
	[Parameter(Mandatory = $false)]
	[string]$LogFile,
	[Parameter(Mandatory = $false)]
	[string]$TempFolder,
	[Parameter(Mandatory = $false)]
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
$Global:Packageroot = $Packageroot
$Global:AppName = $AppName
$Global:AppRelease = $AppRelease
$Global:LogFile = $LogFile
$Global:TempFolder = $TempFolder
$Global:DllPath = $DllPath
$Global:InputObject = $InputObject
# Change as needed

#################
### FUNCTIONS ###
#################
function Begin {
	##############################################
	#load Library dll
	$Global:Cs = Add-PpDll -DllPath $Global:DllPath
	##############################################

	#Begin
	Job_Start -JobType 'WS' -PackageName $Global:AppName -PackageVersion $Global:AppRelease -LogPath $Global:LogFile -Action 'INSTALL'
	Log_SectionHeader -Name 'Begin'
	Job_WriteLog -Text ("[Init]: Starting package: '" + $Global:AppName + "' Release: '" + $Global:AppRelease + "'")
	If (!(Sys_IsMinimumRequiredDiskspaceAvailable -Drive 'c:' -MinimumRequiredDiskspace 1500)) { Exit-PpMissingDiskSpace }
	Initialize-PpInputObject
	If ($global:DownloadPackage -and $Global:InputObject) { Start-PSDownloadPackage }
	Initialize-PpVariables -DllPath $Global:DllPath

	Job_WriteLog -Text ("[Init]: `$Global:Packageroot:` '" + $Global:Packageroot + "'")
	Job_WriteLog -Text ("[Init]: `$Global:AppName:` '" + $Global:AppName + "'")
	Job_WriteLog -Text ("[Init]: `$Global:AppRelease:` '" + $Global:AppRelease + "'")
	Job_WriteLog -Text ("[Init]: `$Global:LogFile:` '" + $Global:LogFile + "'")
	Job_WriteLog -Text ("[Init]: `$Global:TempFolder:` '" + $Global:TempFolder + "'")
	Job_WriteLog -Text ("[Init]: `$Global:DllPath:` '" + $Global:DllPath + "'")
	Job_WriteLog -Text ("[Init]: `$global:DownloadPackage`: '" + $global:DownloadPackage + "'")
}

function PreInstall {
	Log_SectionHeader -Name 'PreInstall'
}

function Install {
	Log_SectionHeader -Name 'Install'
}

function PostInstall {
	Log_SectionHeader -Name 'PostInstall'
}
############
### Main ###
############
try {
	Begin
	PreInstall
	Install
	PostInstall
	Exit-PpScript $Error
} catch {
	$line = $_.InvocationInfo.ScriptLineNumber
	Job_WriteLog -FunctionName '*****************' -Text "Something bad happend at line $$($line): $$($_.Exception.Message)"
	Exit-PpScript $_.Exception.HResult
}