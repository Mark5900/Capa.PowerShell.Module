<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246796/Add+Package+to+BusinessUnit
	
	.DESCRIPTION
		A detailed description of the Add-CapaPackageToBusinessUnit function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER PackageName
		A description of the PackageName parameter.
	
	.PARAMETER PackageVersion
		A description of the PackageVersion parameter.
	
	.PARAMETER PackageType
		A description of the PackageType parameter.
	
	.PARAMETER BusinessUnitName
		A description of the BusinessUnitName parameter.
	
	.EXAMPLE
				PS C:\> Add-CapaPackageToBusinessUnit -CapaSDK $value1 -PackageName $value2 -PackageVersion $value3 -PackageType Computer -BusinessUnitName $value5
	
	.NOTES
		Additional information about the function.
#>
function Add-CapaPackageToBusinessUnit
{
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
	
	if ($PackageType -eq 'Computer')
	{
		$PackageType = '1'
	}
	if ($PackageType -eq 'User')
	{
		$PackageType = '2'
	}
	
	$value = $CapaSDK.AddPackageToBusinessUnit($PackageName, $PackageVersion, $PackageType, $BusinessUnitName)
	
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246807/Add+package+to+group
	
	.DESCRIPTION
		A detailed description of the Add-CapaPackageToGroup function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER PackageName
		A description of the PackageName parameter.
	
	.PARAMETER PackageVersion
		A description of the PackageVersion parameter.
	
	.PARAMETER PackageType
		A description of the PackageType parameter.
	
	.PARAMETER GroupName
		A description of the GroupName parameter.
	
	.PARAMETER GroupType
		A description of the GroupType parameter.
	
	.EXAMPLE
		PS C:\> Add-CapaPackageToGroup -CapaSDK $CapaSDK -PackageName 'value2' -PackageVersion 'value3' -PackageType Computer -GroupName 'value5' -GroupType Dynamic_ADSI
	
	.NOTES
		Additional information about the function.
#>
function Add-CapaPackageToGroup
{
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
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246815/Add+package+to+management+server
	
	.DESCRIPTION
		A detailed description of the Add-CapaPackageToManagementServer function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER PackageName
		A description of the PackageName  parameter.
	
	.PARAMETER PackageVersion
		A description of the PackageVersion  parameter.
	
	.PARAMETER PackageType
		A description of the PackageType parameter.
	
	.PARAMETER ServerName
		A description of the ServerName parameter.
	
	.EXAMPLE
				PS C:\> Add-CapaPackageToManagementServer -CapaSDK $value1 -PackageName  'Value2' -PackageVersion  'Value3' -PackageType 1 -ServerName 'Value5'
	
	.NOTES
		Additional information about the function.
#>
function Add-CapaPackageToManagementServer
{
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
	
	if ($PackageType -eq 'Computer')
	{
		$PackageType = '1'
	}
	if ($PackageType -eq 'User')
	{
		$PackageType = '2'
	}
	
	$value = $CapaSDK.AddPackageToManagementServer($PackageName, $PackageVersion, $PackageType, $ServerName)
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246823/Clone+Package
	
	.DESCRIPTION
		A detailed description of the Clone-CapaPackage function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER PackageName
		A description of the PackageName parameter.
	
	.PARAMETER PackageVersion
		A description of the PackageVersion parameter.
	
	.PARAMETER PackageType
		A description of the PackageType parameter.
	
	.PARAMETER NewVersion
		A description of the NewVersion  parameter.
	
	.EXAMPLE
		PS C:\> Clone-CapaPackage -CapaSDK $value1
	
	.NOTES
		Additional information about the function.
#>
function Clone-CapaPackage
{
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
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246842/Copy+Package
	
	.DESCRIPTION
		A detailed description of the Copy-CapaPackage function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.EXAMPLE
				PS C:\> Copy-CapaPackage -CapaSDK $value1
	
	.NOTES
		Additional information about the function.
#>
function Copy-CapaPackage
{
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
	
	if ($PackageType -eq 'Computer')
	{
		$PackageType = '1'
	}
	if ($PackageType -eq 'User')
	{
		$PackageType = '2'
	}
	
	$value = $CapaSDK.CopyPackage($PackageName, $PackageVersion, $PackageType, $NewName, $NewVersion)
	return $value
}

<#
	.SYNOPSIS
		Custom funktion 
	
	.DESCRIPTION
		A detailed description of the Copy-CapaPackageRelation function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER FromPackageType
		A description of the FromPackageType parameter.
	
	.PARAMETER FromPackageName
		A description of the FromPackageName parameter.
	
	.PARAMETER FromPackageVersion
		A description of the FromPackageVersion parameter.
	
	.PARAMETER ToPackageType
		A description of the ToPackageType parameter.
	
	.PARAMETER ToPackageName
		A description of the ToPackageName parameter.
	
	.PARAMETER ToPackageVersion
		A description of the ToPackageVersion parameter.
	
	.PARAMETER CopyGroups
		A description of the CopyGroups parameter.
	
	.PARAMETER CopyUnits
		A description of the CopyUnits parameter.
	
	.PARAMETER UnlinkGroupsAndUnitsFromExistingPackage
		A description of the UnlinkGroupsAndUnitsFromExistingPackage parameter.
	
	.PARAMETER DisableScheduleOnExistingPackage
		A description of the DisableScheduleOnExistingPackage parameter.
	
	.EXAMPLE
				PS C:\> Copy-CapaPackageRelation -CapaSDK $value1 -FromPackageType Computer -FromPackageName 'Value3' -FromPackageVersion 'Value4' -ToPackageType Computer -ToPackageName 'Value6' -ToPackageVersion 'Value7'
	
	.NOTES
		Additional information about the function.
#>
function Copy-CapaPackageRelation
{
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
	if ($CopyGroups -eq 'All' -or $UnlinkGroupsAndUnitsFromExistingPackage -eq $true)
	{
		$AllFromGroups = Get-CapaPackageGroups -CapaSDK $CapaSDK -PackageName $FromPackageName -PackageType $FromPackageType -PackageVersion $FromPackageVersion
		$AllToGroups = Get-CapaPackageGroups -CapaSDK $CapaSDK -PackageName $ToPackageName -PackageType $ToPackageType -PackageVersion $ToPackageVersion
		Write-Host "$($AllFromGroups.Count) linked groups"
	}
	if ($CopyUnits -eq 'All' -or $UnlinkGroupsAndUnitsFromExistingPackage -eq $true)
	{
		$AllFromUnits = Get-CapaPackageUnits -CapaSDK $CapaSDK -PackageName $FromPackageName -PackageVersion $FromPackageVersion -PackageType $FromPackageType
		$AllToUnits = Get-CapaPackageUnits -CapaSDK $CapaSDK -PackageName $ToPackageName -PackageVersion $ToPackageVersion -PackageType $ToPackageType
		Write-Host "$($AllFromUnits.Count) linked units"
	}
	
	# Copy Groups
	if ($CopyGroups -eq 'All')
	{
		foreach ($Group in $AllFromGroups)
		{
			Write-Host "Adding package to group: $($Group.Name)"
			$bool = Add-CapaPackageToGroup -CapaSDK $CapaSDK -PackageName $ToPackageName -PackageVersion $ToPackageVersion -PackageType $ToPackageType -GroupName $Group.Name -GroupType $Group.Type
			if ($bool -eq $false)
			{
				# Is it already added to the group
				$Check = $AllToGroups | Where-Object { $_.Name -eq $Group.Name -and $_.Type -eq $Group.Type }
				
				if ($Check.Count -eq 1)
				{
					Write-Host 'Group is already linked'
				}
				else
				{
					Write-Host "$bool" -ForegroundColor Red
					$AGroupCopyHasFailed = $true
				}
			}
			else
			{
				Write-Host "$bool"
			}
		}
	}
	
	# Copy Units
	if ($CopyUnits -eq 'All')
	{
		foreach ($Unit in $AllFromUnits)
		{
			
			$bool = Add-CapaUnitToPackage -CapaSDK $CapaSDK -PackageType $ToPackageType -PackageName $ToPackageName -PackageVersion $ToPackageVersion -UnitName $Unit.Name -UnitType $Unit.TypeName
			if ($bool -eq $false)
			{
				# Is it already added to the unit
				$Check = $AllToUnits | Where-Object { $_.Name -eq $Unit.Name -and $_.TypeName -eq $Unit.TypeName }
				
				if ($Check.Count -eq 1)
				{
					Write-Host 'Unit is already linked'
				}
				else
				{
					Write-Host "$bool" -ForegroundColor Red
					$AUnitCopyHasFailed = $true
				}
			}
			else
			{
				Write-Host "$bool"
			}
		}
	}
	
	If ($AGroupCopyHasFailed -eq $true -or $AUnitCopyHasFailed -eq $true)
	{
		Write-Host 'Skipping:' -ForegroundColor Red
		Write-Host '    Unlink Groups And Units From Existing Package' -ForegroundColor Red
		Write-Host '    Disable Schedule On Existing Package' -ForegroundColor Red
		Write-Host ''
		Write-Host 'Because copying a group- or unit link failed' -ForegroundColor Red
		$FuctionSuccessful = $false
	}
	else
	{
		# Unlink Groups And Units From Existing Package
		if ($UnlinkGroupsAndUnitsFromExistingPackage -eq $true)
		{
			foreach ($Group in $AllFromGroups)
			{
				Write-Host "Unlinking group $($Group.Name)"
				$bool = Remove-CapaPackageFromGroup -CapaSDK $CapaSDK -PackageName $FromPackageName -PackageVersion $FromPackageVersion -PackageType $FromPackageType -GroupName $Group.Name -GroupType $Group.Type
				if ($bool -eq $false)
				{
					Write-Host "$bool" -ForegroundColor Red
					$AGroupUnlinkHasFailed = $true
				}
				else
				{
					Write-Host "$bool"
				}
			}
			foreach ($Unit in $AllFromUnits)
			{
				Write-Host "Unlinking unit $($Group.Name)"
				
				if ($Unit.TypeName -eq 'Computers')
				{
					$Unit.TypeName = 'Computer'
				}
				
				$bool = Remove-CapaUnitFromPackage -CapaSDK $CapaSDK -PackageName $FromPackageName -PackageVersion $FromPackageVersion -PackageType $FromPackageType -UnitName $Unit.Name -UnitType $Unit.TypeName
				if ($bool -eq $false)
				{
					Write-Host "$bool" -ForegroundColor Red
					$AUnitUnlinkHasFailed = $true
				}
				else
				{
					Write-Host "$bool"
				}
			}
		}
		
		# Disable Schedule On Existing Package
		if ($DisableScheduleOnExistingPackage -eq $true)
		{
			Disable-CapaPackageSchedule -CapaSDK $CapaSDK -PackageName $FromPackageName -PackageVersion $FromPackageVersion -PackageType $FromPackageType
		}
		
		#TODOLATER: #2 CopyPackageSchedule der findes ikke en funktion i SDK'en
		<#
            Currently not avalible in the SDK, there is set fuction but not get
            https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247048/Set+Package+Schedule
        #>
	}
	
	if ($AGroupUnlinkHasFailed -eq $true -or $AUnitUnlinkHasFailed -eq $true)
	{
		$FuctionSuccessful = $false
	}
	
	Return $FuctionSuccessful
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246850/Create+package
	
	.DESCRIPTION
		A detailed description of the Create-CapaPackage function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER PackageName
		A description of the PackageName  parameter.
	
	.PARAMETER PackageVersion
		A description of the PackageVersion  parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.PARAMETER DisplayName
		A description of the DisplayName  parameter.
	
	.EXAMPLE
				PS C:\> Create-CapaPackage -CapaSDK $value1 -PackageName  'Value2' -PackageVersion  'Value3' -UnitType Computer -DisplayName  'Value5'
	
	.NOTES
		Additional information about the function.
#>
function Create-CapaPackage
{
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
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246858/Disable+Package+Schedule
	
	.DESCRIPTION
		A detailed description of the Disable-CapaPackageSchedule function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER PackageName
		A description of the PackageName parameter.
	
	.PARAMETER PackageVersion
		A description of the PackageVersion parameter.
	
	.PARAMETER PackageType
		A description of the PackageType parameter.
	
	.EXAMPLE
				PS C:\> Disable-CapaPackageSchedule -CapaSDK $value1 -PackageName 'Value2' -PackageVersion 'Value3' -PackageType Computer
	
	.NOTES
		Additional information about the function.
#>
function Disable-CapaPackageSchedule
{
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
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246866/Enable+Package+Schedule
	
	.DESCRIPTION
		A detailed description of the Enable-CapaPackageSchedule function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER PackageName
		A description of the PackageName  parameter.
	
	.PARAMETER PackageVersion
		A description of the PackageVersion  parameter.
	
	.PARAMETER PackageType
		A description of the PackageType  parameter.
	
	.EXAMPLE
				PS C:\> Enable-CapaPackageSchedule -CapaSDK $value1 -PackageName  'Value2' -PackageVersion  'Value3' -PackageType  'Value4'
	
	.NOTES
		Additional information about the function.
#>
function Enable-CapaPackageSchedule
{
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
	
	if ($PackageType -eq 'Computer')
	{
		$PackageType = '1'
	}
	if ($PackageType -eq 'User')
	{
		$PackageType = '2'
	}
	
	$value = $CapaSDK.EnablePackageSchedule($PackageName, $PackageVersion, $PackageType)
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246874/Exist+package
	
	.DESCRIPTION
		A detailed description of the Exist-CapaPackage function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER Name
		A description of the Name parameter.
	
	.PARAMETER Version
		A description of the Version  parameter.
	
	.EXAMPLE
				PS C:\> Exist-CapaPackage -CapaSDK $value1 -Name 'Value2' -Version  'Value3'
	
	.NOTES
		Additional information about the function.
#>
function Exist-CapaPackage
{
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
	
	if ($PackageType -eq 'Computer')
	{
		$PackageType = '1'
	}
	if ($PackageType -eq 'User')
	{
		$PackageType = '2'
	}
	
	$value = $CapaSDK.ExistPackage($Name, $Version, $Type)
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246882/Export+package
	
	.DESCRIPTION
		A detailed description of the Export-CapaPackage function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER PackageType
		A description of the PackageType parameter.
	
	.PARAMETER PackageName
		A description of the PackageName parameter.
	
	.PARAMETER PackageVersion
		A description of the PackageVersion parameter.
	
	.PARAMETER ToFolder
		A description of the ToFolder parameter.
	
	.EXAMPLE
				PS C:\> Export-CapaPackage -CapaSDK $value1 -PackageType Computer -PackageName 'Value3' -PackageVersion 'Value4' -ToFolder 'Value5'
	
	.NOTES
		Additional information about the function.
#>
function Export-CapaPackage
{
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
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246928/Get+Package+Description
	
	.DESCRIPTION
		A detailed description of the Get-CapaPackageDescription function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER PackageName
		A description of the PackageName  parameter.
	
	.PARAMETER PackageVersion
		A description of the PackageVersion  parameter.
	
	.PARAMETER PackageType
		A description of the PackageType  parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaPackageDescription -CapaSDK $value1 -PackageName  'Value2' -PackageVersion  'Value3' -PackageType  'Value4'
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaPackageDescription
{
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
	
	if ($PackageType -eq 'Computer')
	{
		$PackageType = '1'
	}
	if ($PackageType -eq 'User')
	{
		$PackageType = '2'
	}
	
	$value = $CapaSDK.GetPackageDescription($PackageName, $PackageVersion, $PackageType)
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246936/Get+Package+Folder
	
	.DESCRIPTION
		A detailed description of the Get-CapaPackageFolder function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER Type
		A description of the Type parameter.
	
	.PARAMETER PackageName
		A description of the PackageName parameter.
	
	.PARAMETER PackageVersion
		A description of the PackageVersion parameter.
	
	.EXAMPLE
		PS C:\> Get-CapaPackageFolder -CapaSDK $CapaSDK -Type Computer -PackageName $PackageName -PackageVersion $PackageVersion
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaPackageFolder
{
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
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246300/Get+package+groups
	
	.DESCRIPTION
		A detailed description of the Get-CapaPackageGroups function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER PackageType
		A description of the PackageType parameter.
	
	.PARAMETER PackageName
		A description of the PackageName parameter.
	
	.PARAMETER PackageVersion
		A description of the PackageVersion parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaPackageGroups -CapaSDK $value1 -PackageType Computer -PackageName 'Value3' -PackageVersion 'Value4'
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaPackageGroups
{
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
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name	    = $aItem[0];
			Type	    = $aItem[1];
			UnitTypeID  = $aItem[2];
			Description = $aItem[3];
			GUID	    = $aItem[4];
			ID		    = $aItem[5]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246954/Get+packages
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246964/Get+packages+on+Business+Unit
	
	.DESCRIPTION
		A detailed description of the Get-CapaPackages function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER Type
		A description of the Type parameter.
	
	.EXAMPLE
		PS C:\> Get-CapaPackages -CapaSDK $CapaSDK
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaPackages
{
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $false)]
		[ValidateSet('Computer', 'User')]
		[string]$Type = '',
		[String]$BusinessUnit = ""
	)
	
	$oaUnits = @()
	
	if ($BusinessUnit -eq "")
	{
		$aUnits = $CapaSDK.GetPackages($Type)
	}
	else
	{
		$aUnits = $CapaSDK.GetPackagesOnBusinessUnit($BusinessUnit)
	}
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name			   = $aItem[0];
			Version		       = $aItem[1];
			Type			   = $aItem[2];
			DisplayName	       = $aItem[3];
			IsMandatory	       = $aItem[4];
			ScheduleId		   = $aItem[5];
			Description	       = $aItem[6];
			GUID			   = $aItem[7];
			ID				   = $aItem[8];
			IsInteractive	   = $aItem[9];
			DependendPackageID = $aItem[10];
			IsInventoryPackage = $aItem[11];
			CollectMode	       = $aItem[12];
			Priority		   = $aItem[13];
			ServerDeploy	   = $aItem[14]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246300/Get+package+groups
	
	.DESCRIPTION
		A detailed description of the Get-CapaPackagesGroups function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER GroupType
		A description of the GroupType parameter.
	
	.PARAMETER PackageType
		A description of the PackageType parameter.
	
	.EXAMPLE
		PS C:\> Get-CapaPackagesGroups -CapaSDK $CapaSDK
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaPackageGroups
{
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $false)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Security', 'Static')]
		[string]$GroupType = '',
		[Parameter(Mandatory = $false)]
		[ValidateSet('Computer', 'User')]
		[string]$PackageType = ''
	)
	
	$oaUnits = Get-CapaPackages -CapaSDK $CapaSDK -Type $PackageType
	$oaUnits | Add-Member -NotePropertyName LinkedGroups -NotePropertyValue ''
	
	$AllGroups = Get-CapaGroups -CapaSDK $CapaSDK -Type $GroupType
	foreach ($Group in $AllGroups)
	{
		if ($Group.Type -ne 'Catalog' -and $Group.Type -ne 'PowerScheme')
		{
			$AllGroupPackages = Get-CapaGroupPackages -CapaSDK $CapaSDK -GroupName $Group.Name -Type $Group.Type
			foreach ($Package in $AllGroupPackages)
			{
				$CurrentPCK = $oaUnits | Where-Object { $_.Name -eq $Package.Name -and $_.Version -eq $Package.Version }
				If ($CurrentPCK.LinkedGroups -eq '')
				{
					$CurrentPCK.LinkedGroups = $Group.Name
				}
				else
				{
					$CurrentPCK.LinkedGroups += ";$($Group.Name)"
				}
			}
		}
	}
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246974/Get+packages+on+management+server
	
	.DESCRIPTION
		A detailed description of the Get-CapaPackagesOnManagementServer function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER ServerName
		A description of the ServerName  parameter.
	
	.PARAMETER PackageType
		A description of the PackageType parameter.
	
	.EXAMPLE
		PS C:\> Get-CapaPackagesOnManagementServer -CapaSDK $value1
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaPackagesOnManagementServer
{
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
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name			   = $aItem[0];
			Version		       = $aItem[1];
			Type			   = $aItem[2];
			DisplayName	       = $aItem[3];
			IsMandatory	       = $aItem[4];
			ScheduleId		   = $aItem[5];
			Description	       = $aItem[7];
			GUID			   = $aItem[8];
			ID				   = $aItem[9];
			IsInteractive	   = $aItem[10];
			DependendPackageID = $aItem[11];
			IsInventoryPackage = $aItem[12];
			CollectMode	       = $aItem[13];
			Priority		   = $aItem[14];
			ServerDeploy	   = $aItem[15]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246944/Get+package+status
	
	.DESCRIPTION
		A detailed description of the Get-CapaPackageStatus function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName  parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaPackageStatus -CapaSDK $value1 -UnitName  'Value2' -UnitType Computer
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaPackageStatus
{
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
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			UnitName	   = $aItem[0];
			PackageName    = $aItem[1];
			PackageVersion = $aItem[2];
			Status		   = $aItem[3];
			DisplayStatus  = $aItem[4]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247456/Get+package+units
	
	.DESCRIPTION
		A detailed description of the Get-CapaPackageUnits function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER Name
		A description of the Name parameter.
	
	.PARAMETER Version
		A description of the Version parameter.
	
	.PARAMETER Type
		A description of the Type parameter.
	
	.EXAMPLE
		PS C:\> Get-CapaPackageUnits -CapaSDK $CapaSDK -Name $Name -Version $Version -Type Computer
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaPackageUnits
{
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
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name		 = $aItem[0];
			Created	     = $aItem[1];
			LastExecuted = $aItem[2];
			Status	     = $aItem[3];
			Description  = $aItem[4];
			GUID		 = $aItem[5];
			ID		     = $aItem[6];
			TypeName	 = $aItem[7]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246984/Import+package
	
	.DESCRIPTION
		A detailed description of the Import-CapaPackage function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER FilePath
		A description of the FilePath  parameter.
	
	.PARAMETER OverrideCIPCdata
		A description of the OverrideCIPCdata   parameter.
	
	.PARAMETER ImportFolderStructure
		A description of the ImportFolderStructure  parameter.
	
	.PARAMETER ImportSchedule
		A description of the ImportSchedule  parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment parameter.
	
	.EXAMPLE
				PS C:\> Import-CapaPackage -CapaSDK $value1 -FilePath  'Value2' -OverrideCIPCdata   $value3 -ImportFolderStructure  $value4 -ImportSchedule  $value5
	
	.NOTES
		Additional information about the function.
#>
function Import-CapaPackage
{
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
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246992/Promote+Package
	
	.DESCRIPTION
		A detailed description of the Initialize-CapaPackagePromote function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER PackageType
		A description of the Type parameter.
	
	.PARAMETER PackageName
		A description of the PackageName parameter.
	
	.PARAMETER PackageVersion
		A description of the PackageVersion parameter.
	
	.EXAMPLE
		PS C:\> Initialize-CapaPackagePromote -CapaSDK $value1 -Type Computer -PackageName 'Value3' -PackageVersion 'Value4'
	
	.NOTES
		Additional information about the function.
#>
function Initialize-CapaPackagePromote
{
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
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246831/Delete+Package
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247000/Remove+Package+From+BusinessUnit
	
	.DESCRIPTION
		A detailed description of the Remove-CapaPackage function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER PackageType
		A description of the PackageType parameter.
	
	.PARAMETER PackageName
		A description of the PackageName parameter.
	
	.PARAMETER PackageVersion
		A description of the PackageVersion parameter.
	
	.PARAMETER Force
		A description of the Force parameter.
	
	.EXAMPLE
		PS C:\> Remove-CapaPackage -CapaSDK $value1 -PackageType Computer -PackageName 'Value3' -PackageVersion 'Value4'
	
	.NOTES
		Additional information about the function.
#>
function Remove-CapaPackage
{
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
	if ($BusinessUnitName -eq '')
	{
		$value = $CapaSDK.DeletePackage($PackageName, $PackageVersion, $PackageType, $Force)
	}
	else
	{
		$value = $CapaSDK.RemovePackageFromBusinessUnit($PackageName, $PackageVersion, $PackageType, $BusinessUnitName)
	}
	
	Return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247008/Remove+package+from+group
	
	.DESCRIPTION
		A detailed description of the Remove-CapaPackageFromGroup function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER PackageName
		A description of the PackageName parameter.
	
	.PARAMETER PackageVersion
		A description of the PackageVersion parameter.
	
	.PARAMETER PackageType
		A description of the PackageType parameter.
	
	.PARAMETER GroupName
		A description of the GroupName parameter.
	
	.PARAMETER GroupType
		A description of the GroupType parameter.
	
	.EXAMPLE
		PS C:\> Remove-CapaPackageFromGroup -CapaSDK $CapaSDK -PackageName $PackageName -PackageVersion $PackageVersion -PackageType Computer -GroupName $GroupName -GroupType Dynamic_ADSI
	
	.NOTES
		Additional information about the function.
#>
function Remove-CapaPackageFromGroup
{
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
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247016/Remove+package+from+management+server
	
	.DESCRIPTION
		A detailed description of the Remove-CapaPackageFromManagementServer function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER PackageName
		A description of the PackageName parameter.
	
	.PARAMETER PackageVersion
		A description of the PackageVersion parameter.
	
	.PARAMETER PackageType
		A description of the PackageType parameter.
	
	.PARAMETER ServerName
		A description of the ServerName parameter.
	
	.EXAMPLE
				PS C:\> Remove-CapaPackageFromManagementServer -CapaSDK $value1 -PackageName 'Value2' -PackageVersion 'Value3' -PackageType 1 -ServerName 'Value5'
	
	.NOTES
		Additional information about the function.
#>
function Remove-CapaPackageFromManagementServer
{
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
	
	if ($PackageType -eq 'Computer')
	{
		$PackageType = '1'
	}
	if ($PackageType -eq 'User')
	{
		$PackageType = '2'
	}
	
	$value = $CapaSDK.RemovePackageFromManagementServer($PackageName, $PackageVersion, $PackageType, $ServerName)
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247024/Set+Package+Description
	
	.DESCRIPTION
		A detailed description of the Set-CapaPackageDescription function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER PackageName
		A description of the PackageName parameter.
	
	.PARAMETER PackageVersion
		A description of the PackageVersion parameter.
	
	.PARAMETER PackageType
		A description of the PackageType parameter.
	
	.PARAMETER Description
		A description of the Description parameter.
	
	.EXAMPLE
				PS C:\> Set-CapaPackageDescription -CapaSDK $value1 -PackageName 'Value2' -PackageVersion 'Value3' -PackageType 1 -Description ""
	
	.NOTES
		Additional information about the function.
#>
function Set-CapaPackageDescription
{
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
	
	if ($PackageType -eq 'Computer')
	{
		$PackageType = '1'
	}
	if ($PackageType -eq 'User')
	{
		$PackageType = '2'
	}
	
	$value = $CapaSDK.SetPackageDescription($PackageName, $PackageVersion, $PackageType, $Description)
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247032/Set+Package+Folder
	
	.DESCRIPTION
		A detailed description of the Set-CapaPackageFolder function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER PackageType
		A description of the Type parameter.
	
	.PARAMETER PackageName
		A description of the PackageName parameter.
	
	.PARAMETER PackageVersion
		A description of the PackageVersion parameter.
	
	.PARAMETER FolderStructure
		A description of the FolderStructure parameter.
	
	.PARAMETER ChangelogText
		A description of the ChangelogText parameter.
	
	.EXAMPLE
		PS C:\> Set-CapaPackageFolder -CapaSDK $value1 -Type Computer -PackageName 'Value3' -PackageVersion 'Value4' -FolderStructure 'Value5'
	
	.NOTES
		Additional information about the function.
#>
function Set-CapaPackageFolder
{
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
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247040/Set+Package+Property
	
	.DESCRIPTION
		A detailed description of the Set-CapaPackagePriority function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER PackageName
		A description of the PackageName  parameter.
	
	.PARAMETER PackageVersion
		A description of the PackageVersion  parameter.
	
	.PARAMETER PackageType
		A description of the PackageType  parameter.
	
	.PARAMETER Priority
		A description of the Priority parameter.
	
	.EXAMPLE
				PS C:\> Set-CapaPackagePriority -CapaSDK $value1 -PackageName  'Value2' -PackageVersion  'Value3' -PackageType  'Value4'
	
	.NOTES
		Additional information about the function.
#>
function Set-CapaPackagePriority
{
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
	
	if ($PackageType -eq 'Computer')
	{
		$PackageType = '1'
	}
	if ($PackageType -eq 'User')
	{
		$PackageType = '2'
	}
	
	$value = $CapaSDK.SetPackagePriority($PackageName, $PackageVersion, $PackageType, $Priority)
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247048/Set+Package+Schedule
	
	.DESCRIPTION
		A detailed description of the Set-CapaPackageSchedule function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER PackageName
		A description of the PackageName parameter.
	
	.PARAMETER PackageVersion
		A description of the PackageVersion  parameter.
	
	.PARAMETER PackageType
		A description of the PackageType parameter.
	
	.PARAMETER ScheduleStart
		A description of the ScheduleStart parameter.
	
	.PARAMETER ScheduleEnd
		A description of the ScheduleEnd parameter.
	
	.PARAMETER ScheduleIntervalBegin
		A description of the ScheduleIntervalBegin  parameter.
	
	.PARAMETER ScheduleIntervalEnd
		A description of the ScheduleIntervalEnd  parameter.
	
	.PARAMETER ScheduleRecurrence
		A description of the ScheduleRecurrence parameter.
	
	.PARAMETER ScheduleRecurrencePattern
		A description of the ScheduleRecurrencePattern  parameter.
	
	.EXAMPLE
		PS C:\> Set-CapaPackageSchedule -CapaSDK $value1 -PackageName 'Value2' -PackageVersion  'Value3' -PackageType Computer -ScheduleStart 'Value5' -ScheduleEnd 'Value6' -ScheduleIntervalBegin  'Value7' -ScheduleIntervalEnd  'Value8' -ScheduleRecurrence Once -ScheduleRecurrencePattern  'Value10'
	
	.NOTES
		Additional information about the function.
#>
function Set-CapaPackageSchedule
{
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
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247056/Update+Now+on+Package
	
	.DESCRIPTION
		A detailed description of the Update-CapaPackageNow function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER PackageName
		A description of the PackageName  parameter.
	
	.PARAMETER PackageVersion
		A description of the PackageVersion parameter.
	
	.PARAMETER PackageType
		A description of the PackageType parameter.
	
	.EXAMPLE
				PS C:\> Update-CapaPackageNow -CapaSDK $value1 -PackageName  'Value2' -PackageVersion 'Value3' -PackageType Computer
	
	.NOTES
		Additional information about the function.
#>
function Update-CapaPackageNow
{
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
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246890/Get+all+inventory+packages
	
	.DESCRIPTION
		A detailed description of the Get-CapaAllInventoryPackages function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER PackageType
		A description of the PackageType parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaAllInventoryPackages -CapaSDK $value1
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaAllInventoryPackages
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[string]$PackageType = ''
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetAllInventoryPackages($PackageType)
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name			   = $aItem[0];
			Version		       = $aItem[1];
			Type			   = $aItem[2];
			DisplayName	       = $aItem[3];
			IsMandatory	       = $aItem[4];
			ScheduleId		   = $aItem[5];
			Description	       = $aItem[6];
			GUID			   = $aItem[7];
			ID				   = $aItem[8];
			IsInteractive	   = $aItem[9];
			DependendPackageID = $aItem[10];
			IsInventoryPackage = $aItem[11];
			CollectMode	       = $aItem[12];
			Priority		   = $aItem[13];
			ServerDeploy	   = $aItem[14]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246900/Get+all+none+inventory+packages
	
	.DESCRIPTION
		A detailed description of the Get-CapatAllNoneInventoryPackages function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER PackageType
		A description of the PackageType parameter.
	
	.EXAMPLE
				PS C:\> Get-CapatAllNoneInventoryPackages -CapaSDK $value1
	
	.NOTES
		Additional information about the function.
#>
function Get-CapatAllNoneInventoryPackages
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[string]$PackageType = ''
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetAllNoneInventoryPackages($PackageType)
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name			   = $aItem[0];
			Version		       = $aItem[1];
			Type			   = $aItem[2];
			DisplayName	       = $aItem[3];
			IsMandatory	       = $aItem[4];
			ScheduleId		   = $aItem[5];
			Description	       = $aItem[6];
			GUID			   = $aItem[7];
			ID				   = $aItem[8];
			IsInteractive	   = $aItem[9];
			DependendPackageID = $aItem[10];
			IsInventoryPackage = $aItem[11];
			CollectMode	       = $aItem[12];
			Priority		   = $aItem[13];
			ServerDeploy	   = $aItem[14]
		}
	}
	
	Return $oaUnits
}