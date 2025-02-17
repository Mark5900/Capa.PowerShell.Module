# TODO: #400 Add tests for Reg_GetInteger

<#
	.SYNOPSIS
		Gets a registry integer.

	.DESCRIPTION
		Gets a registry integer.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKEY_LOCAL_MACHINE, HKCU or HKU.

	.PARAMETER RegKey
		The path of the registry key.

	.PARAMETER RegValue
		The name of the registry value.

	.EXAMPLE
		PS C:\> Reg_GetInteger -RegRoot "HKLM" -RegKey "SOFTWARE\CapaSystems" -RegValue "Test"
#>
function Reg_GetInteger {
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKEY_LOCAL_MACHINE', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[string]$RegKey,
		[Parameter(Mandatory = $true)]
		[string]$RegValue
	)

	return $Global:cs.Reg_GetInteger($RegRoot, $RegKey, $RegValue)
}