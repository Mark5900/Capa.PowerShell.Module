# TODO: #337 Update Get-Help for Invoke-PpCMSRunSystemAgent
<#
	.SYNOPSIS
		Reruns the CapaInstaller Service Agent

	.DESCRIPTION
		Sends a CallHome UnitCommand to the BaseAgent which in turn will request the Cistub service to run the Agent script in the system context.

	.PARAMETER Delay
		If the delay is empty, the command will be set to now.
		Delay examples: 10s (in 10 seconds), 5m (5 minutes) or 1h20m (1 hour and 20 minutes)

	.EXAMPLE
		$bStatus = Invoke-PpCMSRunSystemAgent -Delay "10s"
		if ($bStatus) {
			Job_WriteLog -Text "System Agent has been set to run in 10 seconds."
		} else {
			Job_WriteLog -Text "Failed to set System Agent to run in 10 seconds."
		}
#>
function Invoke-PpCMSRunSystemAgent {
	param (
		[Parameter(Mandatory = $false)]
		[string]$Delay
	)
	return CMS_RunSystemAgent -delay $Delay
}