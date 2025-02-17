# TODO: #402 Create tests for Reg_SetQword

<#
	.SYNOPSIS
		Sets a registry QWORD value.

	.DESCRIPTION
		Sets a registry QWORD value.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKEY_LOCAL_MACHINE, HKCU or HKU.

	.PARAMETER RegKey
		The path of the registry key.

	.PARAMETER RegValue
		The name of the registry value.

	.PARAMETER RegData
		The data to set.

	.EXAMPLE
		PS C:\> Reg_SetQword -RegRoot "HKLM" -RegKey "SOFTWARE\CapaSystems" -RegValue "Test" -RegData 123
#>
function Reg_SetQword {
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

	return $Global:cs.Reg_SetQword($RegRoot, $RegKey, $RegValue, $RegData)
}