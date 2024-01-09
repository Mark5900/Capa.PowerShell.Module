# TODO: #85 Update and add tests

<#
	.SYNOPSIS
		Gets the value of a property from an MSI file.

	.PARAMETER MsiFile
		The path to the MSI file.

	.PARAMETER Property
		The property to get the value from.

	.EXAMPLE
		PS C:\> MSI_GetPropertyFromMSI -MsiFile "C:\Temp\test.msi" -Property "ProductVersion"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455734/cs.MSI+GetPropertyFromMSI
#>
function MSI_GetPropertyFromMSI {
	param (
		[Parameter(Mandatory = $true)]
		[string]$MsiFile,
		[Parameter(Mandatory = $true)]
		[string]$Property
	)

	$Value = $Global:Cs.MSI_GetPropertyFromMSI($MsiFile, $Property)

	return $Value
}
