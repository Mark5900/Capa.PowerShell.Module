# TODO: #101 Update and add tests

<#
	.SYNOPSIS
		Stops a service.

	.DESCRIPTION
		This function starts a service on the system.

	.PARAMETER ServiceName
		The name of the service.

	.PARAMETER MaxTimeout
		The maximum timeout in seconds to wait for the service to stop, default is 60 seconds.

	.EXAMPLE
		PS C:\> Service_Stop -ServiceName "gupdate"

	.EXAMPLE
		PS C:\> Service_Stop -ServiceName "gupdate" -MaxTimeout 120

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456023/cs.Service+Stop
#>
function Service_Stop {
	param (
		[Parameter(Mandatory = $true)]
		[string]$ServiceName,
		$MaxTimeout = ''
	)

	if ($MaxTimeout -eq '') {
		$Global:cs.Service_Stop($ServiceName)
	} else {
		$Global:cs.Service_Stop($ServiceName, $MaxTimeout)
	}
}
