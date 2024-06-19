<#
	.SYNOPSIS
		Stops logging of a script.

	.DESCRIPTION
		Stops all started logging sesion started by running ITCE-StartScriptLoggin.

	.EXAMPLE
		PS C:\> Stop-ScriptLogging

	.NOTES
		This is a custom function created to have a standard way of starting logging in SDK scripts.
#>
function Stop-ScriptLoggingg {
	[CmdletBinding()]
	param ()
	$FunctionName = 'ITCE-StopScriptLogging'

	if ($Global:SDKScriptStopwatch) {
		# Display elapsed time from stopwatch.
		$Global:SDKScriptStopwatch.Stop()
		$linje = "`nElapsed time: $( $Global:SDKScriptStopwatch.Elapsed.Days) day(s) $( $Global:SDKScriptStopwatch.Elapsed.Hours) hour(s) $( $Global:SDKScriptStopwatch.Elapsed.Minutes) minute(s) $( $Global:SDKScriptStopwatch.Elapsed.Seconds) seconds $( $Global:SDKScriptStopwatch.Elapsed.Milliseconds) millisecond(s)"
		Write-Host $linje
		$Global:SDKScriptStopwatch = $null
	}

	Write-Output (''); # Insert line break just before stopping the transcript (for readability).

	try {
		While ($i -lt $Global:TranscriptSesions) {
			Write-Host "Stopping sesion $($Global:TranscriptSesions - $i) of $Global:TranscriptSesions"
			Stop-Transcript | Out-Null
			$i++
		}
		$Global:TranscriptSesions = $null
	} catch {
		Write-Host "Error stopping transcript: $($_.Exception.Message)" -ForegroundColor Red
		return $false
	}
	return $true
}
