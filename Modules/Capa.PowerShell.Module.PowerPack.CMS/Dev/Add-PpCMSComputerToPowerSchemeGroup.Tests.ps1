# Requires: A Power Scheme Groups called Test, that you create manually
BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Authentication\Dev\Initialize-CapaSDK.ps1"
	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Package\Dev\New-CapaPowerPack.ps1"
	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Package\Dev\Remove-CapaPackage.ps1"
	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Unit\Dev\Add-CapaUnitToPackage.ps1"
	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Package\Dev\Exist-CapaPackage.ps1"
	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Package\Dev\Import-CapaPackage.ps1"
	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Utilities\Dev\Restart-CapaAgent.ps1"
	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Unit\Dev\Get-CapaUnitPackageStatus.ps1"

	$oCMS = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 1

	$ScriptContent = Get-Content "$PSScriptRoot\HelpFilesForTests\Default.ps1" -Raw
	$FunctionCode = Get-Content $($PSCommandPath.Replace('.Tests.ps1', '.ps1')) -Raw
	$TestCode = '  $bStatus = Add-PpCMSComputerToPowerSchemeGroup -Group "Test"
	$cs.Job_WriteLog("Add-PpCMSComputerToPowerSchemeGroup: bStatus = $bStatus")
	if ($bStatus){
		$cs.Job_WriteLog("Add-PpCMSComputerToPowerSchemeGroup: Package added to unit")
	} else {
		$cs.Job_WriteLog("Add-PpCMSComputerToPowerSchemeGroup: Package not added to unit")
	}

	$bStatus = Add-PpCMSComputerToPowerSchemeGroup -Group "Servers"
	$cs.Job_WriteLog("Add-PpCMSComputerToPowerSchemeGroup: bStatus = $bStatus")
	if ($bStatus){
		$cs.Job_WriteLog("Add-PpCMSComputerToPowerSchemeGroup: Package added to unit")
	} else {
		$cs.Job_WriteLog("Add-PpCMSComputerToPowerSchemeGroup: Package not added to unit")
	}'

	$ScriptContent = $ScriptContent -replace '#FUNCTION', $FunctionCode -replace '#TESTCODE', $TestCode

	$SplattingPowerPack = @{
		CapaSDK              = $oCMS
		PackageName          = 'Test1'
		PackageVersion       = 'v1.0'
		DisplayName          = 'Test1'
		InstallScriptContent = $ScriptContent
		SqlServerInstance    = $env:COMPUTERNAME
		Database             = 'CapaInstaller'
		AllowInstallOnServer = $true
	}
	New-CapaPowerPack @SplattingPowerPack
	Add-CapaUnitToPackage -CapaSDK $oCMS -PackageName 'Test1' -PackageVersion 'v1.0' -PackageType 'Computer' -UnitName $env:COMPUTERNAME -UnitType 'Computer'
	Start-Sleep -Seconds 15

	Restart-CapaAgent -CapaSDK $oCMS -UnitName $env:COMPUTERNAME -UnitType 'Computer'

	Start-Sleep -Seconds 30
	$Run = $true
	while ($Run) {
		$Status = Get-CapaUnitPackageStatus -CapaSDK $oCMS -UnitName $env:COMPUTERNAME -UnitType 'Computer' -PackageName 'Test1' -PackageVersion 'v1.0'
		if ($Status -eq 'Installed' -or $Status -eq 'Failed') {
			$Run = $false
		} else {
			Start-Sleep -Seconds 5
		}
	}
}
Describe 'Add-PpCMSComputerToPowerSchemeGroup' {
	It 'The test package should exist' {
		$Exist = Exist-CapaPackage -CapaSDK $oCMS -Name 'Test1' -Version 'v1.0' -Type 'Computer'
		$Exist | Should -Be $true
	}
	It 'Should add the package to the unit' {
		$Status = Get-CapaUnitPackageStatus -CapaSDK $oCMS -UnitName $env:COMPUTERNAME -UnitType 'Computer' -PackageName 'Test1' -PackageVersion 'v1.0'
		$Status | Should -Be 'Installed'
	}
	It 'The log should contain the correct message' {
		$LogPath = 'C:\Program Files\CapaInstaller\Client\Logs\Test1.log'
		$LogContent = Get-Content -Path $LogPath -Raw

		$LogContent | Should -Match 'CMS_AddComputerToPowerSchemeGroup: Calling with group = Test'
		$LogContent | Should -Match 'Add-PpCMSComputerToPowerSchemeGroup: bStatus = True'
		$LogContent | Should -Match 'Add-PpCMSComputerToPowerSchemeGroup: Package added to unit'
	}
}
AfterAll {
	Remove-CapaPackage -CapaSDK $oCMS -PackageName 'Test1' -PackageVersion 'v1.0' -PackageType 'Computer' -Force $true

	Get-Module | Where-Object { $_.Name -like '*-Capa*' -or $_.Name -like '*-Pp*' } | Remove-Module
}