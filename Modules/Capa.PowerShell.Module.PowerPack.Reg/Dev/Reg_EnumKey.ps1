# TODO: #91 Update and add tests

<#
	.SYNOPSIS
		Enumerates all registry keys.

	.DESCRIPTION
		This function enumerates all registry keys at the specified path.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKCU or HKU.

	.PARAMETER RegPath
		The path of the registry key.

	.PARAMETER MustExist
		Indicates if the registry key must exist, default is $true.

	.EXAMPLE
		PS C:\> Reg_EnumKey -RegRoot "HKLM" -RegPath "SOFTWARE\CapaSystems"

	.EXAMPLE
		PS C:\> Reg_EnumKey -RegRoot "HKLM" -RegPath "SOFTWARE\CapaSystems" -MustExist $false

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455853/cs.Reg+EnumKey
#>
function Reg_EnumKey {
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[string]$RegPath,
		[bool]$MustExist = $true
	)

	$Global:cs.Reg_EnumKey($RegRoot, $RegPath, $MustExist)
}
