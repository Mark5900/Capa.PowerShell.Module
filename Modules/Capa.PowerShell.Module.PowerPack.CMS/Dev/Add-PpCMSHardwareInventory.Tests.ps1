BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

    $Folders = @(
        'Capa.PowerShell.Module.SDK.Authentication',
        'Capa.PowerShell.Module.SDK.Package',
        'Capa.PowerShell.Module.SDK.Unit',
        'Capa.PowerShell.Module.SDK.Utilities',
        'Capa.PowerShell.Module.SDK.Group',
        'Capa.PowerShell.Module.SDK.Inventory'
    )
    foreach ($Folder in $Folders) {
        $Items = Get-ChildItem -Path "$RootPath\$Folder\Dev\" -Filter '*.ps1' | Where-Object { $_.Name -notlike '*Tests.ps1' }
        foreach ($Item in $Items) {
            Import-Module $Item.FullName -Force -ErrorAction Stop
        }
    }

    $oCMSDev = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 1
    $oCMSProd = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 2

	$ScriptContent = Get-Content "$PSScriptRoot\HelpFilesForTests\Default.ps1" -Raw
	$FunctionCode = Get-Content $($PSCommandPath.Replace('.Tests.ps1', '.ps1')) -Raw
	$TestCode = '  $bStatus = Add-PpCMSHardwareInventory -Category "MyCategory" -Entry "MyEntry" -Value "MyValue" -ValueType "String"
	$cs.Job_WriteLog("Add-PpCMSHardwareInventory: bStatus = $bStatus")
	if ($bStatus){
		$cs.Job_WriteLog("Add-PpCMSHardwareInventory: Hardware inventory added successfully")
	} else {
		$cs.Job_WriteLog("Add-PpCMSHardwareInventory: Hardware inventory not added")
	}'

	$ScriptContent = $ScriptContent -replace '#FUNCTION', $FunctionCode -replace '#TESTCODE', $TestCode

	$SplattingPowerPack = @{
		CapaSDK              = $oCMSDev
		PackageName          = 'Test1'
		PackageVersion       = 'v1.0'
		DisplayName          = 'Test1'
		InstallScriptContent = $ScriptContent
		SqlServerInstance    = $env:COMPUTERNAME
		Database             = 'CapaInstaller'
		AllowInstallOnServer = $true
	}
	New-CapaPowerPack @SplattingPowerPack
    Initialize-CapaPackagePromote -CapaSDK $oCMSDev -PackageName 'Test1' -PackageVersion 'v1.0' -PackageType 'Computer'
	Add-CapaUnitToPackage -CapaSDK $oCMSProd -PackageName 'Test1' -PackageVersion 'v1.0' -PackageType 'Computer' -UnitName $env:COMPUTERNAME -UnitType 'Computer'
	Start-Sleep -Seconds 15

	Restart-CapaAgent -CapaSDK $oCMSProd -UnitName $env:COMPUTERNAME -UnitType 'Computer'

	Start-Sleep -Seconds 30
	$Run = $true
	while ($Run) {
		$Status = Get-CapaUnitPackageStatus -CapaSDK $oCMSProd -UnitName $env:COMPUTERNAME -UnitType 'Computer' -PackageName 'Test1' -PackageVersion 'v1.0'
		if ($Status -eq 'Installed' -or $Status -eq 'Failed') {
			$Run = $false
		} else {
			Start-Sleep -Seconds 5
		}
	}
}
Describe 'Add-PpCMSComputerToDepartmentGroup' {
	It 'The test package should exist' {
		$Exist = Exist-CapaPackage -CapaSDK $oCMSProd -Name 'Test1' -Version 'v1.0' -Type 'Computer'
		$Exist | Should -Be $true
	}
	It 'Should add the package to the unit' {
		$Status = Get-CapaUnitPackageStatus -CapaSDK $oCMSProd -UnitName $env:COMPUTERNAME -UnitType 'Computer' -PackageName 'Test1' -PackageVersion 'v1.0'
		$Status | Should -Be 'Installed'
	}
	It 'The log should contain the right text' {
		$LogPath = 'C:\Program Files\CapaInstaller\Client\Logs\Test1.log'
		$LogContent = Get-Content -Path $LogPath -Raw

		$LogContent | Should -Match 'Add-PpCMSHardwareInventory: bStatus = True'
		$LogContent | Should -Match 'Add-PpCMSHardwareInventory: Hardware inventory added successfully'
	}
	It 'Check the hardware inventory' {
		$HardwareInventory = Get-CapaHardwareInventoryForUnit -CapaSDK $oCMSProd -UnitName $env:COMPUTERNAME -UnitType 'Computer' | Where-Object { $_.Category -eq 'MyCategory' -and $_.Entry -eq 'MyEntry' }
		$HardwareInventory | Should -Not -BeNullOrEmpty
		$HardwareInventory.Value | Should -Be 'MyValue'
	}
}
AfterAll {
	Remove-CapaPackage -CapaSDK $oCMSProd -PackageName 'Test1' -PackageVersion 'v1.0' -PackageType 'Computer' -Force $true
    Remove-CapaPackage -CapaSDK $oCMSDev -PackageName 'Test1' -PackageVersion 'v1.0' -PackageType 'Computer' -Force $true

	Get-Module | Where-Object { $_.Name -like '*-Capa*' -or $_.Name -like '*-Pp*' } | Remove-Module

	# Start sleep to make sure the Package is deleted
	Start-Sleep -Seconds 5
}