<#
	.SYNOPSIS
		Get the version of the CapaSDK dll.

	.DESCRIPTION
		Returns the version of the CapaSDK dll.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.EXAMPLE
		PS C:\> Get-CapaDllVersion -CapaSDK $CapaSDK

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI67DOC/pages/20342580699/Get+dll+version
#>
function Get-CapaDllVersion {
	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[object]$CapaSDK
	)

	$value = $CapaSDK.GetDLLVersion()
	return $value
}