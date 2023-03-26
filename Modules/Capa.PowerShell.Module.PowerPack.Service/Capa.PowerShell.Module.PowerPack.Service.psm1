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

<#
	.SYNOPSIS
		Starts a service.

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

<#
	.SYNOPSIS
		Stops a service.

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