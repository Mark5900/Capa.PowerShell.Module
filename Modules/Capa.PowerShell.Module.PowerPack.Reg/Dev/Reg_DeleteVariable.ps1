<#
	.SYNOPSIS
		Deletes a registry value.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKCU or HKU.

	.PARAMETER RegPath
		The path of the registry key.

	.PARAMETER RegValue
		The name of the registry value.

	.EXAMPLE
		PS C:\> Reg_DeleteVariable -RegRoot "HKLM" -RegPath "SOFTWARE\CapaSystems" -RegValue "Test"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455802/cs.Reg+DeleteVariable
#>
function Reg_DeleteVariable {
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[string]$RegPath,
		[Parameter(Mandatory = $true)]
		[string]$RegValue
	)

	$Global:cs.Reg_DeleteVariable($RegRoot, $RegPath, $RegValue)
}
