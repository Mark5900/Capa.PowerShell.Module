<#
	.SYNOPSIS
		Downloads a Capa package from CI server using the BaseAgent.

	.DESCRIPTION
		Downloads a Capa package from server using the BaseAgent.

	.PARAMETER PackageName
		The name of the package to download.

	.PARAMETER PackageVersion
		The version of the package to download.

	.PARAMETER DestinationFolder
		The folder where the package will be downloaded and extracted to.

	.EXAMPLE
		Invoke-DownloadCapaPackage -PackageName 'CP CapaDrivers Latitude 5440' -PackageVersion 'W10 Custom' -DestinationFolder 'c:\temp\Test'

	.NOTES
		This function requires the Capa BaseAgent to be installed on the machine.
#>
function Invoke-DownloadCapaPackage {
	param (
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[string]$DestinationFolder
	)
	$LocalPort = Get-ItemProperty -Path 'HKLM:\SOFTWARE\CapaSystems\BaseAgent' -Name 'LocalPort' | Select-Object -ExpandProperty LocalPort
	$BaseURL = "http://localhost:$LocalPort/file"
	$RemotePath = "/ComputerJobs/$PackageName/$PackageVersion/Zip/CapaInstaller.kit"

	$KitLocalPath = Join-Path $DestinationFolder 'CapaInstaller.kit'
	$KitLocalPath = $KitLocalPath.Replace('\', '\\')

	$Json = "{
	`"remote-location`": `"$RemotePath`",
	`"local-location`": `"$KitLocalPath`",
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

	$Obj = New-Object -ComObject CapaInstaller.Scripting.Extract
	$Obj.ExtractZip($KitLocalPath, $DestinationFolder)

	Remove-Item -Path $KitLocalPath -Force
}