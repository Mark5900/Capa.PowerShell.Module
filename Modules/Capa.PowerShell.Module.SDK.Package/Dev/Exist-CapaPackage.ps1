<#
	.SYNOPSIS
		Verifies if a package exists.

	.DESCRIPTION
		Veirfies if a package exists.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER Name
		The name of the package.

	.PARAMETER Type
		The type of package, can be either Computer or User.

	.PARAMETER Version
		The version of the package.

	.EXAMPLE
				PS C:\> Exist-CapaPackage -CapaSDK $CapaSDK -Name 'TestPackage' -Version 'v1.0.0' -Type 'Computer'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246874/Exist+package
#>
function Exist-CapaPackage {
	[CmdletBinding()]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$Name,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$Version,
		[Parameter(Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[string]$Type
	)

	if ($Type -eq 'Computer') {
		$Type = '1'
	} elseif ($Type -eq 'User') {
		$Type = '2'
	}

	$value = $CapaSDK.ExistPackage($Name, $Version, $Type)
	return $value
}
