# TODO: #92 Update and add tests

<#
	.SYNOPSIS
		Exists a registry key.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKEY_LOCAL_MACHINE, HKCU or HKU.

	.PARAMETER RegKey
		The path of the registry key.

	.EXAMPLE
		PS C:\> Reg_ExistKey -RegRoot "HKLM" -RegKey "SOFTWARE\CapaSystems"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455870/cs.Reg+ExistKey
#>
function Reg_ExistKey {
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKEY_LOCAL_MACHINE', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[string]$RegKey
	)

	$Value = $Global:cs.Reg_ExistKey($RegRoot, $RegKey)

	return $Value
}
