# TODO: #399 Add tests for Reg_GetExpandString

<#
	.SYNOPSIS
		Gets a registry expand string.

	.DESCRIPTION
		Gets a registry expand string.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKEY_LOCAL_MACHINE, HKCU or HKU.

	.PARAMETER RegKey
		The path of the registry key.

	.PARAMETER RegValue
		The name of the registry value.

	.EXAMPLE
		PS C:\> Reg_GetExpandString -RegRoot "HKLM" -RegKey "SOFTWARE\CapaSystems" -RegValue "Test"
#>
function Reg_GetExpandString {
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKEY_LOCAL_MACHINE', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[string]$RegKey,
		[Parameter(Mandatory = $true)]
		[string]$RegValue
	)

	return $Global:cs.Reg_GetExpandString($RegRoot, $RegKey, $RegValue)
}