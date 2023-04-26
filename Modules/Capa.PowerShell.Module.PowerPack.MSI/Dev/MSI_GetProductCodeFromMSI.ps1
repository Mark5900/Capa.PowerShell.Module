<#
	.SYNOPSIS
		Gets the product code of an MSI file.

	.PARAMETER MsiFile
		The path to the MSI file.

	.EXAMPLE
		PS C:\> MSI_GetProductCodeFromMSI -MsiFile "C:\Temp\test.msi"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455717/cs.MSI+GetProductCodeFromMSI
#>
function MSI_GetProductCodeFromMSI {
	param (
		[Parameter(Mandatory = $true)]
		[string]$MsiFile
	)
	
	$Value = $Global:Cs.MSI_GetProductCodeFromMSI($MsiFile)

	return $Value
}
