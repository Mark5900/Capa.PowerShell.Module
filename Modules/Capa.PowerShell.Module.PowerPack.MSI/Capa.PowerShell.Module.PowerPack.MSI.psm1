function MSI_GetProductCodeFromMSI {
	param (
		[Parameter(Mandatory = $true)]
		[string]$MsiFile
	)
	
	$Value = $Global:Cs.MSI_GetProductCodeFromMSI($MsiFile)

	return $Value
}

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

function MSI_IsMSIFileInstalled {
	param (
		[Parameter(Mandatory = $true)]
		[string]$MsiFile
	)
	
	$Value = $Global:Cs.MSI_IsMSIFileInstalled($MsiFile)

	return $Value
}

function MSI_IsMSIGuidInstalled {
	param (
		[Parameter(Mandatory = $true)]
		[string]$MsiGuid
	)
	
	$Value = $Global:Cs.MSI_IsMSIGuidInstalled($MsiGuid)

	return $Value
}