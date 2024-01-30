<#
	.NOTES
	===========================================================================
	Created with:	Visual Studio Code
	Created on:		2024-01-30
	Created by:		Mark5900
	Organization:
	Filename:			MinorVersionSetSameStatus.ps1
	===========================================================================
	.DESCRIPTION
		Sets the status of all units that have the old package installed to have the same status on the new package.
#>
##################
### PARAMETERS ###
##################
# DO NOT CHANGE
$SettingsPath = Join-Path $PSScriptRoot 'Settings.json'
$Settings = Get-Content $SettingsPath | ConvertFrom-Json

$PackageName = "$($Settings.SoftwareName) $($Settings.SoftwareVersion)"
$NewPackageVersion = "p$($Settings.PackageVersion)"
$OldPackageVersion = "p$($Settings.OldPackageVersion)"
# Change as needed

##############
### SCRIPT ###
##############
try {
	$oCMS = Initialize-CapaSDK -Server $Settings.CapaServer -Database $Settings.Database
	$ManagementPoints = Get-CapaManagementPoint -CapaSDK $oCMS

	foreach ($Point in $ManagementPoints) {
		Write-Host "Running for Managemnet Point: $($Point.Name)"
		$oCMSCurrent = Initialize-CapaSDK -Server $Settings.CapaServer -Database $Settings.Database -InstanceManagementPoint $Point.Id

		$ExistOldPackage = Exist-CapaPackage -CapaSDK $oCMSCurrent -Name $PackageName -Version $OldPackageVersion -Type Computer
		if ($ExistOldPackage -eq $false) {
			Write-Host "The old package does not exist on $($Point.Name). Skipping point."
			continue
		} else {
			Write-Host "The old package exists on $($Point.Name)."
		}

		$ExistNewPackage = Exist-CapaPackage -CapaSDK $oCMSCurrent -Name $PackageName -Version $NewPackageVersion -Type Computer
		if ($ExistNewPackage -eq $false) {
			Write-Host "The new package does not exist on $($Point.Name). Skipping point."
			continue
		} else {
			Write-Host "The new package exists on $($Point.Name)."
		}

		$LinkedUnits = Get-CapaPackageUnits -CapaSDK $oCMSCurrent -PackageName $PackageName -PackageVersion $OldPackageVersion -PackageType Computer
		foreach ($Unit in $LinkedUnits) {
			$PackageStatusSplatting = @{
				CapaSDK        = $oCMSCurrent
				UnitName       = $Unit.Name
				UnitType       = 'Computer'
				PackageName    = $PackageName
				PackageVersion = $OldPackageVersion
			}
			$UnitPackageStatus = Get-CapaUnitPackageStatus @PackageStatusSplatting

			if ($UnitPackageStatus -eq 'Installed') {
				Write-Host "Adding $($Unit.Name) to the new package and sets the status to Installed."

				$PackageAddSplatting = @{
					CapaSDK        = $oCMSCurrent
					UnitName       = $Unit.Name
					UnitType       = 'Computer'
					PackageName    = $PackageName
					PackageVersion = $NewPackageVersion
					PackageType    = 'Computer'
				}
				$bStatus = Add-CapaUnitToPackage @PackageAddSplatting

				if ($bStatus -eq $false) {
					Write-Host "Failed to add $($Unit.Name) to the new package."
				}

				$PackageStatusSplatting = @{
					CapaSDK        = $oCMSCurrent
					UnitName       = $Unit.Name
					UnitType       = 'Computer'
					PackageName    = $PackageName
					PackageVersion = $NewPackageVersion
					Status         = 'Installed'
				}
				$bStatus = Set-CapaUnitPackageStatus @PackageStatusSplatting

				if ($bStatus -eq $false) {
					Write-Host "Failed to set the status to Installed for $($Unit.Name) on the new package."
				}
			}
		}
	}

} catch {
	Write-Error $Error[0]
}
