BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
    $RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

    $Folders = @(
        'Capa.PowerShell.Module.SDK.Authentication',
        'Capa.PowerShell.Module.SDK.Package',
        'Capa.PowerShell.Module.SDK.Unit',
        'Capa.PowerShell.Module.SDK.Group',
        'Capa.PowerShell.Module.SDK.Container'
    )
    foreach ($Folder in $Folders) {
        $Items = Get-ChildItem -Path "$RootPath\$Folder\Dev\" -Filter '*.ps1' | Where-Object { $_.Name -notlike '*Tests.ps1' }
        foreach ($Item in $Items) {
            Import-Module $Item.FullName -Force -ErrorAction Stop
        }
    }

	$oCMSDev = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint '1'
    $oCMSProd = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint '2'

	$PckFrom = @{
		CapaSDK           = $oCMSDev
		PackageName       = 'TestFrom'
		PackageVersion    = 'v1.0'
		DisplayName       = 'TestFrom v1.0'
		SqlServerInstance = $env:COMPUTERNAME
		Database          = 'CapaInstaller'
	}
	$PckTo = @{
		CapaSDK           = $oCMSDev
		PackageName       = 'TestTo'
		PackageVersion    = 'v1.0'
		DisplayName       = 'TestTo v1.0'
		SqlServerInstance = $env:COMPUTERNAME
		Database          = 'CapaInstaller'
	}
	New-CapaPowerPack @PckFrom
	New-CapaPowerPack @PckTo

    Initialize-CapaPackagePromote -CapaSDK $oCMSDev -PackageName 'TestFrom' -PackageVersion 'v1.0' -PackageType 'Computer'
    Initialize-CapaPackagePromote -CapaSDK $oCMSDev -PackageName 'TestTo' -PackageVersion 'v1.0' -PackageType 'Computer'

	Create-CapaGroup -CapaSDK $oCMSProd -GroupName 'TestGroup' -UnitType Computer -GroupType 'Static'

	Start-Sleep -Seconds 1

	$Unit = (Get-CapaUnits -CapaSDK $oCMSProd -Type Computer | Where-Object { $_.Name -eq $env:COMPUTERNAME })[0]

	Add-CapaUnitToGroup -CapaSDK $oCMSProd -UnitName $Unit.UUID -UnitType Computer -GroupName 'TestGroup' -GroupType 'Static'
	Add-CapaPackageToGroup -CapaSDK $oCMSProd -PackageName 'TestFrom' -PackageVersion 'v1.0' -PackageType Computer -GroupName 'TestGroup' -GroupType 'Static'

	Start-Sleep -Seconds 1
}
Describe 'Copy groups' {
	It 'Does the group exist in the destination package' {
		$Group = Get-CapaGroups -CapaSDK $oCMSProd -GroupType 'Static' | Where-Object { $_.Name -eq 'TestGroup' }
		$Group | Should -Not -BeNullOrEmpty
	}
	It 'Does the command work' {
		$Splat = @{
			CapaSDK            = $oCMSProd
			FromPackageName    = 'TestFrom'
			FromPackageVersion = 'v1.0'
			FromPackageType    = 'Computer'
			ToPackageName      = 'TestTo'
			ToPackageVersion   = 'v1.0'
			ToPackageType      = 'Computer'
			CopyGroups         = $true
		}
		$bStatus = Copy-CapaPackageRelation @Splat

		$bStatus | Should -Be $true
	}
	It 'Does the group have the correct package' {
		$Group = Get-CapaPackageGroups -CapaSDK $oCMSProd -PackageName 'TestTo' -PackageVersion 'v1.0' -PackageType Computer | Where-Object { $_.Name -eq 'TestGroup' }
		$Group | Should -Not -BeNullOrEmpty
	}
}
Describe 'Copy units' {
	It 'Does the unit exist in the destination package' {
		$Unit = Get-CapaUnits -CapaSDK $oCmsProd -Type Computer | Where-Object { $_.Name -eq $env:COMPUTERNAME }
		$Unit | Should -Not -BeNullOrEmpty
	}
	It 'Does the command work' {
		$Splat = @{
			CapaSDK            = $oCMSProd
			FromPackageName    = 'TestFrom'
			FromPackageVersion = 'v1.0'
			FromPackageType    = 'Computer'
			ToPackageName      = 'TestTo'
			ToPackageVersion   = 'v1.0'
			ToPackageType      = 'Computer'
			CopyUnits          = $true
		}
		$bStatus = Copy-CapaPackageRelation @Splat
		Start-Sleep -Seconds 5

		$bStatus | Should -Be $true
	}
	It 'Does the unit have the correct package' {
		$Unit = Get-CapaPackageUnits -CapaSDK $oCMSProd -PackageName 'TestTo' -PackageVersion 'v1.0' -PackageType Computer
		$Unit | Should -Not -BeNullOrEmpty
	}
}
Describe 'Copy groups and units' {
	It 'Does the command work' {
		$Splat = @{
			CapaSDK            = $oCMSProd
			FromPackageName    = 'TestFrom'
			FromPackageVersion = 'v1.0'
			FromPackageType    = 'Computer'
			ToPackageName      = 'TestTo'
			ToPackageVersion   = 'v1.0'
			ToPackageType      = 'Computer'
			CopyGroups         = $true
			CopyUnits          = $true
		}
		$bStatus = Copy-CapaPackageRelation @Splat
		Start-Sleep -Seconds 5

		$bStatus | Should -Be $true
	}
	It 'Does the group have the correct package' {
		$Group = Get-CapaPackageGroups -CapaSDK $oCMSProd -PackageName 'TestTo' -PackageVersion 'v1.0' -PackageType Computer | Where-Object { $_.Name -eq 'TestGroup' }
		$Group | Should -Not -BeNullOrEmpty
	}
	It 'Does the unit have the correct package' {
		$Unit = Get-CapaPackageUnits -CapaSDK $oCMSProd -PackageName 'TestTo' -PackageVersion 'v1.0' -PackageType Computer | Where-Object { $_.Name -eq $env:COMPUTERNAME }
		$Unit | Should -Not -BeNullOrEmpty
	}
}
Describe 'Try the rest of the parameters' {
	It 'Does the command work' {
		$Splat = @{
			CapaSDK                                 = $oCMSProd
			FromPackageName                         = 'TestFrom'
			FromPackageVersion                      = 'v1.0'
			FromPackageType                         = 'Computer'
			ToPackageName                           = 'TestTo'
			ToPackageVersion                        = 'v1.0'
			ToPackageType                           = 'Computer'
			UnlinkGroupsAndUnitsFromExistingPackage = $true
			DisableScheduleOnExistingPackage        = $true
			CopySchedule                            = $true
		}
		$bStatus = Copy-CapaPackageRelation @Splat

		$bStatus | Should -Be $true
	}
	It 'Should have no groups linked' {
		$Group = Get-CapaPackageGroups -CapaSDK $oCMSProd -PackageName 'TestFrom' -PackageVersion 'v1.0' -PackageType Computer
		$Group | Should -BeNullOrEmpty
	}
	It 'Should have no units linked' {
		$Unit = Get-CapaPackageUnits -CapaSDK $oCMSProd -PackageName 'TestFrom' -PackageVersion 'v1.0' -PackageType Computer
		$Unit | Should -BeNullOrEmpty
	}
}
AfterAll {
	Remove-CapaPackage -CapaSDK $oCMSProd -PackageName 'TestFrom' -PackageVersion 'v1.0' -PackageType Computer
	Remove-CapaPackage -CapaSDK $oCMSProd -PackageName 'TestTo' -PackageVersion 'v1.0' -PackageType Computer
    Remove-CapaPackage -CapaSDK $oCMSDev -PackageName 'TestFrom' -PackageVersion 'v1.0' -PackageType Computer
    Remove-CapaPackage -CapaSDK $oCMSDev -PackageName 'TestTo' -PackageVersion 'v1.0' -PackageType Computer
	Remove-CapaGroup -CapaSDK $oCMSProd -GroupName 'TestGroup' -GroupType 'Static' -UnitType Computer
}