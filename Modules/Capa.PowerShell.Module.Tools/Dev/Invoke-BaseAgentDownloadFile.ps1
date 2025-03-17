<#
	.SYNOPSIS
		Downloads a file from CI server using the BaseAgent.

	.DESCRIPTION
		Downloads a file from server using the BaseAgent.

	.PARAMETER RemotePath
		The path of the file to download.

	.PARAMETER LocalPath
		The folder or specific path where the file will be downloaded to.

	.EXAMPLE
		Invoke-BaseAgentDownloadFile -RemotePath "\Resources/AgentInstaller/CapaInstaller agent.xml" -LocalPath "c:\temp"

	.EXAMPLE
		Invoke-BaseAgentDownloadFile -RemotePath "\Resources/AgentInstaller/CapaInstaller agent.xml" -LocalPath "c:\temp\CapaInstaller agent.xml"

	.NOTES
		This function requires the Capa BaseAgent to be installed on the machine.
#>
function Invoke-BaseAgentDownloadFile {
	param (
		[Parameter(Mandatory = $true)]
		[string]$RemotePath,
		[Parameter(Mandatory = $true)]
		[string]$LocalPath
	)
	$LocalPort = Get-ItemProperty -Path 'HKLM:\SOFTWARE\CapaSystems\BaseAgent' -Name 'LocalPort' | Select-Object -ExpandProperty LocalPort
	$BaseURL = "http://localhost:$LocalPort/file"

	$FileName = Split-Path -Path $RemotePath -Leaf
	if (Test-Path $LocalPath -PathType Container) {
		$LocalPath = Join-Path -Path $LocalPath -ChildPath $FileName
	}

	$LocalPath = $LocalPath.Replace('/', '\')
	$LocalPath = $LocalPath.Replace('\', '\\')
	$RemotePath = $RemotePath.Replace('\', "/")

	$Json = "{
	`"remote-location`": `"$RemotePath`",
	`"local-location`": `"$LocalPath`",
	`"local-progress`": 0,
	`"tag`": `"Mark5900`"
}"

	$Response = Invoke-WebRequest -Uri $BaseURL -Method Post -Body $Json -ContentType 'application/json'
	if ($Response.Headers.Keys -contains 'Location') {
		$FileID = $Response.Headers.Location.Split('/')[-1]
	} else {
		throw 'Failed to download package'
	}

	Start-Sleep -Seconds 5

	$FileIdURL = "$BaseURL/$FileID"
	$Run = $true
	while ($Run) {
		$Result = Invoke-WebRequest -Uri $FileIdURL -Method Get
		if ($Result.Content -like '*"status": "completed"*') {
			$Run = $false
		} elseif ($Result.Content -like '*"status": "failed"*') {
			throw 'Failed to download package'
		}
		Start-Sleep -Seconds 1
	}
}