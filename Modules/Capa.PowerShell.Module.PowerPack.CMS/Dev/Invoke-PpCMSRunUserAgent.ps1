# TODO: #339 Update Get-Help for Invoke-PpCMSRunUserAgent
<#
	.SYNOPSIS
		Sends a CallHomeUser UnitCommand to the BaseAgent which in turn will request the InfoCenter to run the Agent script in the user context.

	.DESCRIPTION
		Sends a CallHomeUser UnitCommand to the BaseAgent which in turn will request the InfoCenter to run the Agent script in the user context.

	.PARAMETER Delay
		If the delay is empty, the command will be set to now.
		Delay examples: 10s (in 10 seconds), 5m (5 minutes) or 1h20m (1 hour and 20 minutes)

	.EXAMPLE
		$bStatus = Invoke-PpCMSRunUserAgent -Delay "10s"
		if ($bStatus) {
			Job_WriteLog -Text "User Agent has been set to run in 10 seconds."
		} else {
			Job_WriteLog -Text "Failed to set User Agent to run in 10 seconds."
		}
#>
function Invoke-PpCMSRunUserAgent {
	param (
		[Parameter(Mandatory = $false)]
		[string]$Delay
	)
	return CMS_RunUserAgent -delay $Delay
}