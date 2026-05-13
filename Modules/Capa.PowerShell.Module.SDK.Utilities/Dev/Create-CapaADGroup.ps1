<#
	.SYNOPSIS
		Create an CapaInstaller AD group.

	.DESCRIPTION
		Create an CapaInstaller AD group.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER GroupName
		The name of the group.

	.PARAMETER UnitType
		The type of the elements in the group. This can be either "Computer" or "User"

	.PARAMETER LDAPPath
		The LDAP path of the elements in the group.

	.PARAMETER recursive
		Indicates whether the group should be processed recursively.

	.EXAMPLE
		PS C:\> Create-CapaADGroup -CapaSDK $CapaSDK -GroupName 'TestGroup' -UnitType 'Computer' -LDAPPath 'LDAP://OU=TestOU,DC=capa,DC=local' -recursive 'true'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246216/Create+AD+group
#>
function Create-CapaADGroup {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$LDAPPath,
		[Parameter(Mandatory = $true)]
		[ValidateSet('true', 'false')]
		[String]$recursive
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'CreateADGroup')) {
		throw 'CapaSDK does not contain method CreateADGroup.'
	}

	$recursiveValue = $recursive.ToLowerInvariant()

	if ($PSCmdlet.ShouldProcess($GroupName, "Create AD group of type '$UnitType'")) {
		$value = $CapaSDK.CreateADGroup($GroupName, $UnitType, $LDAPPath, $recursiveValue)
		return $value
	}
}
