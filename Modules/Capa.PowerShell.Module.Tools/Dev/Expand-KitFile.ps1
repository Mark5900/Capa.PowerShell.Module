<#
	.SYNOPSIS
		Extracts a CapaInstaller kit file to a destination folder.

	.DESCRIPTION
		Extracts the content of a `.kit` file using the CapaInstaller COM extractor.

	.PARAMETER KitFile
		The full path to the `.kit` file that should be extracted.

	.PARAMETER DestinationFolder
		The folder where the kit content will be extracted.

	.EXAMPLE
		Expand-KitFile -KitFile 'C:\Temp\CapaInstaller.kit' -DestinationFolder 'C:\Temp\ExpandedKit'

	.NOTES
		Requires CapaInstaller to be installed on the machine.
#>
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