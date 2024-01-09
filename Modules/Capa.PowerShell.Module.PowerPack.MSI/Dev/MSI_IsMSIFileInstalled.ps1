# TODO: #86 Update and add tests

<#
	.SYNOPSIS
		Checks if an MSI file is installed.

	.PARAMETER MsiFile
		The path to the MSI file.

	.EXAMPLE
		PS C:\> MSI_IsMSIFileInstalled -MsiFile "C:\Temp\test.msi"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455768/cs.MSI+IsMSIFileInstalled
#>
function MSI_IsMSIFileInstalled {
	param (
		[Parameter(Mandatory = $true)]
		[string]$MsiFile
	)

	$Value = $Global:Cs.MSI_IsMSIFileInstalled($MsiFile)

	return $Value
}
