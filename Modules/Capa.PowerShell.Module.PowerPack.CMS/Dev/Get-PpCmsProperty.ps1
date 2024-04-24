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
function Get-PpCmsProperty {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('CapaOneOrgId', 'CapaOneOrgKey', 'CapaOneOrgName', 'CapaOneOrgTag')]
		[string]$Property
	)

	return CMS_GetProperty -prop $Property
}