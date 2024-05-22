# TODO: #290 Update Get-Help for Get-PpCMSProperty
<#
	.SYNOPSIS
		Returns a property from the property table in the SQL database

	.DESCRIPTION
		Returns a property from the property table in the SQL database

	.PARAMETER Property
		The property to return, must be one of the following: CapaOneOrgId, CapaOneOrgKey, CapaOneOrgName, CapaOneOrgTag

	.EXAMPLE
		$value = Get-PpCmsProperty -Property CapaOneOrgId
		Job_WriteLog -Text "CapaOneOrgId: $value"
#>
function Get-PpCMSProperty {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('CapaOneOrgId', 'CapaOneOrgKey', 'CapaOneOrgName', 'CapaOneOrgTag')]
		[string]$Property
	)

	return CMS_GetProperty -prop $Property
}