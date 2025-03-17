function Expand-KitFile {
	param (
		[Parameter(Mandatory = $true)]
		[string]$KitFile,
		[Parameter(Mandatory = $true)]
		[string]$DestinationFolder
	)

	$Obj = New-Object -ComObject CapaInstaller.Scripting.Extract
	$Obj.ExtractZip($KitFile, $DestinationFolder)
}