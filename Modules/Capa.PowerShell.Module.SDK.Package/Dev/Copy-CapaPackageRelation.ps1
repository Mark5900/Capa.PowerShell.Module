<#
	.SYNOPSIS
		Custom funktion to copy a package relations.

	.DESCRIPTION
		Custom funktion to copy a package relations, that uses other CapaSDK functions.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER FromPackageName
		The name of the package to copy relations from.

	.PARAMETER FromPackageVersion
		The version of the package to copy relations from.

	.PARAMETER FromPackageType
	The type of the package to copy relations from, either Computer or User.

	.PARAMETER ToPackageName
		The name of the package to copy relationsto.

	.PARAMETER ToPackageVersion
		The version of the package to copy relations to.

	.PARAMETER ToPackageType
		The type of the package to copy relations to, either Computer or User.

	.PARAMETER CopyGroups
		If set to All, all groups will be copied. If set to None, no groups will be copied.

	.PARAMETER CopyUnits
		If set to All, all units will be copied. If set to None, no units will be copied.

	.PARAMETER UnlinkGroupsAndUnitsFromExistingPackage
		If set to true, all groups and units will be unlinked from the existing package.

	.PARAMETER DisableScheduleOnExistingPackage
		If set to true, the schedule will be disabled on the existing package.

	.PARAMETER CopySchedule
		If set to true, the schedule will be copied from the existing package.

	.EXAMPLE
		PS C:\> Copy-CapaPackageRelation @(
			CapaSDK = $CapaSDK
			FromPackageType = 'Winrar'
			FromPackageName = 'v3.0'
			FromPackageVersion = 'Computer'
			ToPackageType = 'Winrar'
			ToPackageName = 'v3.1'
			ToPackageVersion = 'Computer'
			CopyGroups = 'All'
			CopyUnits = "None"
			UnlinkGroupsAndUnitsFromExistingPackage = $true
			DisableScheduleOnExistingPackage = $true
			CopySchedule = $true
		)

	.NOTES
		Custom command.
#>
function Copy-CapaPackageRelation {
	[CmdletBinding()]
	[Alias('Copy-CapaPackageRelations')]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$FromPackageName,
		[Parameter(Mandatory = $true)]
		[string]$FromPackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$FromPackageType,
		[Parameter(Mandatory = $true)]
		[string]$ToPackageName,
		[Parameter(Mandatory = $true)]
		[string]$ToPackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$ToPackageType,
		[Parameter(Mandatory = $false)]
		[bool]$CopyGroups = $false,
		[Parameter(Mandatory = $false)]
		[bool]$CopyUnits = $false,
		[bool]$UnlinkGroupsAndUnitsFromExistingPackage = $false,
		[bool]$DisableScheduleOnExistingPackage = $false,
		[bool]$CopySchedule = $false
	)

	$AGroupCopyHasFailed = $false
	$AUnitCopyHasFailed = $false
	$AGroupUnlinkHasFailed = $false
	$AUnitUnlinkHasFailed = $false
	$FuctionSuccessful = $true

	#region Get data if needed
	if ($CopyGroups -or $UnlinkGroupsAndUnitsFromExistingPackage) {
		$AllFromGroups = Get-CapaPackageGroups -CapaSDK $CapaSDK -PackageName $FromPackageName -PackageVersion $FromPackageVersion -PackageType $FromPackageType
		$AllToGroups = Get-CapaPackageGroups -CapaSDK $CapaSDK -PackageName $ToPackageName -PackageVersion $ToPackageVersion -PackageType $ToPackageType
	}
	if ($CopyUnits -or $UnlinkGroupsAndUnitsFromExistingPackage) {
		$AllFromUnits = Get-CapaPackageUnits -CapaSDK $CapaSDK -PackageName $FromPackageName -PackageVersion $FromPackageVersion -PackageType $FromPackageType
		$AllToUnits = Get-CapaPackageUnits -CapaSDK $CapaSDK -PackageName $ToPackageName -PackageVersion $ToPackageVersion -PackageType $ToPackageType
		$AllUnits = Get-CapaUnits -CapaSDK $CapaSDK -Type $FromPackageType
	}
	if ($CopySchedule) {
		$FromPackage = Get-CapaPackages -CapaSDK $CapaSDK -Type $FromPackageType | Where-Object { $_.Name -eq $FromPackageName -and $_.Version -eq $FromPackageVersion }
	}
	#endregion

	##region Copy Groups and unlik groups
	if ($CopyGroups -or $UnlinkGroupsAndUnitsFromExistingPackage) {
		$Count = 1
		foreach ($Group in $AllFromGroups) {
			if ($CopyGroups) {
				Write-Progress -Activity "Copying group $($Group.Name)" -Status 'Progress' -PercentComplete (($Count / $AllFromGroups.Count) * 100)

				$AllreadyLinked = $AllToGroups | Where-Object { $_.Name -eq $Group.Name -and $_.Type -eq $Group.Type }
				if ($AllreadyLinked.Count -eq 0) {
					Write-Host "Adding group $($Group.Name) to package $($ToPackageName)"
					try {
						$bool = Add-CapaPackageToGroup -CapaSDK $CapaSDK -PackageName $ToPackageName -PackageVersion $ToPackageVersion -PackageType $ToPackageType -GroupName $Group.Name -GroupType $Group.Type
						if ($bool -eq $false) {
							Write-Error "Error: Failed to link group $($Group.Name)"
							$AGroupCopyHasFailed = $true
						}
					} catch {
						Write-Error "Error while copying group: $($_.Exception.Message)"
						$AGroupCopyHasFailed = $true
					}
				}
			}

			if ($UnlinkGroupsAndUnitsFromExistingPackage -and $AGroupCopyHasFailed -eq $false) {
				Write-Progress -Activity "Unlinking group $($Group.Name)" -Status 'Progress' -PercentComplete (($Count / $AllFromGroups.Count) * 100)

				try {
					$bool = Remove-CapaPackageFromGroup -CapaSDK $CapaSDK -PackageName $FromPackageName -PackageVersion $FromPackageVersion -PackageType $FromPackageType -GroupName $Group.Name -GroupType $Group.Type
					if ($bool -eq $false) {
						Write-Error "Error: Failed to unlink group $($Group.Name)"
						$AGroupUnlinkHasFailed = $true
					}
				} catch {
					Write-Error "Error while unlinking group: $($_.Exception.Message)"
					$AGroupUnlinkHasFailed = $true
				}
			}

			$Count++
		}

		Write-Progress -Activity 'Copying groups' -Status 'Completed' -PercentComplete 100 -Completed
	}
	#endregion

	#region Copy Units and unlink units
	if (($CopyUnits -or $UnlinkGroupsAndUnitsFromExistingPackage) -and $AGroupCopyHasFailed -eq $false) {
		$Count = 1
		foreach ($Unit in $AllFromUnits) {

			switch ($Unit.TypeName) {
				'Computers' {
					$UnitType = 'Computer'
				}
				'Users' {
					$UnitType = 'User'
				}
				Default {
					$UnitType = $Unit.TypeName
				}
			}

			$UnitUUID = $AllUnits | Where-Object { $_.GUID -eq $Unit.GUID } | Select-Object -ExpandProperty UUID

			if ($CopyUnits) {
				Write-Progress -Activity "Copying unit $($Unit.Name)" -Status 'Progress' -PercentComplete (($Count / $AllFromUnits.Count) * 100)

				$AllreadyLinked = $AllToUnits | Where-Object { $_.Name -eq $Unit.Name -and $_.Type -eq $UnitType }
				if ($AllreadyLinked.Count -eq 0) {
					try {
						$bool = Add-CapaUnitToPackage -CapaSDK $CapaSDK -PackageName $ToPackageName -PackageVersion $ToPackageVersion -PackageType $ToPackageType -UnitName $UnitUUID -UnitType $UnitType
						if ($bool -eq $false) {
							Write-Error "Error: Failed to link unit $($Unit.Name)"
							$AUnitCopyHasFailed = $true
						}
					} catch {
						Write-Error "Error while copying unit: $($_.Exception.Message)"
						$AUnitCopyHasFailed = $true
					}
				}
			}

			if ($UnlinkGroupsAndUnitsFromExistingPackage) {
				Write-Progress -Activity "Unlinking unit $($Unit.Name)" -Status 'Progress' -PercentComplete (($Count / $AllFromUnits.Count) * 100)

				try {
					$bool = Remove-CapaUnitFromPackage -CapaSDK $CapaSDK -PackageName $FromPackageName -PackageVersion $FromPackageVersion -PackageType $FromPackageType -UnitName $Unit.Name -UnitType $UnitType
					if ($bool -eq $false) {
						Write-Error "Error: Failed to unlink unit $($Unit.Name)"
						$AUnitUnlinkHasFailed = $true
					}
				} catch {
					Write-Error "Error while unlinking unit: $($_.Exception.Message)"
					$AUnitUnlinkHasFailed = $true
				}
			}

			$Count++
		}

		Write-Progress -Activity 'Copying units' -Status 'Completed' -PercentComplete 100 -Completed
	}
	#endregion


	# Disable Schedule On Existing Package
	if ($AGroupCopyHasFailed -eq $false -and $AUnitCopyHasFailed -eq $false -and $AGroupUnlinkHasFailed -eq $false -and $AUnitUnlinkHasFailed -eq $false) {
		if ($DisableScheduleOnExistingPackage -eq $true) {
			try {
				$bool = Disable-CapaPackageSchedule -CapaSDK $CapaSDK -PackageName $FromPackageName -PackageVersion $FromPackageVersion -PackageType $FromPackageType
				if ($bool -eq $false) {
					Write-Error "Error: Failed to disable schedule on package $($FromPackageName)"
					$FuctionSuccessful = $false
				}
			} catch {
				Write-Error "Error while disabling schedule: $($_.Exception.Message)"
				$FuctionSuccessful = $false
			}
		}
	}

			if ($CopySchedule) {
			$ScheduleSettings = Get-CapaSchedule -CapaSDK $CapaSDK -Id $FromPackage.ScheduleId
			try {
				$Splatting = @{
					CapaSDK        = $CapaSDK
					PackageName    = $ToPackageName
					PackageVersion = $ToPackageVersion
					PackageType    = $ToPackageType
				}
				if ($ScheduleSettings.ScheduleStart) {
					$Time = Get-Date $ScheduleSettings.ScheduleStart -Format 'yyyy-MM-dd HH:mm'
					$Splatting['ScheduleStart'] = $Time
				}
				if ($ScheduleSettings.ScheduleEnd) {
					$Time = Get-Date $ScheduleSettings.ScheduleEnd -Format 'yyyy-MM-dd HH:mm'
					$Splatting['ScheduleEnd'] = $Time
				}
				if ($ScheduleSettings.IntervalStart) {
					$Splatting['ScheduleIntervalBegin'] = $ScheduleSettings.IntervalStart
				}
				if ($ScheduleSettings.IntervalEnd) {
					$Splatting['ScheduleIntervalEnd'] = $ScheduleSettings.IntervalEnd
				}
				if ($ScheduleSettings.Recurrence) {
					if ($ScheduleSettings.Recurrence -eq 'Periodical') {
						if ($ScheduleSettings.Run -eq 'Daily') {
							$Splatting['ScheduleRecurrence'] = 'PeriodicalDaily'
						} else {
							$Splatting['ScheduleRecurrence'] = 'PeriodicalWeekly'
						}
					} else {
						$Splatting['ScheduleRecurrence'] = $ScheduleSettings.Recurrence
					}
				}
				if ($ScheduleSettings.RecurrencePattern) {
					$Splatting['ScheduleRecurrencePattern'] = $ScheduleSettings.RecurrencePattern
				}

				$bool = Set-CapaPackageSchedule @Splatting
				if ($bool -eq $false) {
					Write-Error "Error: Failed to set schedule on package $($ToPackageName)"
					$FuctionSuccessful = $false
				}
			} catch {
				Write-Error "Error while setting schedule: $($_.Exception.Message)"
				$FuctionSuccessful = $false
			}
		}

	if ($AGroupCopyHasFailed -or $AUnitCopyHasFailed -or $AGroupUnlinkHasFailed -or $AUnitUnlinkHasFailed) {
		$FuctionSuccessful = $false
	}

	if ($FuctionSuccessful -eq $false) {
		Write-Error 'Error: Copying package relations has errors'
	}

	Return $FuctionSuccessful
}
