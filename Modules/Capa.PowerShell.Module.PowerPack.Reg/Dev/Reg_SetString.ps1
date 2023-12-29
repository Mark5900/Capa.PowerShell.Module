# TODO: #98 Update and add tests

<#
	.SYNOPSIS
		Sets a registry string.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKEY_LOCAL_MACHINE, HKCU or HKU.

	.PARAMETER RegKey
		The path of the registry key.

	.PARAMETER RegValue
		The name of the registry value.

	.PARAMETER RegData
		The data of the registry value.

	.EXAMPLE
		PS C:\> Reg_SetString -RegRoot "HKLM" -RegKey "SOFTWARE\CapaSystems" -RegValue "Test" -RegData "Test1"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455972/cs.Reg+SetString
#>
function Reg_SetString {
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKEY_LOCAL_MACHINE', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[string]$RegKey,
		[Parameter(Mandatory = $true)]
		[string]$RegValue,
		[Parameter(Mandatory = $true)]
		[string]$RegData
	)

	$Global:cs.Reg_SetString($RegRoot, $RegKey, $RegValue, $RegData)
}
