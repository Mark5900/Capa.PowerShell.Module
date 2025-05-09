# TODO: #100 Update and add tests

<#
	.SYNOPSIS
		Starts a service.

	.DESCRIPTION
		This function starts a service on the system.

	.PARAMETER ServiceName
		The name of the service.

	.PARAMETER MaxTimeout
		The maximum timeout in seconds to wait for the service to start, default is 60 seconds.

	.EXAMPLE
		PS C:\> Service_Start -ServiceName "gupdate"

	.EXAMPLE
		PS C:\> Service_Start -ServiceName "gupdate" -MaxTimeout 120

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456006/cs.Service+Start
#>
function Service_Start {
	param (
		[Parameter(Mandatory = $true, Position = 0)]
		[string]$ServiceName,
		$MaxTimeout = ''
	)

	if ($MaxTimeout -eq '') {
		$Global:cs.Service_Start($ServiceName)
	} else {
		$Global:cs.Service_Start($ServiceName, $MaxTimeout)
	}
}
