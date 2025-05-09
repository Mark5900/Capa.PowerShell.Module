# TODO: #110 Update and add tests

<#
	.SYNOPSIS
		Get the version of the CapaSDK dll.

	.DESCRIPTION
		Returns the version of the CapaSDK dll.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.EXAMPLE
		PS C:\> Get-CapaDllVersion

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI67DOC/pages/20342580699/Get+dll+version
#>
function Get-CapaDllVersion {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[object]$CapaSDK
	)

    $value = $CapaSDK.GetDLLVersion()
    return $value
}