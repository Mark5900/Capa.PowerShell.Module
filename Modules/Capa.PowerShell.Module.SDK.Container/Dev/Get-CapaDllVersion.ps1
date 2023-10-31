# TODO: Update and add tests

<#
	.SYNOPSIS
		Get the version of the CapaSDK dll.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.EXAMPLE
		PS C:\> Get-CapaDllVersion

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246124/Get+dll+version
#>
function Get-CapaDllVersion {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)

    $value = $CapaSDK.GetDLLVersion()
    return $value
}