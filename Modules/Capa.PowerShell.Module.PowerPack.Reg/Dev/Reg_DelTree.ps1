# TODO: #89 Update and add tests

<#
	.SYNOPSIS
		Deletes a registry tree.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKCU or HKU.

	.PARAMETER RegPath
		The path of the registry key.

	.PARAMETER RegKey
		The name of the registry key.

	.EXAMPLE
		PS C:\> Reg_DelTree -RegRoot "HKLM" -RegPath "SOFTWARE\CapaSystems" -RegKey "Test"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455836/cs.Reg+DelTree
#>
function Reg_DelTree {
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[string]$RegPath,
		[Parameter(Mandatory = $true)]
		[string]$RegKey
	)

	$Global:cs.Reg_DelTree($RegRoot, $RegPath, $RegKey)
}
