class InputObject {
	[bool]$RebootRequested
	[int]$ExitCode
	[string]$ExceptionHResult
	[int]$DownloadProgress

	[string] ShowMessageBox($sCaption, $sText, $sButtons, $sDefault, $sIconStyle, $iTimeOut, $bAsync) {
		$Return = New-MessageBox -Message $sText -Title $sCaption -Buttons $sButtons -Icon $sIconStyle -Time $iTimeOut -AsString

		return $Return
	}

	DownloadPackage() {
		$SplitPath = $Global:Packageroot.Split('\')
		if ($SplitPath[-1] -eq 'kit') {
			$DestinationFolder = $Global:Packageroot
		} else {
			$DestinationFolder = Join-Path $Global:Packageroot 'kit'
		}

		$Splat = @{
			PackageName       = $Global:AppName
			PackageVersion    = $Global:AppRelease
			DestinationFolder = $DestinationFolder
		}
		Invoke-DownloadCapaPackage @Splat

		$Global:InputObject.DownloadProgress = 100
	}

	[string] SendData ($jParams) {
		$LocalPort = Get-ItemProperty -Path 'HKLM:\SOFTWARE\CapaSystems\BaseAgent' -Name 'LocalPort' | Select-Object -ExpandProperty LocalPort
		$BaseURL = "http://localhost:$LocalPort/data?language=powershell"

		$Response = Invoke-WebRequest -Uri $BaseURL -Method Post -Body $jParams -ContentType 'application/json'

		$JResponse = $Response.Content | ConvertFrom-Json
		if ($JResponse.result -eq $false -and $JResponse.xexception -ne 'None') {
			$JResponse | Add-Member -MemberType NoteProperty -Name 'Exception' -Value $JResponse.body.error
		}

		return $JResponse | ConvertTo-Json
	}
}

<#
	.SYNOPSIS
		Initialize the InputObject object.

	.DESCRIPTION
		Used in PowerPacks to initialize the InputObject object, if it is not already initialized.
		If you run a PowerPack script locally, then InputObject is null and you can use this function create a obejct to test your script.

		The only thing that does not work is CMS functions, because they need a real InputObject object.
		The message box is also not the real one, but a simple example.
#>
function Initialize-PpInputObject {
	if ($null -eq $Global:InputObject) {
		$Global:InputObject = [InputObject]::new()
	}
}