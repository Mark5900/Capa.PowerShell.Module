# TODO: #99 Update and add tests

<#
	.SYNOPSIS
		Determines if a service exists.

	.PARAMETER ServiceName
		The name of the service.

	.EXAMPLE
		PS C:\> Service_Exist -ServiceName "W32Time"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455989/cs.Service+Exist
#>
function Service_Exist {
	param (
		[Parameter(Mandatory = $true, Position = 0)]
		[string]$ServiceName
	)

	$Value = $Global:cs.Service_Exist($ServiceName)

	return $Value
}

