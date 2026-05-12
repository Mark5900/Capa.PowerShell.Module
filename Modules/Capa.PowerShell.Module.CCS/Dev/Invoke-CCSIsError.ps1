function Invoke-CCSIsError {
	[CmdletBinding()]
	[OutputType([bool])]
	param (
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$Result
	)

	switch -Wildcard ($Result) {
		'*does not exist*' {
			return $true
		}
		'The server is unwilling to process the request*' {
			return $true
		}
		'Computer does not exist*' {
			return $true
		}
		'The server is not operational*' {
			return $true
		}
		default {
			return $false
		}
	}
}