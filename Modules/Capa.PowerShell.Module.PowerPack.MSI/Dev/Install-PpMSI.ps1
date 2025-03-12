function Install-Msi {
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $true)]
		[string]$FilePath,
		[Parameter(Mandatory = $false)]
		[string]$Arguments
	)
	$LogPrefix = "Install-Msi:"
	Job_WriteLog -Text "$LogPrefix FilePath: $FilePath, Arguments: $Arguments"

	$LogFolder = Split-Path $LogFile -Parent
	$MsiLogFolder = Join-Path $LogFolder 'MSILogs'
	$msiFile = Split-Path $msiFilePath -Leaf
	$msiLog = $MsiLogFolder + '\' + $msiFile + '_install.log'

	File_CreateDir -Path $MsiLogFolder

	$RetValue = Shell_Execute -Command 'msiexec.exe' -Arguments "/i `"$FilePath`" $Arguments /l*vx `"$msiLog`""
	Job_WriteLog -Text "$LogPrefix Return value: $RetValue"
	f ($retvalue -ne 0) {Exit-PpScript -ExitCode $retvalue}
}