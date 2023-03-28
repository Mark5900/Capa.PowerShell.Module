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

<#
	.SYNOPSIS
		Checks if an GUID is installed.

	.PARAMETER MsiGuid
		TMSI Productcode to check installation status of.

	.EXAMPLE
		PS C:\> MSI_IsMSIGuidInstalled -MsiGuid "{AC76BA86-1033-FF00-7760-BC15014EA700}"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455785/cs.MSI+IsMSIGuidInstalled
#>
function MSI_IsMSIGuidInstalled {
	param (
		[Parameter(Mandatory = $true)]
		[string]$MsiGuid
	)
	
	$Value = $Global:Cs.MSI_IsMSIGuidInstalled($MsiGuid)

	return $Value
}