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
	[CmdletBinding(SupportsShouldProcess = $true)]
	[OutputType([void])]
	param (
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$KitFile,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$DestinationFolder
	)

	if ($PSCmdlet.ShouldProcess($KitFile, "Extract kit file to '$DestinationFolder'")) {
		$Obj = New-Object -ComObject CapaInstaller.Scripting.Extract
		$Obj.ExtractZip($KitFile, $DestinationFolder)
	}
}