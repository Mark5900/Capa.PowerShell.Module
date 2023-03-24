function Service_Exist {
	param (
		[Parameter(Mandatory = $true, Position = 0)]
		[string]$ServiceName
	)
	
	$Value = $Global:cs.Service_Exist($ServiceName)

	return $Value
}

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