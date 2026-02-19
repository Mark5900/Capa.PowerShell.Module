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

	$PackageRoot = Get-ItemPropertyValue -Path 'registry::HKEY_LOCAL_MACHINE\SOFTWARE\CapaSystems\CapaInstaller' -Name 'Packageroot'
	if ($PackageRoot -match '\\\\[^\\]+\\Prod\\') {
		$PackageRoot = $PackageRoot.Replace('\Prod\', "\$env:COMPUTERNAME\")
	}

	$Script:ComputerJobPath = Join-Path $PackageRoot 'ComputerJobs'
	$Script:PackageName = "TestExpandKitFile$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
	$Script:PackageVersion = 'v1.0'
	$Script:ExpandDestination = Join-Path $env:TEMP "ExpandedKit_$($Script:PackageName)"

	if (Test-Path $Script:ExpandDestination) {
		Remove-Item -Path $Script:ExpandDestination -Force -Recurse
	}

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

	$Script:PackagePath = Join-Path $Script:ComputerJobPath $Script:PackageName $Script:PackageVersion
	$Script:KitFile = Join-Path $Script:PackagePath 'Zip' 'CapaInstaller.kit'
}

Describe 'Expand-KitFile integration' {
	It 'Kit file should exist on created package' {
		$Script:KitFile | Should -Exist
	}

	It 'Should expand kit file to destination folder' {
		Expand-KitFile -KitFile $Script:KitFile -DestinationFolder $Script:ExpandDestination

		$Script:ExpandDestination | Should -Exist
	}

	It 'Expanded destination should contain extracted content' {
		$ExpandedItems = Get-ChildItem -Path $Script:ExpandDestination -Recurse -Force -ErrorAction Stop
		$ExpandedItems.Count | Should -BeGreaterThan 0
	}
}

AfterAll {
	if (Test-Path $Script:ExpandDestination) {
		Remove-Item -Path $Script:ExpandDestination -Force -Recurse
	}

	if ($null -ne $oCMSProd) {
		Remove-CapaPackage -CapaSDK $oCMSProd -PackageName $Script:PackageName -PackageVersion $Script:PackageVersion -PackageType 'Computer' -Force 'True' | Out-Null
	}

	if ($null -ne $oCMSDev) {
		Remove-CapaPackage -CapaSDK $oCMSDev -PackageName $Script:PackageName -PackageVersion $Script:PackageVersion -PackageType 'Computer' -Force 'True' | Out-Null
	}
}