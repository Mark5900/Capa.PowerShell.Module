# TODO: Update and add tests

<#
	.SYNOPSIS
		Sets a registry dword.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKEY_LOCAL_MACHINE, HKCU or HKU.

	.PARAMETER RegKey
		The path of the registry key.

	.PARAMETER RegValue
		The name of the registry value.

	.PARAMETER RegData
		The data of the registry value.

	.EXAMPLE
		PS C:\> Reg_SetDword -RegRoot "HKLM" -RegKey "SOFTWARE\CapaSystems" -RegValue "Test" -RegData 1

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455921/cs.Reg+SetDword
#>
function Reg_SetDword {
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKEY_LOCAL_MACHINE', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[string]$RegKey,
		[Parameter(Mandatory = $true)]
		[string]$RegValue,
		[Parameter(Mandatory = $true)]
		[int]$RegData
	)

	$Global:cs.Reg_SetDword($RegRoot, $RegKey, $RegValue, $RegData)
}
