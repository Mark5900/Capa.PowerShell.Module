# TODO: #88 Update and add tests

<#
	.SYNOPSIS
		Creates a registry key.

	.DESCRIPTION
		This function creates a registry key at the specified path.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKCU or HKU.

	.PARAMETER RegPath
		The path of the registry key.

	.EXAMPLE
		PS C:\> Reg_CreateKey -RegRoot "HKLM" -RegPath "SOFTWARE\CapaSystems"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455819/cs.Reg+CreateKey
#>
function Reg_CreateKey {
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKEY_LOCAL_MACHINE', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[string]$RegPath
	)

	$Global:cs.Reg_CreateKey($RegRoot, $RegPath)
}
