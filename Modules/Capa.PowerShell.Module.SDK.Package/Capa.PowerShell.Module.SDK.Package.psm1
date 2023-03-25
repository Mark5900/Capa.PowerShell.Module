<#
	.SYNOPSIS
		Adds a package to a business unit.
	
	.DESCRIPTION
		Adds a package to a business unit.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER PackageName
		The name of the package.
	
	.PARAMETER PackageVersion
		The version of the package.
	
	.PARAMETER PackageType
		The type of the package, either Computer or User.

	.PARAMETER BusinessUnitName
		The name of the business unit.
	
	.EXAMPLE
		PS C:\> Add-CapaPackageToBusinessUnit -CapaSDK $CapaSDK -PackageName 'Winrar' -PackageVersion 'v3.0' -PackageType Computer -BusinessUnitName 'HeadQuarterBronx'
	
	.NOTES
		for more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246796/Add+Package+to+BusinessUnit
#>
function Add-CapaPackageToBusinessUnit {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		$PackageName,
		[Parameter(Mandatory = $true)]
		$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User', '1', '2')]
		$PackageType,
		[Parameter(Mandatory = $true)]
		$BusinessUnitName
	)
	
	if ($PackageType -eq 'Computer') {
		$PackageType = '1'
	}
	if ($PackageType -eq 'User') {
		$PackageType = '2'
	}
	
	$value = $CapaSDK.AddPackageToBusinessUnit($PackageName, $PackageVersion, $PackageType, $BusinessUnitName)
	
	return $value
}

<#
	.SYNOPSIS
		Adds a package to a group.
	
	.DESCRIPTION
		Adds a package to a group.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER PackageName
		The name of the package.
	
	.PARAMETER PackageVersion
		The version of the package.
	
	.PARAMETER PackageType
		The type of the package, either Computer or User.
	
	.PARAMETER GroupName
		The name of the group.
	
	.PARAMETER GroupType
		The type of the group, either Dynamic_ADSI, Calendar, Department, Dynamic_SQL, Reinstall, Security or Static.
	
	.EXAMPLE
		PS C:\> Add-CapaPackageToGroup -CapaSDK $CapaSDK -PackageName 'Winrar' -PackageVersion 'v3.0' -PackageType Computer -GroupName 'Bronx' -GroupType 'Dynamic_ADSI'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246807/Add+package+to+group
#>
function Add-CapaPackageToGroup {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[string]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Security', 'Static')]
		[string]$GroupType
	)
	
	$bool = $CapaSDK.AddPackageToGroup($PackageName, $PackageVersion, $PackageType, $GroupName, $GroupType)
	Return $bool
}

<#
	.SYNOPSIS
		Adds a package to a management server.
	
	.DESCRIPTION
		Adds a package to a management server.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER PackageName
		The name of the package.
	
	.PARAMETER PackageVersion
		The version of the package.
	
	.PARAMETER PackageType
		The type of the package, either Computer or User.
	
	.PARAMETER ServerName
		The name of the server.
	
	.EXAMPLE
		PS C:\> Add-CapaPackageToManagementServer -CapaSDK $CapaSDK -PackageName 'Winrar' -PackageVersion 'v3.0' -PackageType Computer -ServerName 'Server1'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246815/Add+package+to+management+server
#>
function Add-CapaPackageToManagementServer {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[string]$ServerName
	)
	
	if ($PackageType -eq 'Computer') {
		$PackageType = '1'
	}
	if ($PackageType -eq 'User') {
		$PackageType = '2'
	}
	
	$value = $CapaSDK.AddPackageToManagementServer($PackageName, $PackageVersion, $PackageType, $ServerName)
	return $value
}

<#
	.SYNOPSIS
		Clone a package in Root Point.
	
	.DESCRIPTION
		Clone a package in Root Point.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER PackageName
		The name of the package.
	
	.PARAMETER PackageVersion
		The version of the package.
	
	.PARAMETER PackageType
		The type of the package, either Computer or User.
	
	.PARAMETER NewVersion
		The new version of the package.
	
	.EXAMPLE
		PS C:\> Clone-CapaPackage -CapaSDK $CapaSDK -PackageName 'Winrar' -PackageVersion 'v3.0' -PackageType Computer -NewVersion 'v3.1'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246823/Clone+Package
#>
function Clone-CapaPackage {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[string]$NewVersion
	)
	
	$value = $CapaSDK.ClonePackage($PackageName, $PackageVersion, $PackageType, $NewVersion)
	return $value
}

<#
	.SYNOPSIS
		Copy a package in Root Point.
	
	.DESCRIPTION
		Copy a package in Root Point.
	
	.PARAMETER CapaSDK
		the CapaSDK object.

	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The version of the package.

	.PARAMETER PackageType
		The type of the package, either Computer or User.

	.PARAMETER NewName
		The new name of the package.

	.PARAMETER NewVersion
		The new version of the package.
	
	.EXAMPLE
		PS C:\> Copy-CapaPackage -CapaSDK $CapaSDK -PackageName 'Winrar' -PackageVersion 'v3.0' -PackageType Computer -NewName 'Winrar' -NewVersion 'v3.1'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246842/Copy+Package
#>
function Copy-CapaPackage {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[string]$NewName,
		[Parameter(Mandatory = $true)]
		[string]$NewVersion
	)
	
	if ($PackageType -eq 'Computer') {
		$PackageType = '1'
	}
	if ($PackageType -eq 'User') {
		$PackageType = '2'
	}
	
	$value = $CapaSDK.CopyPackage($PackageName, $PackageVersion, $PackageType, $NewName, $NewVersion)
	return $value
}

<#
	.SYNOPSIS
		Custom funktion to copy a package relations.
	
	.DESCRIPTION
		Custom funktion to copy a package relations, that uses other CapaSDK functions.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER FromPackageType
		The type of the package to copy relations from, either Computer or User.
	
	.PARAMETER FromPackageName
		The name of the package to copy relations from.
	
	.PARAMETER FromPackageVersion
		The version of the package to copy relations from.
	
	.PARAMETER ToPackageType
		The type of the package to copy relations to, either Computer or User.
	
	.PARAMETER ToPackageName
		The name of the package to copy relationsto.
	
	.PARAMETER ToPackageVersion
		The version of the package to copy relations to.
	
	.PARAMETER CopyGroups
		If set to All, all groups will be copied. If set to None, no groups will be copied.
	
	.PARAMETER CopyUnits
		If set to All, all units will be copied. If set to None, no units will be copied.
	
	.PARAMETER UnlinkGroupsAndUnitsFromExistingPackage
		If set to true, all groups and units will be unlinked from the existing package.
	
	.PARAMETER DisableScheduleOnExistingPackage
		If set to true, the schedule will be disabled on the existing package.
	
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
		)
	
	.NOTES
		Custom command.
#>
function Copy-CapaPackageRelation {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$FromPackageType,
		[Parameter(Mandatory = $true)]
		[string]$FromPackageName,
		[Parameter(Mandatory = $true)]
		[string]$FromPackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$ToPackageType,
		[Parameter(Mandatory = $true)]
		[string]$ToPackageName,
		[Parameter(Mandatory = $true)]
		[string]$ToPackageVersion,
		[Parameter(Mandatory = $false)]
		[ValidateSet('All', 'None')]
		[string]$CopyGroups = 'None',
		[Parameter(Mandatory = $false)]
		[ValidateSet('All', 'None')]
		[string]$CopyUnits = 'None',
		[bool]$UnlinkGroupsAndUnitsFromExistingPackage = $false,
		[bool]$DisableScheduleOnExistingPackage = $false
	)
	
	$AGroupCopyHasFailed = $false
	$AUnitCopyHasFailed = $false
	$AGroupUnlinkHasFailed = $false
	$AUnitUnlinkHasFailed = $false
	$FuctionSuccessful = $true
	
	# Get data if needed
	if ($CopyGroups -eq 'All' -or $UnlinkGroupsAndUnitsFromExistingPackage -eq $true) {
		$AllFromGroups = Get-CapaPackageGroups -CapaSDK $CapaSDK -PackageName $FromPackageName -PackageType $FromPackageType -PackageVersion $FromPackageVersion
		$AllToGroups = Get-CapaPackageGroups -CapaSDK $CapaSDK -PackageName $ToPackageName -PackageType $ToPackageType -PackageVersion $ToPackageVersion
		Write-Host "$($AllFromGroups.Count) linked groups"
	}
	if ($CopyUnits -eq 'All' -or $UnlinkGroupsAndUnitsFromExistingPackage -eq $true) {
		$AllFromUnits = Get-CapaPackageUnits -CapaSDK $CapaSDK -PackageName $FromPackageName -PackageVersion $FromPackageVersion -PackageType $FromPackageType
		$AllToUnits = Get-CapaPackageUnits -CapaSDK $CapaSDK -PackageName $ToPackageName -PackageVersion $ToPackageVersion -PackageType $ToPackageType
		Write-Host "$($AllFromUnits.Count) linked units"
	}
	
	# Copy Groups
	if ($CopyGroups -eq 'All') {
		foreach ($Group in $AllFromGroups) {
			Write-Host "Adding package to group: $($Group.Name)"
			$bool = Add-CapaPackageToGroup -CapaSDK $CapaSDK -PackageName $ToPackageName -PackageVersion $ToPackageVersion -PackageType $ToPackageType -GroupName $Group.Name -GroupType $Group.Type
			if ($bool -eq $false) {
				# Is it already added to the group
				$Check = $AllToGroups | Where-Object { $_.Name -eq $Group.Name -and $_.Type -eq $Group.Type }
				
				if ($Check.Count -eq 1) {
					Write-Host 'Group is already linked'
				} else {
					Write-Host "$bool" -ForegroundColor Red
					$AGroupCopyHasFailed = $true
				}
			} else {
				Write-Host "$bool"
			}
		}
	}
	
	# Copy Units
	if ($CopyUnits -eq 'All') {
		foreach ($Unit in $AllFromUnits) {
			
			$bool = Add-CapaUnitToPackage -CapaSDK $CapaSDK -PackageType $ToPackageType -PackageName $ToPackageName -PackageVersion $ToPackageVersion -UnitName $Unit.Name -UnitType $Unit.TypeName
			if ($bool -eq $false) {
				# Is it already added to the unit
				$Check = $AllToUnits | Where-Object { $_.Name -eq $Unit.Name -and $_.TypeName -eq $Unit.TypeName }
				
				if ($Check.Count -eq 1) {
					Write-Host 'Unit is already linked'
				} else {
					Write-Host "$bool" -ForegroundColor Red
					$AUnitCopyHasFailed = $true
				}
			} else {
				Write-Host "$bool"
			}
		}
	}
	
	If ($AGroupCopyHasFailed -eq $true -or $AUnitCopyHasFailed -eq $true) {
		Write-Host 'Skipping:' -ForegroundColor Red
		Write-Host '    Unlink Groups And Units From Existing Package' -ForegroundColor Red
		Write-Host '    Disable Schedule On Existing Package' -ForegroundColor Red
		Write-Host ''
		Write-Host 'Because copying a group- or unit link failed' -ForegroundColor Red
		$FuctionSuccessful = $false
	} else {
		# Unlink Groups And Units From Existing Package
		if ($UnlinkGroupsAndUnitsFromExistingPackage -eq $true) {
			foreach ($Group in $AllFromGroups) {
				Write-Host "Unlinking group $($Group.Name)"
				$bool = Remove-CapaPackageFromGroup -CapaSDK $CapaSDK -PackageName $FromPackageName -PackageVersion $FromPackageVersion -PackageType $FromPackageType -GroupName $Group.Name -GroupType $Group.Type
				if ($bool -eq $false) {
					Write-Host "$bool" -ForegroundColor Red
					$AGroupUnlinkHasFailed = $true
				} else {
					Write-Host "$bool"
				}
			}
			foreach ($Unit in $AllFromUnits) {
				Write-Host "Unlinking unit $($Group.Name)"
				
				if ($Unit.TypeName -eq 'Computers') {
					$Unit.TypeName = 'Computer'
				}
				
				$bool = Remove-CapaUnitFromPackage -CapaSDK $CapaSDK -PackageName $FromPackageName -PackageVersion $FromPackageVersion -PackageType $FromPackageType -UnitName $Unit.Name -UnitType $Unit.TypeName
				if ($bool -eq $false) {
					Write-Host "$bool" -ForegroundColor Red
					$AUnitUnlinkHasFailed = $true
				} else {
					Write-Host "$bool"
				}
			}
		}
		
		# Disable Schedule On Existing Package
		if ($DisableScheduleOnExistingPackage -eq $true) {
			Disable-CapaPackageSchedule -CapaSDK $CapaSDK -PackageName $FromPackageName -PackageVersion $FromPackageVersion -PackageType $FromPackageType
		}
		
		#TODOLATER: #2 CopyPackageSchedule der findes ikke en funktion i SDK'en
		<#
            Currently not avalible in the SDK, there is set fuction but not get
            https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247048/Set+Package+Schedule
        #>
	}
	
	if ($AGroupUnlinkHasFailed -eq $true -or $AUnitUnlinkHasFailed -eq $true) {
		$FuctionSuccessful = $false
	}
	
	Return $FuctionSuccessful
}

<#
	.SYNOPSIS
		Create a package in the CapaInstaller.
	
	.DESCRIPTION
		Create a new package in the CapaInstaller.

	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER PackageName
		The name of the package.
	
	.PARAMETER PackageVersion
		The version of the package.
	
	.PARAMETER UnitType
		The type of unit.
	
	.PARAMETER DisplayName
		The display name of the package.
	
	.EXAMPLE
				PS C:\> Create-CapaPackage -CapaSDK $CapaSDK -PackageName 'TestPackage' -PackageVersion 'v1.0.0' -UnitType 'Computer' -DisplayName 'Test Package'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246850/Create+package
#>
function Create-CapaPackage {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType,
		[Parameter(Mandatory = $true)]
		[string]$DisplayName
	)
	
	$value = $CapaSDK.CreatePackage($PackageName, $PackageVersion, $UnitType, $DisplayName)
	return $value
}

<#
	.SYNOPSIS
		Disable a packages schedule. 
	
	.DESCRIPTION
		Diable a packages schedule if a schedule is set.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER PackageName
		The name of the package.
	
	.PARAMETER PackageVersion
		The version of the package.
	
	.PARAMETER PackageType
		The type of package, can be Computer or User.
	
	.EXAMPLE
				PS C:\> Disable-CapaPackageSchedule -CapaSDK $CapaSDK -PackageName 'TestPackage' -PackageVersion 'v1.0.0' -PackageType 'Computer'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246858/Disable+Package+Schedule
#>
function Disable-CapaPackageSchedule {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$PackageType
	)
	
	$bool = $CapaSDK.DisablePackageSchedule($PackageName, $PackageVersion, $PackageType)
	Return $bool
}

<#
	.SYNOPSIS
		Enable a packages schedule.
	
	.DESCRIPTION
		Eanble a packages schedule if a schedule is set.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER PackageName
		The name of the package.
	
	.PARAMETER PackageVersion
		The version of the package.
	
	.PARAMETER PackageType
		The type of package, can be either Computer or User.
	
	.EXAMPLE
				For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246866/Enable+Package+Schedule
	
	.NOTES
		Additional information about the function.
#>
function Enable-CapaPackageSchedule {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[string]$PackageType
	)
	
	if ($PackageType -eq 'Computer') {
		$PackageType = '1'
	}
	if ($PackageType -eq 'User') {
		$PackageType = '2'
	}
	
	$value = $CapaSDK.EnablePackageSchedule($PackageName, $PackageVersion, $PackageType)
	return $value
}

<#
	.SYNOPSIS
		Verifies if a package exists.
	
	.DESCRIPTION
		Veirfies if a package exists.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER Name
		The name of the package.

	.PARAMETER Type
		The type of package, can be either Computer or User.
	
	.PARAMETER Version
		The version of the package.
	
	.EXAMPLE
				PS C:\> Exist-CapaPackage -CapaSDK $CapaSDK -Name 'TestPackage' -Version 'v1.0.0' -Type 'Computer'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246874/Exist+package
#>
function Exist-CapaPackage {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$Name,
		[Parameter(Mandatory = $true)]
		[string]$Version,
		[Parameter(Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[string]$Type
	)
	
	if ($PackageType -eq 'Computer') {
		$PackageType = '1'
	}
	if ($PackageType -eq 'User') {
		$PackageType = '2'
	}
	
	$value = $CapaSDK.ExistPackage($Name, $Version, $Type)
	return $value
}

<#
	.SYNOPSIS
		Export a package.
	
	.DESCRIPTION
		Eports a package to a folder.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER PackageType
		The type of package, can be either Computer or User.
	
	.PARAMETER PackageName
		The name of the package.
	
	.PARAMETER PackageVersion
		The version of the package.
	
	.PARAMETER ToFolder
		Path to the folder where the package should be exported to.
	
	.EXAMPLE
				PS C:\> Export-CapaPackage -CapaSDK $CapaSDK -PackageType 'Computer' -PackageName 'TestPackage' -PackageVersion 'v1.0.0' -ToFolder 'C:\Temp'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246882/Export+package
#>
function Export-CapaPackage {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[string]$ToFolder
	)
	
	$bool = $CapaSDK.ExportPackage($PackageName, $PackageVersion, $PackageType, $ToFolder)
	Return $bool
}

<#
	.SYNOPSIS
		Get a description of a package.
	
	.DESCRIPTION
		Get a description of a package.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER PackageName
		The name of the package.
	
	.PARAMETER PackageVersion
		The version of the package.
	
	.PARAMETER PackageType
		The type of package, can be either Computer or User.
	
	.EXAMPLE
				PS C:\> Get-CapaPackageDescription -CapaSDK $CapaSDK -PackageName 'TestPackage' -PackageVersion 'v1.0.0' -PackageType 'Computer'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246928/Get+Package+Description
#>
function Get-CapaPackageDescription {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[String]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[String]$PackageType
	)
	
	if ($PackageType -eq 'Computer') {
		$PackageType = '1'
	}
	if ($PackageType -eq 'User') {
		$PackageType = '2'
	}
	
	$value = $CapaSDK.GetPackageDescription($PackageName, $PackageVersion, $PackageType)
	return $value
}

<#
	.SYNOPSIS
		Get the folder structure of a package.
	
	.DESCRIPTION
		Get the folder structure of a package.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER Type
		The type of package, can be either Computer or User.
	
	.PARAMETER PackageName
		The name of the package.
	
	.PARAMETER PackageVersion
		The version of the package.
	
	.EXAMPLE
				PS C:\> Get-CapaPackageFolder -CapaSDK $CapaSDK -PackageType 'Computer' -PackageName 'TestPackage' -PackageVersion 'v1.0.0'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246936/Get+Package+Folder
#>
function Get-CapaPackageFolder {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion
	)
	
	$aUnits = $CapaSDK.GetPackageFolder($PackageName, $PackageVersion, $PackageType)
	Return $aUnits
}

<#
	.SYNOPSIS
		Get grops linked to a package.
	
	.DESCRIPTION
		Get grops linked to a package.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER PackageType
		The type of package, can be either Computer or User.
	
	.PARAMETER PackageName
		The name of the package.
	
	.PARAMETER PackageVersion
		The version of the package.
	
	.EXAMPLE
				PS C:\> Get-CapaPackageGroups -CapaSDK $CapaSDK -PackageType 'Computer' -PackageName 'TestPackage' -PackageVersion 'v1.0.0'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246300/Get+package+groups
#>
function Get-CapaPackageGroups {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetPackageGroups($PackageName, $PackageVersion, $PackageType)
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name        = $aItem[0];
			Type        = $aItem[1];
			UnitTypeID  = $aItem[2];
			Description = $aItem[3];
			GUID        = $aItem[4];
			ID          = $aItem[5]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		Get a list of packages.
	
	.DESCRIPTION
		Get a list of packages and if a BusinessUnit is specified, get the packages on that BusinessUnit.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER Type
		If specified, only get packages of this type. Can be either Computer or User.

	.PARAMETER BusinessUnit
		If specified, only get packages on this BusinessUnit.
	
	.EXAMPLE
				PS C:\> Get-CapaPackages -CapaSDK $CapaSDK -Type 'Computer'

	.EXAMPLE
				PS C:\> Get-CapaPackages -CapaSDK $CapaSDK -Type 'Computer' -BusinessUnit 'TestBusinessUnit'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246954/Get+packages
		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246964/Get+packages+on+Business+Unit
#>
function Get-CapaPackages {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $false)]
		[ValidateSet('Computer', 'User')]
		[string]$Type = '',
		[String]$BusinessUnit = ''
	)
	
	$oaUnits = @()
	
	if ($BusinessUnit -eq '') {
		$aUnits = $CapaSDK.GetPackages($Type)
	} else {
		$aUnits = $CapaSDK.GetPackagesOnBusinessUnit($BusinessUnit)
	}
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name               = $aItem[0];
			Version            = $aItem[1];
			Type               = $aItem[2];
			DisplayName        = $aItem[3];
			IsMandatory        = $aItem[4];
			ScheduleId         = $aItem[5];
			Description        = $aItem[6];
			GUID               = $aItem[7];
			ID                 = $aItem[8];
			IsInteractive      = $aItem[9];
			DependendPackageID = $aItem[10];
			IsInventoryPackage = $aItem[11];
			CollectMode        = $aItem[12];
			Priority           = $aItem[13];
			ServerDeploy       = $aItem[14]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		Get a list of packages on a management server.
	
	.DESCRIPTION
		Get a list of packages on a management server.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER ServerName
		The name of the management server.
	
	.PARAMETER PackageType
		The type of package, can be either Computer or User.
	
	.EXAMPLE
				PS C:\> Get-CapaPackagesOnManagementServer -CapaSDK $CapaSDK -ServerName 'TestServer' -PackageType 'Computer'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246974/Get+packages+on+management+server
#>
function Get-CapaPackagesOnManagementServer {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$ServerName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$PackageType
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetOSDiskConfiguration($ServerName, $PackageType)
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name               = $aItem[0];
			Version            = $aItem[1];
			Type               = $aItem[2];
			DisplayName        = $aItem[3];
			IsMandatory        = $aItem[4];
			ScheduleId         = $aItem[5];
			Description        = $aItem[7];
			GUID               = $aItem[8];
			ID                 = $aItem[9];
			IsInteractive      = $aItem[10];
			DependendPackageID = $aItem[11];
			IsInventoryPackage = $aItem[12];
			CollectMode        = $aItem[13];
			Priority           = $aItem[14];
			ServerDeploy       = $aItem[15]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		Gets a list of packages and their status on a unit.
	
	.DESCRIPTION
		Gets a list of packages and their status on a unit.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER UnitName
		The name of the unit, can also be the UUID.
	
	.PARAMETER UnitType
		The type of unit, can be either Computer or User.
	
	.EXAMPLE
				PS C:\> Get-CapaPackageStatus -CapaSDK $value1 -UnitName  'Value2' -UnitType Computer
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246944/Get+package+status
#>
function Get-CapaPackageStatus {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetPackageStatus($UnitName, $UnitType)
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			UnitName       = $aItem[0];
			PackageName    = $aItem[1];
			PackageVersion = $aItem[2];
			Status         = $aItem[3];
			DisplayStatus  = $aItem[4]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		Gets a list of units linked to a package.
	
	.DESCRIPTION
		Gets a list of units linked to a package.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The version of the package.

	.PARAMETER PackageType
		The type of package, can be either Computer or User.
	
	.EXAMPLE
				PS C:\> Get-CapaPackageUnits -CapaSDK $CapaSDK -PackageName 'Winrar' -PackageVersion '5.50' -PackageType 'Computer'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247456/Get+package+units
#>
function Get-CapaPackageUnits {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$PackageType
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetPackageUnits($PackageName, $PackageVersion, $PackageType)
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name         = $aItem[0];
			Created      = $aItem[1];
			LastExecuted = $aItem[2];
			Status       = $aItem[3];
			Description  = $aItem[4];
			GUID         = $aItem[5];
			ID           = $aItem[6];
			TypeName     = $aItem[7]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		Imports a package into CapaInstaller.
	
	.DESCRIPTION
		Imports a package into CapaInstaller.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER FilePath
		Specifies the path to the zip file containing the package.
	
	.PARAMETER OverrideCIPCdata
		If the zip file contains metadata used by the Package Creator, setting this to true will override these metadata if any already exists in the CMS database.
	
	.PARAMETER ImportFolderStructure
		Determines wether or not the folder structure will be imported from the exported package.
		If this is true, the package will be placed in the folder it was located in, when it was exported. Any folders in that structure that doesn't already exist, will be created in CMS.
	
	.PARAMETER ImportSchedule
		Determines wether or not the schedule will be imported from the package.
	
	.PARAMETER ChangelogComment
		An optional comment to add to the changelog.
	
	.EXAMPLE
				PS C:\> Import-CapaPackage -CapaSDK $value1 -FilePath 'C:\Temp\Package.zip' -OverrideCIPCdata $true -ImportFolderStructure $true -ImportSchedule $true
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246984/Import+package
#>
function Import-CapaPackage {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$FilePath,
		[Parameter(Mandatory = $true)]
		[bool]$OverrideCIPCdata,
		[Parameter(Mandatory = $true)]
		[bool]$ImportFolderStructure,
		[Parameter(Mandatory = $true)]
		[bool]$ImportSchedule,
		[String]$ChangelogComment = ''
	)
	
	$value = $CapaSDK.ImportPackage($FilePath, $OverrideCIPCdata, $ImportFolderStructure, $ImportSchedule, $ChangelogComment)
	return $value
}

<#
	.SYNOPSIS
		Initializes a package promotion.
	
	.DESCRIPTION
		Initialize a package promotion.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER PackageType
		The type of package, can be either Computer or User.
	
	.PARAMETER PackageName
		The name of the package.
	
	.PARAMETER PackageVersion
		The version of the package.
	
	.EXAMPLE
				PS C:\> Initialize-CapaPackagePromote -CapaSDK $CapaSDK -PackageType 'Computer' -PackageName 'Winrar' -PackageVersion '5.50'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246992/Promote+Package
#>
function Initialize-CapaPackagePromote {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion
	)
	
	$bool = $CapaSDK.PackagePromote($PackageName, $PackageVersion, $PackageType)
	Return $bool
}

<#
	.SYNOPSIS
		Removes a package.
	
	.DESCRIPTION
		Delete a package, if business units are specified, the package will only be removed from that business unit.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER PackageType
		The type of package, can be either Computer or User.
	
	.PARAMETER PackageName
		The name of the package.
	
	.PARAMETER PackageVersion
		The version of the package.
	
	.PARAMETER Force
		Force deletion of the package regardless of any linked units, groups, or business units.
	
	.EXAMPLE
				PS C:\> Remove-CapaPackage -CapaSDK $CapaSDK -PackageType 'Computer' -PackageName 'Winrar' -PackageVersion '5.50' -Force $true

	.EXAMPLE
				PS C:\> Remove-CapaPackage -CapaSDK $CapaSDK -PackageType 'Computer' -PackageName 'Winrar' -PackageVersion '5.50' -Force $true -BusinessUnitName 'MyBusinessUnit'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246831/Delete+Package
		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247000/Remove+Package+From+BusinessUnit
#>
function Remove-CapaPackage {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[String]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$PackageType,
		[String]$BusinessUnitName = '',
		[ValidateSet('True', 'False')]
		[string]$Force = 'True'
		
	)
	if ($BusinessUnitName -eq '') {
		$value = $CapaSDK.DeletePackage($PackageName, $PackageVersion, $PackageType, $Force)
	} else {
		$value = $CapaSDK.RemovePackageFromBusinessUnit($PackageName, $PackageVersion, $PackageType, $BusinessUnitName)
	}
	
	Return $value
}

<#
	.SYNOPSIS
		Removes a package from a group.
	
	.DESCRIPTION
		Removes a package from a group.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER PackageName
		The name of the package to remove from the group.
	
	.PARAMETER PackageVersion
		The version of the package to remove from the group.
	
	.PARAMETER PackageType
		The type of package to remove from the group.
	
	.PARAMETER GroupName
		The name of the group to remove the package from.
	
	.PARAMETER GroupType
		The type of group to remove the package from.
	
	.EXAMPLE
				PS C:\> Remove-CapaPackageFromGroup -CapaSDK $CapaSDK -PackageName 'Winrar' -PackageVersion '5.50' -PackageType 'Computer' -GroupName 'MyGroup' -GroupType 'Static'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247008/Remove+package+from+group
#>
function Remove-CapaPackageFromGroup {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[string]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Security', 'Static')]
		[string]$GroupType
	)
	
	$bool = $CapaSDK.RemovePackageFromGroup($PackageName, $PackageVersion, $PackageType, $GroupName, $GroupType)
	Return $bool
}

<#
	.SYNOPSIS
		Removes a package from a management server.
	
	.DESCRIPTION
		Removes a package from a management server.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER PackageName
		The name of the package to remove from the management server.
	
	.PARAMETER PackageVersion
		The version of the package to remove from the management server.
	
	.PARAMETER PackageType
		The type of package to remove from the management server.
	
	.PARAMETER ServerName
		The name of the management server to remove the package from.
	
	.EXAMPLE
				PS C:\> Remove-CapaPackageFromManagementServer -CapaSDK $CapaSDK -PackageName 'Winrar' -PackageVersion '5.50' -PackageType 'Computer' -ServerName 'MyServer'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247016/Remove+package+from+management+server
#>
function Remove-CapaPackageFromManagementServer {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[String]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[String]$PackageType,
		[Parameter(Mandatory = $true)]
		[String]$ServerName
	)
	
	if ($PackageType -eq 'Computer') {
		$PackageType = '1'
	}
	if ($PackageType -eq 'User') {
		$PackageType = '2'
	}
	
	$value = $CapaSDK.RemovePackageFromManagementServer($PackageName, $PackageVersion, $PackageType, $ServerName)
	return $value
}

<#
	.SYNOPSIS
		Set the description of a package.
	
	.DESCRIPTION
		Set the description of a package.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER PackageName
		The name of the package to set the description of.
	
	.PARAMETER PackageVersion
		The version of the package to set the description of.
	
	.PARAMETER PackageType
		The type of package to set the description of.
	
	.PARAMETER Description
		The description to set.
	
	.EXAMPLE
				PS C:\> Set-CapaPackageDescription -CapaSDK $CapaSDK -PackageName 'Winrar' -PackageVersion '5.50' -PackageType 'Computer' -Description 'This is a description'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247024/Set+Package+Description
#>
function Set-CapaPackageDescription {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[String]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[String]$PackageType,
		[Parameter(Mandatory = $true)]
		[String]$Description = ''
	)
	
	if ($PackageType -eq 'Computer') {
		$PackageType = '1'
	}
	if ($PackageType -eq 'User') {
		$PackageType = '2'
	}
	
	$value = $CapaSDK.SetPackageDescription($PackageName, $PackageVersion, $PackageType, $Description)
	return $value
}

<#
	.SYNOPSIS
		Set the folder structure of a package.
	
	.DESCRIPTION
		Set the folder structure of a package.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER PackageType
		The type of package to set the folder structure of, either Computer or User.
	
	.PARAMETER PackageName
		The name of the package to set the folder structure of.
	
	.PARAMETER PackageVersion
		The version of the package to set the folder structure of.
	
	.PARAMETER FolderStructure
		The folder structure to set, for example 'Folder1\Folder2'.
	
	.PARAMETER ChangelogText
		An optional changelog text to set.
	
	.EXAMPLE
				PS C:\> Set-CapaPackageFolder -CapaSDK $CapaSDK -PackageType 'Computer' -PackageName 'Winrar' -PackageVersion '5.50' -FolderStructure 'Folder1\Folder2' -ChangelogText 'This is a changelog'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247032/Set+Package+Folder
#>
function Set-CapaPackageFolder {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[string]$FolderStructure,
		[string]$ChangelogText
	)
	
	$bool = $CapaSDK.SetPackageFolder($PackageName, $PackageVersion, $PackageType, $FolderStructure, $ChangelogText)
	
	Return $bool
}

<#
	.SYNOPSIS
		Sets an package property.
	
	.DESCRIPTION
		Sets an package property.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER PackageName
		The name of the package.
	
	.PARAMETER PackageVersion
		The version of the package.
	
	.PARAMETER PackageType
		The type of the package.
	
	.PARAMETER Priority
		The priority of the package, default is 500.
	
	.EXAMPLE
				PS C:\> Set-CapaPackagePriority -CapaSDK $CapaSDK -PackageName 'Winrar' -PackageVersion '5.50' -PackageType 'Computer' -Priority 500

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247040/Set+Package+Property
#>
function Set-CapaPackagePriority {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[String]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[String]$PackageType,
		[Integer]$Priority = 500
	)
	
	if ($PackageType -eq 'Computer') {
		$PackageType = '1'
	}
	if ($PackageType -eq 'User') {
		$PackageType = '2'
	}
	
	$value = $CapaSDK.SetPackagePriority($PackageName, $PackageVersion, $PackageType, $Priority)
	return $value
}

<#
	.SYNOPSIS
		Sets the schedule of a package.
	
	.DESCRIPTION
		Sets the schedule of a package.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER PackageName
		The name of the package.
	
	.PARAMETER PackageVersion
		The version of the package.
	
	.PARAMETER PackageType
		The type of the package, either Computer or User.
	
	.PARAMETER ScheduleStart
		The start date of the schedule, for example '2015-05-15 12:00'.
	
	.PARAMETER ScheduleEnd
		The Schedule start date in the format  "yyyy-MM-dd HH:mm" eg. "2015-04-15 12:05". If no end date is wanted, leave empty.
	
	.PARAMETER ScheduleIntervalBegin
		The Schedule Interval begins time in the format  HH:mm" eg. "06:00". If left empty it is set to 00:00.
	
	.PARAMETER ScheduleIntervalEnd
		The Schedule Interval end time in the format  HH:mm" eg. "12:00". If left empty it is set to 00:00.
	
	.PARAMETER ScheduleRecurrence
		The Schedule Recurrence for the schedule, either Once, PeriodicalDaily, PeriodicalWeekly or Always.
	
	.PARAMETER ScheduleRecurrencePattern
		Is used to further detail the Schedule Recurrence when set to PeriodicalDaily or PeriodicalWeekly
			Possible values:
			ScheduleRecurrence = "PeriodicalDaily"
				ScheduleRecurrencePattern  = "RecurEveryWeekDay" sets the recurrence pattern to run every weekday
				ScheduleRecurrencePattern  = "" Sets the recurrence pattern to recur every day including weekend days.
			
			ScheduleRecurrence = "PeriodicalWeekly"
				ScheduleRecurrencePattern   = "1,3,5" Will set the schedule pattern to run Monday, Wednesday and Friday. All weekdays can be combined with a comma (,) (1,2,3,4,5,6,7)
					Monday = 1
					Tuesday = 2
					Wednesday = 3
					Thursday = 4
					Friday = 5
					Saturday = 6
					Sunday = 7
				ScheduleRecurrencePattern   = "" Will set the schedule recurrence pattern to run every weekday 
	
	.EXAMPLE
				PS C:\> Set-CapaPackageSchedule @(
					CapaSDK = $CapaSDK
					PackageName = 'Winrar'
					PackageVersion = '5.50'
					PackageType = 'Computer'
					ScheduleStart = '2015-05-15 12:00'
					ScheduleEnd = '2015-05-15 12:00'
					ScheduleIntervalBegin = '06:00'
					ScheduleIntervalEnd = '12:00'
					ScheduleRecurrence = 'PeriodicalDaily'
					ScheduleRecurrencePattern = 'RecurEveryWeekDay'
				)
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247048/Set+Package+Schedule
#>
function Set-CapaPackageSchedule {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[String]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$PackageType,
		[Parameter(Mandatory = $true)]
		[String]$ScheduleStart,
		[Parameter(Mandatory = $true)]
		[String]$ScheduleEnd,
		[Parameter(Mandatory = $true)]
		[String]$ScheduleIntervalBegin,
		[Parameter(Mandatory = $true)]
		[String]$ScheduleIntervalEnd,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Once', 'PeriodicalDaily', 'PeriodicalWeekly', 'Always')]
		[String]$ScheduleRecurrence,
		[String]$ScheduleRecurrencePattern = ''
	)
	
	$value = $CapaSDK.SetPackageSchedule($PackageName, $PackageVersion, $PackageType, $ScheduleStart, $ScheduleEnd, $ScheduleIntervalBegin, $ScheduleIntervalEnd, $ScheduleRecurrence, $ScheduleRecurrencePattern)
	return $value
}

<#
	.SYNOPSIS
		Performs a update now on a package.
	
	.DESCRIPTION
		Performs the Update now procedure on a package. This will create a SyncJob to the CiSync service residing on the Point-server with the 'AutoJob' bit set which 
		will (after completion) in turn create 'auto-syncjobs' to child servers as well as BaseAgent-DistributionServers when/if the package is assigned or the child 
		servers are 'replica' servers.

		This function is equivalent to the CM-plugin right-click action on a package.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER PackageName
		The name of the package.
	
	.PARAMETER PackageVersion
		The version of the package.
	
	.PARAMETER PackageType
		The type of the package, either Computer or User.
	
	.EXAMPLE
				PS C:\> Update-CapaPackageNow -CapaSDK $CapaSDK -PackageName 'Winrar' -PackageVersion '5.50' -PackageType 'Computer'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247056/Update+Now+on+Package
#>
function Update-CapaPackageNow {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[String]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$PackageType
	)
	
	$value = $CapaSDK.PackageUpdateNow($PackageName, $PackageVersion, $PackageType)
	return $value
}

<#
	.SYNOPSIS
		Gets all inventory packages.
	
	.DESCRIPTION
		Gets all inventory packages.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER PackageType
		The type of the package, either Computer or User.
	
	.EXAMPLE
				PS C:\> Get-CapaAllInventoryPackages -CapaSDK $CapaSDK -PackageType 'Computer'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246890/Get+all+inventory+packages
#>
function Get-CapaAllInventoryPackages {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[string]$PackageType = ''
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetAllInventoryPackages($PackageType)
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name               = $aItem[0];
			Version            = $aItem[1];
			Type               = $aItem[2];
			DisplayName        = $aItem[3];
			IsMandatory        = $aItem[4];
			ScheduleId         = $aItem[5];
			Description        = $aItem[6];
			GUID               = $aItem[7];
			ID                 = $aItem[8];
			IsInteractive      = $aItem[9];
			DependendPackageID = $aItem[10];
			IsInventoryPackage = $aItem[11];
			CollectMode        = $aItem[12];
			Priority           = $aItem[13];
			ServerDeploy       = $aItem[14]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		Returns all none inventory packages.
	
	.DESCRIPTION
		Returns all none inventory packages.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER PackageType
		The type of the package, either Computer or User.
	
	.EXAMPLE
				PS C:\> Get-CapatAllNoneInventoryPackages -CapaSDK $CapaSDK -PackageType 'Computer'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246900/Get+all+none+inventory+packages
#>
function Get-CapatAllNoneInventoryPackages {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[string]$PackageType = ''
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetAllNoneInventoryPackages($PackageType)
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name               = $aItem[0];
			Version            = $aItem[1];
			Type               = $aItem[2];
			DisplayName        = $aItem[3];
			IsMandatory        = $aItem[4];
			ScheduleId         = $aItem[5];
			Description        = $aItem[6];
			GUID               = $aItem[7];
			ID                 = $aItem[8];
			IsInteractive      = $aItem[9];
			DependendPackageID = $aItem[10];
			IsInventoryPackage = $aItem[11];
			CollectMode        = $aItem[12];
			Priority           = $aItem[13];
			ServerDeploy       = $aItem[14]
		}
	}
	
	Return $oaUnits
}