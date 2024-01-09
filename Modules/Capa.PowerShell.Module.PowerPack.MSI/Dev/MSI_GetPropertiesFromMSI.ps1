# TODO: #84 Update and add tests

<#
	.SYNOPSIS
		Gets the values of properties from an MSI file.

	.PARAMETER MsiFile
		The path to the MSI file.

	.PARAMETER Property
		Array of properties to retrieve.

	.EXAMPLE
		PS C:\> MSI_GetPropertiesFromMSI -MsiFile "C:\Temp\test.msi" -Property @("ProductVersion","UpgradeCode","ProductCode","ProductName","Manufacture")

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455751/cs.MSI+GetPropertiesFromMSI
#>
function MSI_GetPropertiesFromMSI {
	param (
		[Parameter(Mandatory = $true)]
		[string]$MsiFile,
		[Parameter(Mandatory = $false)]
		[array]$Property
	)

	$Value = $Global:Cs.MSI_GetPropertiesFromMSI($MsiFile, $Property)

	return $Value
}
