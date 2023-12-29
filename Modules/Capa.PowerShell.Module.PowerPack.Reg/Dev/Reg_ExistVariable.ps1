# TODO: #93 Update and add tests

<#
	.SYNOPSIS
		Exists a registry variable.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKEY_LOCAL_MACHINE, HKCU or HKU.

	.PARAMETER RegKey
		The path of the registry key.

	.PARAMETER RegVariable
		The name of the registry variable.

	.EXAMPLE
		PS C:\> Reg_ExistVariable -RegRoot "HKLM" -RegKey "SOFTWARE\CapaSystems" -RegVariable "Test"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455887/cs.Reg+ExistVariable
#>
function Reg_ExistVariable {
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKEY_LOCAL_MACHINE', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[string]$RegKey,
		[Parameter(Mandatory = $true)]
		[string]$RegVariable
	)

	$Value = $Global:cs.Reg_ExistVariable($RegRoot, $RegKey, $RegVariable)

	return $Value
}
