BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')

	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
	$Folders = @(
		'Capa.PowerShell.Module.SDK.Authentication',
		'Capa.PowerShell.Module.SDK.Package'
	)

	foreach ($Folder in $Folders) {
		$Items = Get-ChildItem -Path "$RootPath\$Folder\Dev\" -Filter '*.ps1' | Where-Object { $_.Name -notlike '*Tests.ps1' }
		foreach ($Item in $Items) {
			Import-Module $Item.FullName -Force -ErrorAction Stop
		}
	}

	$oCMSDev = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 1
	$oCMSProd = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 2

	$Script:PackageName = "TestInvokeDownload$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
	$Script:PackageVersion = 'v1.0'
	$Script:DestinationFolder = Join-Path $env:TEMP "InvokeDownload_$($Script:PackageName)"
	$Script:DownloadedKitPath = Join-Path $Script:DestinationFolder 'CapaInstaller.kit'

	if (Test-Path $Script:DestinationFolder) {
		Remove-Item -Path $Script:DestinationFolder -Force -Recurse
	}
	New-Item -Path $Script:DestinationFolder -ItemType Directory -Force | Out-Null

	$PowerPackSplatting = @{
		CapaSDK           = $oCMSDev
		PackageName       = $Script:PackageName
		PackageVersion    = $Script:PackageVersion
		SqlServerInstance = $env:COMPUTERNAME
		Database          = 'CapaInstaller'
	}

	New-CapaPowerPack @PowerPackSplatting | Out-Null
	Start-Sleep -Seconds 5
	Initialize-CapaPackagePromote -CapaSDK $oCMSDev -PackageName $Script:PackageName -PackageVersion $Script:PackageVersion -PackageType 'Computer'
	Start-Sleep -Seconds 5
}

Describe 'Invoke-DownloadCapaPackage integration' {
	It 'Should download and extract package to destination folder' {
		Invoke-DownloadCapaPackage -PackageName $Script:PackageName -PackageVersion $Script:PackageVersion -DestinationFolder $Script:DestinationFolder

		$Script:DestinationFolder | Should -Exist
		$Items = Get-ChildItem -Path $Script:DestinationFolder -Recurse -Force -ErrorAction Stop
		$Items.Count | Should -BeGreaterThan 0
	}

	It 'Should remove local CapaInstaller.kit after extraction' {
		$Script:DownloadedKitPath | Should -Not -Exist
	}
}

AfterAll {
	if (Test-Path $Script:DestinationFolder) {
		Remove-Item -Path $Script:DestinationFolder -Force -Recurse
	}

	if ($null -ne $oCMSProd) {
		Remove-CapaPackage -CapaSDK $oCMSProd -PackageName $Script:PackageName -PackageVersion $Script:PackageVersion -PackageType 'Computer' -Force 'True' | Out-Null
	}

	if ($null -ne $oCMSDev) {
		Remove-CapaPackage -CapaSDK $oCMSDev -PackageName $Script:PackageName -PackageVersion $Script:PackageVersion -PackageType 'Computer' -Force 'True' | Out-Null
	}
}