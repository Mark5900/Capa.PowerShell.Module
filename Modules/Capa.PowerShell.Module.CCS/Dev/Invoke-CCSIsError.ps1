function Invoke-CCSIsError {
	param (
		[Parameter(Mandatory = $true)]
		[string]$Result
	)

	switch -Wildcard ($Result) {
		'*does not exist*' {
			return $true
		}
		'The server is unwilling to process the request*' {
			return $true
		}
		default {
			return $false
		}
	}
}