
# TODO: #155 Update and add tests

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


# TODO: #156 Update and add tests

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


# TODO: #157 Update and add tests

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


# TODO: #158 Update and add tests

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



# TODO: #159 Update and add tests

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


# TODO: #160 Update and add tests

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


# TODO: #162 Update and add tests

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


# TODO: #163 Update and add tests

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


# TODO: #164 Update and add tests

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


# TODO: #165 Update and add tests

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


# TODO: #166 Update and add tests

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


# TODO: #167 Update and add tests

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


# TODO: #169 Update and add tests

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


# TODO: #170 Update and add tests

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


# TODO: #173 Update and add tests

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


# TODO: #174 Update and add tests

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


# TODO: #171 Update and add tests

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


# TODO: #172 Update and add tests

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


# TODO: #175 Update and add tests

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


# TODO: #177 Update and add tests

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
				PS C:\> New-CapaPackage -CapaSDK $CapaSDK -PackageName 'TestPackage' -PackageVersion 'v1.0.0' -UnitType 'Computer' -DisplayName 'Test Package'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19306246850/Create+package
#>
function New-CapaPackage {
	[CmdletBinding()]
	[Alias('Create-CapaPackage')]
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
		Creates a new capa package with Git support

	.DESCRIPTION
		Creates a local folder structure you can use with Git to manage your deployment of Capa packages.
		There is both a simple and advanced mode.

		It is recommended to read the documentation before using this function. https://github.com/Mark5900/Capa.PowerShell.Module/tree/main/Documentation

		.PARAMETER PackageName
			The name of the package

		.PARAMETER PackageVersion
			The version of the package

		.PARAMETER SoftwareName
			The name of the software

		.PARAMETER SoftwareVersion
			The version of the software

		.PARAMETER PackageType
			The type of the package, either VBScript or PowerPack

		.PARAMETER BasePath
			The base path where the package folder will be created

		.PARAMETER CapaServer
			The Capa server name

		.PARAMETER SQLServer
			The SQL server name

		.PARAMETER Database
			The Capa database name

		.PARAMETER DefaultManagementPoint
			The default management point

		.PARAMETER PackageBasePath
			The path of where CapaInstaller is saving the packages, example E:\CapaInstaller\CMPProduction\ComputerJobs

		.PARAMETER Advanced
			When specified the advanced setup will be used

	.EXAMPLE
		New-CapaPackageWithGit -PackageName 'Test1' -PackageVersion 'v1.0' -PackageType 'VBScript' -BasePath 'C:\Temp' -CapaServer 'CISERVER' -SQLServer 'CISERVER' -Database 'CapaInstaller' -DefaultManagementPoint '1' -PackageBasePath 'E:\CapaInstaller\CMPProduction\ComputerJobs'

	.EXAMPLE
		New-CapaPackageWithGit -SoftwareName 'Test1' -SoftwareVersion 'v1.0' -PackageType 'PowerPack' -BasePath 'C:\Temp' -CapaServer 'CISERVER' -SQLServer 'CISERVER' -Database 'CapaInstaller' -DefaultManagementPoint '1' -PackageBasePath 'E:\CapaInstaller\CMPProduction\ComputerJobs' -Advanced

	.NOTES
		This is a custom function that is not part of the CapaSDK
#>
function New-CapaPackageWithGit {
	param (
		[Parameter(ParameterSetName = 'NotAdvanced', Mandatory = $true)]
		[string]$PackageName,
		[Parameter(ParameterSetName = 'NotAdvanced', Mandatory = $true)]
		[string]$PackageVersion,
		[Parameter(ParameterSetName = 'Advanced', Mandatory = $true)]
		[string]$SoftwareName,
		[Parameter(ParameterSetName = 'Advanced', Mandatory = $true)]
		[string]$SoftwareVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('VBScript', 'PowerPack')]
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[string]$BasePath,
		[Parameter(Mandatory = $false)]
		[string]$CapaServer,
		[Parameter(Mandatory = $false)]
		[string]$SQLServer,
		[Parameter(Mandatory = $false)]
		[string]$Database,
		[Parameter(Mandatory = $false)]
		[string]$DefaultManagementPoint,
		[Parameter(Mandatory = $false)]
		[string]$PackageBasePath,
		[Parameter(ParameterSetName = 'Advanced', Mandatory = $true)]
		[switch]$Advanced
	)

	Try {
		#region Parameters
		$GitIgnoreFile = Join-Path $PSScriptRoot 'Dependencies\.gitignore'
		$UpdatePackageScript = Join-Path $PSScriptRoot 'Dependencies\UpdatePackage.ps1'

		if ($Advanced) {
			$PackagePath = Join-Path $BasePath "Capa_$($SoftwareName -replace ' ', '_')"
			$ScriptPath = Join-Path $PackagePath 'Scripts'
			$KitPath = Join-Path $PackagePath 'Kit'
			$GitHubActionsPath = Join-Path $PackagePath '.github\workflows'
			$GitHubActionsFile1 = Join-Path $PSScriptRoot 'Dependencies\main.yml'
			$GitHubActionsFile2 = Join-Path $PSScriptRoot 'Dependencies\versioning.yml'
			$SettingsPath = Join-Path $PackagePath 'Settings.json'
			$SettingsFile = Join-Path $PSScriptRoot 'Dependencies\Settings.json'
			$SetStatusScript = Join-Path $PSScriptRoot 'Dependencies\MinorVersionSetSameStatus.ps1'
		} Else {
			$PackagePath = Join-Path $BasePath "Capa_$($PackageName -replace ' ', '_')"
			$VersionPath = Join-Path $PackagePath $PackageVersion
			$ScriptPath = Join-Path $VersionPath 'Scripts'
			$KitPath = Join-Path $VersionPath 'Kit'
		}

		if ($PackageType -eq 'VBScript') {
			$InstallScript = Join-Path $PSScriptRoot 'Dependencies\Install.cis'
			$UninstallScript = Join-Path $PSScriptRoot 'Dependencies\Uninstall.cis'

			$InstallScriptDestination = Join-Path $ScriptPath "$PackageName$SoftwareName.cis"
			$UninstallScriptDestination = Join-Path $ScriptPath "$($PackageName)$($SoftwareName)_Uninstall.cis"
		} ElseIf ($PackageType -eq 'PowerPack') {
			$InstallScript = Join-Path $PSScriptRoot 'Dependencies\Install.ps1'
			$UninstallScript = Join-Path $PSScriptRoot 'Dependencies\Uninstall.ps1'
		}
		#endregion

		#region Create folder
		New-Item -Path $ScriptPath -ItemType Directory -Force | Out-Null
		New-Item -Path $KitPath -ItemType Directory -Force | Out-Null

		if ($Advanced) {
			New-Item -Path $GitHubActionsPath -ItemType Directory -Force | Out-Null
		}
		#endregion

		#region Copy files
		Copy-Item -Path $GitIgnoreFile -Destination $PackagePath -Force | Out-Null
		if ($Advanced) {
			Copy-Item -Path $GitHubActionsFile1 -Destination $GitHubActionsPath -Force | Out-Null
			Copy-Item -Path $GitHubActionsFile2 -Destination $GitHubActionsPath -Force | Out-Null
			Copy-Item -Path $SetStatusScript -Destination $PackagePath -Force | Out-Null
		}

		#region Copy Settings.json
		if ($Advanced) {
			Copy-Item -Path $SettingsFile -Destination $PackagePath -Force | Out-Null

			$Setting = Get-Content $SettingsPath | ConvertFrom-Json
			$Setting.SoftwareName = $SoftwareName
			$Setting.SoftwareVersion = $SoftwareVersion
			$Setting.CapaServer = $CapaServer
			$Setting.SQLServer = $SQLServer
			$Setting.Database = $Database
			$Setting.DefaultManagementPoint = $DefaultManagementPoint
			$Setting.PackageBasePath = $PackageBasePath
			$Setting | ConvertTo-Json | Out-File -FilePath $SettingsPath -Force
		}
		#endregion

		#region Copy UpdatePackage.ps1
		if (!(Test-Path "$PackagePath\UpdatePackage.ps1") ) {
			$UpdatePackageScriptPath = Join-Path $PackagePath 'UpdatePackage.ps1'

			Copy-Item -Path $UpdatePackageScript -Destination $PackagePath -Force | Out-Null

			# Replace in UpdatePackage.ps1
			if ($Advanced -eq $false) {
				if ($null -ne $CapaServer) {
					$UpdatePackageScriptContent = Get-Content $UpdatePackageScriptPath
					$UpdatePackageScriptContent = $UpdatePackageScriptContent.Replace('$CapaServer = ' + "''", '$CapaServer = ' + "'$CapaServer'")
					$UpdatePackageScriptContent | Out-File -FilePath $UpdatePackageScriptPath -Force
				}
				if ($null -ne $SQLServer) {
					$UpdatePackageScriptContent = Get-Content $UpdatePackageScriptPath
					$UpdatePackageScriptContent = $UpdatePackageScriptContent.Replace('$SQLServer = ' + "''", '$SQLServer = ' + "'$SQLServer'")
					$UpdatePackageScriptContent | Out-File -FilePath $UpdatePackageScriptPath -Force
				}
				if ($null -ne $Database) {
					$UpdatePackageScriptContent = Get-Content $UpdatePackageScriptPath
					$UpdatePackageScriptContent = $UpdatePackageScriptContent.Replace('$Database = ' + "''", '$Database = ' + "'$Database'")
					$UpdatePackageScriptContent | Out-File -FilePath $UpdatePackageScriptPath -Force
				}
				if ($null -ne $DefaultManagementPoint) {
					$UpdatePackageScriptContent = Get-Content $UpdatePackageScriptPath
					$UpdatePackageScriptContent = $UpdatePackageScriptContent.Replace('$DefaultManagementPointDev = ' + "''", '$DefaultManagementPointDev = ' + "'$DefaultManagementPoint'")
					$UpdatePackageScriptContent | Out-File -FilePath $UpdatePackageScriptPath -Force
				}
				if ($null -ne $PackageBasePath) {
					$UpdatePackageScriptContent = Get-Content $UpdatePackageScriptPath
					$UpdatePackageScriptContent = $UpdatePackageScriptContent.Replace('$PackageBasePath = ' + "''", '$PackageBasePath = ' + "'$PackageBasePath'")
					$UpdatePackageScriptContent | Out-File -FilePath $UpdatePackageScriptPath -Force
				}
			}
		}
		#endregion

		#region Copy Install/Uninstall script
		If ($PackageType -eq 'VBScript') {
			$InstallContent = Get-Content $InstallScript
			$InstallContent = $InstallContent.Replace('PACKAGENAME', "$PackageName$SoftwareName")
			$InstallContent = $InstallContent.Replace('PACKAGEVERSION', "$PackageVersion$SoftwareVersion")
			$InstallContent = $InstallContent.Replace('CREATEDBY', $env:username)
			$InstallContent = $InstallContent.Replace('TIME', (Get-Date -Format 'dd-MM-yyyy HH:mm:ss'))
			New-Item -Path $InstallScriptDestination -ItemType File -Force | Out-Null
			$InstallContent | Out-File -FilePath $InstallScriptDestination -Force

			$UninstallContent = Get-Content $UninstallScript
			$UninstallContent = $UninstallContent.Replace('PACKAGENAME', "$PackageName$SoftwareName")
			$UninstallContent = $UninstallContent.Replace('PACKAGEVERSION', "$PackageVersion$SoftwareVersion")
			$UninstallContent = $UninstallContent.Replace('CREATEDBY', $env:username)
			$UninstallContent = $UninstallContent.Replace('TIME', (Get-Date -Format 'dd-MM-yyyy HH:mm:ss'))
			New-Item -Path $UninstallScriptDestination -ItemType File -Force | Out-Null
			$UninstallContent | Out-File -FilePath $UninstallScriptDestination -Force
		} else {
			Copy-Item -Path $InstallScript -Destination $ScriptPath -Force | Out-Null
			Copy-Item -Path $UninstallScript -Destination $ScriptPath -Force | Out-Null

		}
		#endregion

		#endregion

		return $true
	} Catch {
		$PSCmdlet.ThrowTerminatingError($PSitem)
		return $false
	}
}


<#
    .SYNOPSIS
        Creates a new PowerPack in CapaInstaller

    .DESCRIPTION
        Creates a new PowerPack in CapaInstaller using the CapaSDK and the SqlServer module

    .PARAMETER CapaSDK
        The CapaSDK object

    .PARAMETER PackageName
        The name of the package

    .PARAMETER PackageVersion
        The version of the package

    .PARAMETER DisplayName
        The display name of the package, if not specified then the package name and version will be used

    .PARAMETER InstallScriptContent
        The install script content of the package, if not specified then the default install script will be used

    .PARAMETER UninstallScriptContent
        The uninstall script content of the package, if not specified then the default uninstall script will be used

    .PARAMETER KitFolderPath
        The path to the kit folder, if not specified then a dummy kit folder will be created

    .PARAMETER ChangelogComment
        The changelog comment of the package

    .PARAMETER SqlServerInstance
        The SQL Server instance

    .PARAMETER Database
        The Capa database name

    .PARAMETER Credential
        The SQL Server credential

		.PARAMETER PointID
				The ID of the point to rebuild the kit file on, if not specified then the kit file will not be rebuilt.
				Requires that KitFolderPath is specified.

    .EXAMPLE
        New-CapaPowerPack -CapaSDK $oCMSDev -PackageName 'Test1' -PackageVersion 'v1.0' -DisplayName 'Test1' -SqlServerInstance $CapaServer -Database $Database

    .Example
        New-CapaPowerPack -CapaSDK $oCMSDev -PackageName 'Test1' -PackageVersion 'v1.0' -DisplayName 'Test1' -InstallScriptContent 'Write-Host "Hello World"' -SqlServerInstance $CapaServer -Database $Database

    .Example
        New-CapaPowerPack -CapaSDK $oCMSDev -PackageName 'Test1' -PackageVersion 'v1.0' -DisplayName 'Test1' -KitFolderPath 'C:\Temp\Kit' -SqlServerInstance $CapaServer -Database $Database

		.EXAMPLE
				New-CapaPowerPack -CapaSDK $oCMSDev -PackageName 'Test1' -PackageVersion 'v1.0' -DisplayName 'Test1' -KitFolderPath 'C:\Temp\Kit' -SqlServerInstance $CapaServer -Database $Database -PointID 1

    .Notes
        This is a custom function that is not part of the CapaSDK
#>
function New-CapaPowerPack {
	param (
		[Parameter(Mandatory = $true)]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[String]$PackageVersion,
		[string]$DisplayName = "$PackageName $PackageVersion",
		[String]$InstallScriptContent,
		[String]$UninstallScriptContent,
		[String]$KitFolderPath,
		[string]$ChangelogComment = '',
		[Parameter(Mandatory = $true)]
		[string]$SqlServerInstance,
		[Parameter(Mandatory = $true)]
		[string]$Database,
		[pscredential]$Credential = $null,
		[int]$PointID
	)
	$XMLFile = Join-Path $PSScriptRoot 'Dependencies' 'ciPackage.xml'
	$KitFile = Join-Path $PSScriptRoot 'Dependencies' 'CapaInstaller.kit'
	$TempFolder = "C:\Users\$env:UserName\AppData\Local\CapaInstaller\CMS\TempScripts"
	$TempTempFolder = Join-Path $TempFolder 'Temp'
	$PackageTempFolder = Join-Path $TempTempFolder "$($PackageName)_$($PackageVersion)"
	$PackageZipFile = Join-Path $TempTempFolder "$($PackageName)_$($PackageVersion).zip"


	Try {
		# Create Temp Folder
		If (!(Test-Path $TempFolder)) {
			New-Item -ItemType Directory -Path $TempTempFolder -Force | Out-Null
		}
		New-Item -ItemType Directory -Path "$PackageTempFolder\Zip" -Force | Out-Null
		Copy-Item -Path $KitFile -Destination "$PackageTempFolder\Zip\CapaInstaller.kit" -Force | Out-Null
		New-Item -ItemType Directory -Path "$PackageTempFolder\Scripts" -Force | Out-Null

		# Create XML File
		$XML = [xml](Get-Content $XMLFile)
		$XML.Info.Package.Name = $PackageName
		$XML.Info.Package.Version = $PackageVersion
		$XML.Info.Package.DisplayName = $DisplayName

		If ([string]::IsNullOrEmpty($InstallScriptContent) -eq $false) {
			$InstallScriptContentBytes = [System.Text.Encoding]::UTF8.GetBytes("$InstallScriptContent")
			$XML.Info.Package.InstallScriptContent = [System.Convert]::ToBase64String($InstallScriptContentBytes)
		}

		If ([string]::IsNullOrEmpty($UninstallScriptContent) -eq $false) {
			$UninstallScriptContentBytes = [System.Text.Encoding]::UTF8.GetBytes("$UninstallScriptContent")
			$XML.Info.Package.UnInstallScriptContent = [System.Convert]::ToBase64String($UninstallScriptContentBytes)
		}

		Set-Content -Path "$PackageTempFolder\ciPackage.xml" -Value $XML.OuterXml

		# Create kit folder
		If ([string]::IsNullOrEmpty($KitFolderPath) -eq $false) {
			Copy-Item -Path $KitFolderPath -Destination "$PackageTempFolder\Kit" -Recurse -Force | Out-Null
			if ($null -eq $PointID) {
				Rebuild-CapaKitFileOnPoint -CapaSDK $CapaSDK -PackageName $PackageName -PackageVersion $PackageVersion -PointID $PointID -PackageType Computer
			}
		} else {
			New-Item -ItemType Directory -Path "$PackageTempFolder\Kit" -Force | Out-Null
			New-Item -ItemType File -Path "$PackageTempFolder\Kit\Dummy.txt" -Force | Out-Null
			Add-Content -Value 'Placeholder for the build of CapaInstaller.kit' -Path "$PackageTempFolder\Kit\Dummy.txt"
		}

		# Create zip file
		Add-Type -AssemblyName System.IO.Compression.FileSystem
		[System.IO.Compression.ZipFile]::CreateFromDirectory($PackageTempFolder, $PackageZipFile)

		# Add to CI
		$Status = Import-CapaPackage -CapaSDK $CapaSDK -FilePath $PackageZipFile -OverrideCIPCdata $true -ImportFolderStructure $true -ImportSchedule $true -ChangelogComment $ChangelogComment

		# The SDK is missing support for PowerPack, so we need to use SqlServer module to edit in job table
		$Query = "UPDATE JOB
    Set POWERPACK = 'True', INSTALLSCRIPTCONTENT = '$($XML.Info.Package.InstallScriptContent)', UNINSTALLSCRIPTCONTENT =' $($XML.Info.Package.UnInstallScriptContent)'
    Where NAME = '$PackageName'
    AND VERSION = '$PackageVersion'"

		if ($Null -eq $Credential) {
			Invoke-Sqlcmd -ServerInstance $SqlServerInstance -Database $Database -Query $Query -TrustServerCertificate
		} else {
			Invoke-Sqlcmd -ServerInstance $SqlServerInstance -Database $Database -Query $Query -Credential $Credential
		}

		# Remove Temp Folder
		Remove-Item -Path $TempTempFolder -Recurse -Force | Out-Null

		return $Status
	} Catch {
		$PSCmdlet.ThrowTerminatingError($PSitem)
		return -1
	}
}


# TODO: #180 Update and add tests

<#
	.SYNOPSIS
		Removes a package.

	.DESCRIPTION
		Delete a package, if business units are specified, the package will only be removed from that business unit.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The version of the package.

	.PARAMETER PackageType
		The type of package, can be either Computer or User.

	.PARAMETER BusinessUnitName
		The name of the business unit to remove the package from.

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


# TODO: #181 Update and add tests

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


# TODO: #182 Update and add tests

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


# TODO: #183 Update and add tests

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
		[String]$Description
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


# TODO: #184 Update and add tests

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


# TODO: #185 Update and add tests

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
		[Int]$Priority = 500
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


# TODO: #186 Update and add tests

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


# TODO: #187 Update and add tests

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
        Use this function to update a package script and kit in Capa.

    .DESCRIPTION
        Use this function to update a package script and kit in Capa.
        You will need SqlServer module installed if you want to update a PowerPack script.

    .PARAMETER PackageName
        The name of the package.

    .PARAMETER PackageVersion
        The version of the package.

    .PARAMETER ScriptContent
        The content of the script.

    .PARAMETER ScriptType
        The type of the script. Valid values are: Install, Uninstall, UserConfiguration.

    .PARAMETER PackageType
        The type of the package. Valid values are: PowerPack, VBScript.

    .PARAMETER PackageBasePath
        The path to the package folder. Example: \\CISRVKURSUS.CIKURSUS.local\CMPProduction\ComputerJobs

    .PARAMETER SqlServerInstance
        The name of the SQL Server instance.

    .PARAMETER Database
        The name of the database.

    .PARAMETER Credential
        The credentials to use when connecting to the SQL Server instance.
        Default is to use the current user's credentials.

    .PARAMETER KitFolderPath
        The path to the folder containing files to set as kit.

	.EXAMPLE
		$ScriptContent = Get-Content -Path 'C:\Users\CIKursus\Downloads\InstallScript.ps1' | Out-String
		Update-CapaPackageScriptAndKit -PackageName 'Test1' -PackageVersion 'v1.0' -ScriptContent $ScriptContent -ScriptType 'Install' -PackageType 'PowerPack' -SqlServerInstance $CapaServer -Database $Database

    .EXAMPLE
        Update-CapaPackageScriptAndKit -PackageName 'Test1' -PackageVersion 'v1.0' -ScriptContent "Write-Host 'Hello World'" -ScriptType 'Install' -PackageType 'PowerPack' -SqlServerInstance $CapaServer -Database $Database

    .EXAMPLE
        Update-CapaPackageScriptAndKit -PackageName 'Test1' -PackageVersion 'v1.0' -ScriptContent "Write-Host 'Hello World'" -ScriptType 'Uninstall' -PackageType 'PowerPack' -SqlServerInstance $CapaServer -Database $Database

    .EXAMPLE
        Update-CapaPackageScriptAndKit -PackageName 'Test1' -PackageVersion 'v1.0' -ScriptContent "Write-Host 'Hello World'" -ScriptType 'Install' -PackageType 'PowerPack' -SqlServerInstance $CapaServer -Database $Database -PackageBasePath 'D:\CapaInstaller\CMPProduction\ComputerJobs' -KitFolderPath 'C:\Users\CIKursus\Downloads\Kit'

    .EXAMPLE
        Update-CapaPackageScriptAndKit -PackageName 'Opgave 1' -PackageVersion 'v1.0' -ScriptContent "Write-Host 'Hello World'" -ScriptType 'Install' -PackageType 'VBScript' -PackageBasePath 'D:\CapaInstaller\CMPProduction\ComputerJobs'

    .EXAMPLE
        Update-CapaPackageScriptAndKit -PackageName 'Opgave 1' -PackageVersion 'v1.0' -ScriptContent "Write-Host 'Hello World'" -ScriptType 'Uninstall' -PackageType 'VBScript' -PackageBasePath 'D:\CapaInstaller\CMPProduction\ComputerJobs'

    .EXAMPLE
        Update-CapaPackageScriptAndKit -PackageName 'Opgave 1' -PackageVersion 'v1.0' -PackageBasePath 'D:\CapaInstaller\CMPProduction\ComputerJobs' -KitFolderPath 'C:\Users\CIKursus\Downloads\Kit\'

    .NOTES
        This is a custom function that is not part of the CapaSDK
#>
function Update-CapaPackageScriptAndKit {
	param (
		[Parameter(Mandatory = $true)]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[String]$PackageVersion,
		[Parameter(Mandatory = $true, ParameterSetName = 'PowerPack')]
		[Parameter(Mandatory = $true, ParameterSetName = 'VBScript')]
		[Parameter(Mandatory = $true, ParameterSetName = 'PowerPackWithKit')]
		[Parameter(Mandatory = $true, ParameterSetName = 'VBScriptWithKit')]
		[String]$ScriptContent,
		[Parameter(Mandatory = $true, ParameterSetName = 'PowerPack')]
		[Parameter(Mandatory = $true, ParameterSetName = 'VBScript')]
		[Parameter(Mandatory = $true, ParameterSetName = 'PowerPackWithKit')]
		[Parameter(Mandatory = $true, ParameterSetName = 'VBScriptWithKit')]
		[ValidateSet('Install', 'Uninstall', 'UserConfiguration')]
		[String]$ScriptType,
		[Parameter(Mandatory = $true, ParameterSetName = 'PowerPack')]
		[Parameter(Mandatory = $true, ParameterSetName = 'VBScript')]
		[Parameter(Mandatory = $true, ParameterSetName = 'PowerPackWithKit')]
		[Parameter(Mandatory = $true, ParameterSetName = 'VBScriptWithKit')]
		[ValidateSet('PowerPack', 'VBScript')]
		[String]$PackageType,
		[Parameter(Mandatory = $true, ParameterSetName = 'VBScript')]
		[Parameter(Mandatory = $true, ParameterSetName = 'PowerPackWithKit')]
		[Parameter(Mandatory = $true, ParameterSetName = 'VBScriptWithKit')]
		[Parameter(Mandatory = $true, ParameterSetName = 'Kit')]
		[String]$PackageBasePath,
		[Parameter(Mandatory = $true, ParameterSetName = 'PowerPack')]
		[Parameter(Mandatory = $true, ParameterSetName = 'PowerPackWithKit')]
		[string]$SqlServerInstance,
		[Parameter(Mandatory = $true, ParameterSetName = 'PowerPack')]
		[Parameter(Mandatory = $true, ParameterSetName = 'PowerPackWithKit')]
		[string]$Database,
		[Parameter(Mandatory = $false, ParameterSetName = 'PowerPack')]
		[Parameter(Mandatory = $false, ParameterSetName = 'PowerPackWithKit')]
		[pscredential]$Credential,
		[Parameter(Mandatory = $true, ParameterSetName = 'PowerPackWithKit')]
		[Parameter(Mandatory = $true, ParameterSetName = 'VBScriptWithKit')]
		[Parameter(Mandatory = $true, ParameterSetName = 'Kit')]
		[String]$KitFolderPath
	)
	# Parameters
	if ([string]::IsNullOrEmpty($PackageBasePath) -eq $false) {
		if ($PackageBasePath -like "*\$PackageVersion" -or $PackageBasePath -like "*\$PackageVersion\") {
			$PackagePath = $PackageBasePath
		} elseif ($PackageBasePath -like "*\$PackageName" -or $PackageBasePath -like "*\$PackageName\") {
			$PackagePath = Join-Path $PackageBasePath $PackageVersion
		} else {
			$PackagePath = Join-Path $PackageBasePath $PackageName $PackageVersion
		}

		if ((Test-Path $PackagePath) -eq $false) {
			Write-Error "PackagePath: $PackagePath does not exist"
			throw 'Cannot find the package. Check PackageBasePath'
		}

		$ScriptPath = Join-Path $PackagePath 'Scripts' $ScriptName
		$KitPath = Join-Path $PackagePath 'Kit'
	}

	if ($ScriptType -eq 'Install') {
		$ScriptName = "$PackageName.cis"
		$DBColumnName = 'INSTALLSCRIPTCONTENT'
	} elseif ($ScriptType -eq 'Uninstall') {
		$ScriptName = "$($PackageName)_Uninstall.cis"
		$DBColumnName = 'UNINSTALLSCRIPTCONTENT'
	} elseif ($ScriptType -eq 'UserConfiguration') {
		$ScriptName = "$($PackageName)_Us.cis"
		$DBColumnName = 'USERCONFIGSCRIPTCONTENT'
	}

	if ([string]::IsNullOrEmpty($ScriptPath) -eq $false) {
		$ScriptFile = Join-Path $ScriptPath $ScriptName
	}

	# Script
	try {
		# Update script
		if ($PSCmdlet.ParameterSetName -like 'PowerPack*') {
			$ScriptContentBytes = [System.Text.Encoding]::UTF8.GetBytes("$ScriptContent")
			$ScriptContentBase64 = [System.Convert]::ToBase64String($ScriptContentBytes)

			$SqlQuery = "UPDATE JOB
            Set $DBColumnName = '$ScriptContentBase64'
            Where NAME = '$PackageName'
            AND VERSION = '$PackageVersion'"

			If ($Credential) {
				Invoke-Sqlcmd -ServerInstance $SqlServerInstance -Database $Database -Query $SqlQuery -Credential $Credential -TrustServerCertificate
			} else {
				Invoke-Sqlcmd -ServerInstance $SqlServerInstance -Database $Database -Query $SqlQuery -TrustServerCertificate
			}
		}
		If ($PSCmdlet.ParameterSetName -like 'VBScript*') {
			Set-Content -Path $ScriptFile -Value $ScriptContent -Force
		}

		# Update Kit
		If ($PSCmdlet.ParameterSetName -like '*Kit') {
			Get-ChildItem -Path $KitPath -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force | Out-Null
			Copy-Item -Path "$KitFolderPath\*" -Destination $KitPath -Recurse -Force | Out-Null
		}

		return $true
	} catch {
		throw $PSitem
	}

}


