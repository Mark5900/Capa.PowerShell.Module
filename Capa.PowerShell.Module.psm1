<#	
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2022 v5.8.209
	 Created on:   	11-08-2022 08:22
	 Created by:   	Mark5900
	 Organization: 	
	 Filename:     	Capa.PowerShell.Module.psm1
	-------------------------------------------------------------------------
	 Module Name: Capa.PowerShell.Module
	===========================================================================
#>

<#
    Default Capa SDK comand fuctions
#>
<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246954/Get+packages
	
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
#TODO: #3 Coverter data til de rigtige datatyper
#TODO: #6 #7 Sammel funktioner der har noget med BU'er i den overordnede funktion uden BU
function Get-CapaPackages {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $false)]
		[ValidateSet('Computer', 'User')]
		[string]$Type = ''
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetPackages($Type)
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
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246280/Get+groups
	
	.DESCRIPTION
		A detailed description of the Get-CapaGroups function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER Type
		A description of the Type parameter.
	
	.EXAMPLE
		PS C:\> Get-CapaGroups -CapaSDK $CapaSDK
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaGroups {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $false)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Security', 'Static')]
		[string]$GroupType = ''
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetGroups($GroupType)
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		
		if ($aItem[2] -eq '1') {
			$UnitType = 'Computer'
		} else {
			$UnitType = 'User'
		}
		
		$oaUnits += [pscustomobject]@{
			Name         = $aItem[0];
			Type         = $aItem[1];
			UnitTypeID   = $aItem[2];
			UnitTypeName	= $UnitType;
			Description  = $aItem[3];
			GUID         = $aItem[4];
			ID           = $aItem[5]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246910/Get+group+packages
	
	.DESCRIPTION
		A detailed description of the Get-CapaGroupPackages function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER GroupName
		A description of the GroupName parameter.
	
	.PARAMETER GroupType
		A description of the Type parameter.
	
	.EXAMPLE
		PS C:\> Get-CapaGroupPackages -CapaSDK $CapaSDK -GroupName $GroupName -Type Dynamic_ADSI
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaGroupPackages {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Security', 'Static')]
		[string]$GroupType
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetGroupPackages($GroupName, $GroupType)
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
    Custom functions to things Capa SDK does not cotain
#>
<#
	.SYNOPSIS
		Custom fuction. Der findes andre funktioner der kan hente grupper ud som objecter
	
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
function Get-CapaPackagesGroups {
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
	foreach ($Group in $AllGroups) {
		if ($Group.Type -ne 'Catalog' -and $Group.Type -ne 'PowerScheme') {
			$AllGroupPackages = Get-CapaGroupPackages -CapaSDK $CapaSDK -GroupName $Group.Name -Type $Group.Type
			foreach ($Package in $AllGroupPackages) {
				$CurrentPCK = $oaUnits | Where-Object { $_.Name -eq $Package.Name -and $_.Version -eq $Package.Version }
				If ($CurrentPCK.LinkedGroups -eq '') {
					$CurrentPCK.LinkedGroups = $Group.Name
				} else {
					$CurrentPCK.LinkedGroups += ";$($Group.Name)"
				}
			}
		}
	}
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246140/Set+database+settings
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246148/Set+default+management+point
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246158/Set+instance+management+point
	
	.DESCRIPTION
		A detailed description of the Initialize-CapaSDK function.
	
	.PARAMETER CapaSdkDllPath
		A description of the CapaSdkDllPath parameter.
	
	.PARAMETER Server
		A description of the Server parameter.
	
	.PARAMETER Database
		A description of the Database parameter.
	
	.PARAMETER UserName
		A description of the UserName parameter.
	
	.PARAMETER Password
		A description of the Password parameter.
	
	.PARAMETER DefaultManagementPoint
		A description of the DefaultManagementPoint parameter.
	
	.PARAMETER InstanceManagementPoint
		A description of the InstanceManagementPoint parameter.
	
	.EXAMPLE
		PS C:\> Initialize-CapaSDK -Server 'value1' -Database 'value2' -DefaultManagementPoint Dev
	
	.NOTES
		Additional information about the function.
#>
function Initialize-CapaSDK {
	[CmdletBinding()]
	param
	(
		[string]$CapaSdkDllPath = '',
		[Parameter(Mandatory = $true)]
		[string]$Server,
		[Parameter(Mandatory = $true)]
		[string]$Database = '',
		[string]$UserName = '',
		[string]$Password = '',
		[Parameter(Mandatory = $false)]
		[string]$DefaultManagementPoint,
		[string]$InstanceManagementPoint
	)
	#TODO: #1 DLL'en er ikke nok til at få modulet til at virke og måske ikke nødvendig overhovedet at have med i installationen 
	
	$CapaSDKDllName = 'CapaInstaller.SDK.dll'
	$ModulePaths = $env:PSModulePath -split ';'
	
	# If CapaSdkDllPath i not null then insert DLL file in module folder
	If ($CapaSdkDllPath -ne '') {
		foreach ($Path in $ModulePaths) {
			$TestPath = "$Path\Capa.PowerShell.Module\"
			If (Test-Path $TestPath) {
				$Destination = "$TestPath\$CapaSDKDllName"
				Copy-Item -Path $CapaSdkDllPath -Destination $Destination -Force
			}
		}
	}
	# Finds CapaInstaller SDK DLL, if it does not exist then ask for the DLL file
	Else {
		$NewDllFilePath = ''
		foreach ($Path in $ModulePaths) {
			$TestPath = "$Path\Capa.PowerShell.Module\"
			If (Test-Path $TestPath) {
				$TestDllPath = "$TestPath\$CapaSDKDllName"
				If (Test-Path $TestDllPath) {
					$Destination = $TestDllPath
				} elseif ($NewDllFilePath -eq '') {
					#Browsing file
					Add-Type -AssemblyName System.Windows.Forms
					$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog
					$FileBrowser.Filter = 'Dll (*.dll)| *.dll'
					[void]$FileBrowser.ShowDialog()
					$NewDllFilePath = $FileBrowser.FileName
					
					$Destination = "$TestDllPath\$CapaSDKDllName"
					Copy-Item -Path $NewDllFilePath -Destination $Destination -Force
				} Else {
					$Destination = "$TestDllPath\$CapaSDKDllName"
					Copy-Item -Path $NewDllFilePath -Destination $Destination -Force
				}
			}
			
		}
	}
	
	Add-Type -Path $Destination
	$oCMS = New-Object -ComObject CapaInstaller.SDK
	
	If ($UserName -ne '' -or $Password -ne '') {
		$oCMS.SetDatabaseSettings($Server, $Database, $true, $UserName, $Password) | Out-Null
	} else {
		$oCMS.SetDatabaseSettings($Server, $Database, $false) | Out-Null
	}
	
	if ($DefaultManagementPoint -ne '') {
		$oCMS.SetDefaultManagementPoint($DefaultManagementPoint) | Out-Null
	}
	
	if ($InstanceManagementPoint -ne '') {
		$oCMS.SetInstanceManagementPoint($InstanceManagementPoint) | Out-Null
	}
	
	$oCMS.SetSplitter(';') | Out-Null
	
	return $oCMS
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247572/Get+units
	
	.DESCRIPTION
		A detailed description of the Get-CapaUnits function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER Type
		A description of the Type parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaUnits -CapaSDK $value1
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaUnits {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $false)]
		[ValidateSet('Computer', 'User')]
		[string]$Type = ''
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetUnits($Type)
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name           = $aItem[0];
			Created        = $aItem[1];
			LastExecuted   = $aItem[2];
			Status         = $aItem[3];
			Description    = $aItem[4];
			GUID           = $aItem[5];
			ID             = $aItem[6];
			TypeName       = $aItem[7];
			UUID           = $aItem[8];
			IsMobileDevice = $aItem[9];
			Location       = $aItem[10]
		}
	}
	
	Return $oaUnits
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
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247340/Add+unit+to+package
	
	.DESCRIPTION
		A detailed description of the Add-CapaUnitToPackage function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER PackageType
		A description of the PackageType parameter.
	
	.PARAMETER PackageName
		A description of the PackageName parameter.
	
	.PARAMETER PackageVersion
		A description of the PackageVersion parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.EXAMPLE
		PS C:\> Add-CapaUnitToPackage -CapaSDK $CapaSDK -PackageType Computer -PackageName 'value3' -PackageVersion 'value4' -UnitName 'value5' -UnitType Computer
	
	.NOTES
		Additional information about the function.
#>
function Add-CapaUnitToPackage {
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
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)
	
	$bool = $CapaSDK.AddUnitToPackage($UnitName, $UnitType, $PackageName, $PackageVersion, $PackageType)
	
	Return $bool
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
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247672/Remove+unit+from+package
	
	.DESCRIPTION
		A detailed description of the Remove-CapaUnitFromPackage function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER PackageName
		A description of the PackageName parameter.
	
	.PARAMETER PackageVersion
		A description of the PackageVersion parameter.
	
	.PARAMETER PackageType
		A description of the PackageType parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.EXAMPLE
				PS C:\> Remove-CapaUnitFromPackage -CapaSDK $value1 -PackageName 'Value2' -PackageVersion 'Value3' -PackageType Computer -UnitName 'Value5' -UnitType Computer
	
	.NOTES
		Additional information about the function.
#>
function Remove-CapaUnitFromPackage {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User', '1', '2')]
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)
	
	if ($PackageType -eq 'Computer') {
		$PackageType = 1
	} else {
		$PackageType = 2
	}
	
	$bool = $CapaSDK.RemoveUnitFromPackage($UnitName, $UnitType, $PackageName, $PackageVersion, $PackageType)
	Return $bool
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
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246831/Delete+Package
	
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
function Remove-CapaPackage {
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
		[ValidateSet('True', 'False')]
		[string]$Force = 'True'
	)
	
	$bool = $CapaSDK.DeletePackage($PackageName, $PackageVersion, $PackageType, $Force)
	Return $bool
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
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247492/Get+unit+last+runtime
	
	.DESCRIPTION
		A detailed description of the Get-CapaUnitLastRuntime function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaUnitLastRuntime -CapaSDK $value1 -UnitName "" -UnitType ""
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitLastRuntime {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName = '',
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User', '1', '2')]
		[string]$UnitType = ''
	)
	
	if ($UnitType -eq 'Computer') {
		$UnitType = '1'
	} else {
		$UnitType = '2'
	}
	
	$aUnits = $CapaSDK.GetUnitLastRuntime($UnitName, $UnitType)
	
	Return $aUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247758/Set+unit+status
	
	.DESCRIPTION
		A detailed description of the Set-CapaUnitStatus function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER Status
		A description of the Status parameter.
	
	.EXAMPLE
				PS C:\> Set-CapaUnitStatus -CapaSDK $value1 -UnitName "" -Status ""
	
	.NOTES
		Additional information about the function.
#>
function Set-CapaUnitStatus {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName = '',
		[Parameter(Mandatory = $true)]
		[ValidateSet('Active', 'Inactive')]
		[string]$Status = ''
	)
	
	$aUnits = $CapaSDK.SetUnitStatus($UnitName, $Status)
	
	Return $aUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247310/Add+unit+to+folder
	
	.DESCRIPTION
		A detailed description of the Add-CapaUnitToFolder function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.PARAMETER FolderStructure
		A description of the FolderStructure parameter.
	
	.PARAMETER CreateFolder
		Default is false
	
	.EXAMPLE
				PS C:\> Add-CapaUnitToFolder -CapaSDK $value1 -UnitName "" -UnitType "" -FolderStructure ""
	
	.NOTES
		Additional information about the function.
#>
function Add-CapaUnitToFolder {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName = '',
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType = '',
		[Parameter(Mandatory = $true)]
		[string]$FolderStructure = '',
		[ValidateSet('true', 'false')]
		[string]$CreateFolder
	)
	
	$aUnits = $CapaSDK.AddUnitToFolder($UnitName, $UnitType, $FolderStructure, $CreateFolder)
	
	Return $aUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247446/Get+group+units
	
	.DESCRIPTION
		A detailed description of the Get-CapaGroupUnits function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER GroupName
		A description of the GroupName parameter.
	
	.PARAMETER GroupType
		A description of the GroupType parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaGroupUnits -CapaSDK $value1 -GroupName 'Value2' -GroupType Dynamic_ADSI
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaGroupUnits {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Security', 'Static')]
		[string]$GroupType
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetGroupUnits($GroupName, $GroupType)
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
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246240/Delete+group
	
	.DESCRIPTION
		A detailed description of the Remove-CapaGroup function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER GroupName
		A description of the GroupName parameter.
	
	.PARAMETER GroupType
		A description of the GroupType parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.EXAMPLE
				PS C:\> Remove-CapaGroup -CapaSDK $value1 -GroupName 'Value2' -GroupType Dynamic_ADSI -UnitType Computer
	
	.NOTES
		Additional information about the function.
#>
function Remove-CapaGroup {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Security', 'Static')]
		[string]$GroupType,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)
	
	$bool = $CapaSDK.DeleteGroup($GroupName, $GroupType, $UnitType)
	
	Return $bool
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246240/Delete+group
	
	.DESCRIPTION
		A detailed description of the Remove-CapaUnitByUUID function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UUID
		A description of the UUID parameter.
	
	.EXAMPLE
				PS C:\> Remove-CapaUnitByUUID -CapaSDK $value1 -UUID 'Value2'
	
	.NOTES
		Additional information about the function.
#>
function Remove-CapaUnitByUUID {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UUID
	)
	
	$bool = $CapaSDK.DeleteUnitByUUID($UUID)
	
	Return $bool
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247632/GetUnitFolder
	
	.DESCRIPTION
		A detailed description of the Get-CapaUnitFolder function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaUnitFolder -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitFolder {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)
	
	$bool = $CapaSDK.GetUnitFolder($UnitName, $UnitType)
	
	Return $bool
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247664/Remove+unit+from+group
	
	.DESCRIPTION
		A detailed description of the Remove-CapaUnitFromGroup function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.PARAMETER GroupName
		A description of the GroupName parameter.
	
	.PARAMETER GroupType
		A description of the GroupType parameter.
	
	.EXAMPLE
		PS C:\> Remove-CapaUnitFromGroup -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer -GroupName 'Value4' -GroupType ""
	
	.NOTES
		Additional information about the function.
#>
function Remove-CapaUnitFromGroup {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType,
		[Parameter(Mandatory = $true)]
		[string]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Security', 'Static')]
		[string]$GroupType
	)
	
	$bool = $CapaSDK.RemoveUnitFromGroup($UnitName, $UnitType, $GroupName, $GroupType)
	
	Return $bool
}

<#
	.SYNOPSIS
		Used to convert DataType number to a string that makes sense
	
	.DESCRIPTION
		A detailed description of the Convert-CapaDataType function.
	
	.PARAMETER Datatype
		A description of the Datatype parameter.
	
	.EXAMPLE
				PS C:\> Convert-CapaDataType
	
	.NOTES
		Additional information about the function.
#>
function Convert-CapaDataType {
	param
	(
		$Datatype
	)
	
	switch ($DataType) {
		1 { $Datatype = 'String' }
		2 { $Datatype = 'Time' }
		3 { $Datatype = 'Integer' }
		"I" { $Datatype = 'Integer' }
		"T" { $Datatype = 'Time' }
		"S" { $Datatype = 'String' }
		"N" { $Datatype = 'Text' }
		Default { $Datatype = $Datatype }
	}
	
	return $Datatype
}
<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246358/Get+custom+inventory+for+unit
	
	.DESCRIPTION
		A detailed description of the Get-CapaCustomInventoryForUnit function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.PARAMETER Uuid
		A description of the Uuid parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaCustomInventoryForUnit -Uuid 'Value1'
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaCustomInventoryForUnit {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[string]$UnitName,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType,
		[Parameter(ParameterSetName = 'Uuid',
			Mandatory = $true)]
		[string]$Uuid
	)
	
	$oaUnits = @()
	
	if ($PSCmdlet.ParameterSetName -eq 'NameType') {
		$aUnits = $CapaSDK.GetCustomInventoryForUnit($UnitName, $UnitType)
	} else {
		$aUnits = $CapaSDK.GetCustomInventoryForUnitUUID($Uuid)
	}
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$DataType = Convert-CapaDataType -Datatype $aItem[3]
		$oaUnits += [pscustomobject]@{
			Category = $aItem[0];
			Entry    = $aItem[1];
			Value    = $aItem[2];
			Datatype = $DataType;
			GUID     = $aItem[4];
			ID       = $aItem[5]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246368/Get+hardware+inventory+for+unit
	
	.DESCRIPTION
		A detailed description of the Get-CapaHardwareInventoryForUnit function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaHardwareInventoryForUnit -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaHardwareInventoryForUnit {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetHardwareInventoryForUnit($UnitName, $UnitType)
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$DataType = Convert-CapaDataType -Datatype $aItem[3]
		$oaUnits += [pscustomobject]@{
			Category = $aItem[0];
			Entry    = $aItem[1];
			Value    = $aItem[2];
			Datatype = $DataType;
			GUID     = $aItem[4];
			ID       = $aItem[5]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246378/Get+logon+history+for+unit
	
	.DESCRIPTION
		A detailed description of the Get-CapaLogonHistoryForUnit function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaLogonHistoryForUnit -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaLogonHistoryForUnit {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetLogonHistoryForUnit($UnitName, $UnitType)
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$DataType = Convert-CapaDataType -Datatype $aItem[3]
		$oaUnits += [pscustomobject]@{
			Category = $aItem[0];
			Entry    = $aItem[1];
			Value    = $aItem[2];
			Datatype = $DataType;
			GUID     = $aItem[4];
			ID       = $aItem[5]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246398/Get+software+inventory+for+unit
	
	.DESCRIPTION
		A detailed description of the Get-CapaSoftwareInventoryForUnit function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.PARAMETER Uuid
		A description of the Uuid parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaSoftwareInventoryForUnit -UnitType Computer -Uuid 'Value2'
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaSoftwareInventoryForUnit {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[string]$UnitName,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[Parameter(ParameterSetName = 'Uuid',
			Mandatory = $true)]
		[ValidateSet('Computer', 'User', '1', '2')]
		[string]$UnitType,
		[Parameter(ParameterSetName = 'Uuid',
			Mandatory = $true)]
		[string]$Uuid
	)
	
	if ($UnitType -eq 'Computer') {
		$UnitType = '1'
	}
	if ($UnitType -eq 'User') {
		$UnitType = '2'
	}
	
	$oaUnits = @()
	
	if ($PSCmdlet.ParameterSetName -eq 'NameType') {
		$aUnits = $CapaSDK.GetSoftwareInventoryForUnit($UnitName, $UnitType)
	} else {
		$aUnits = $CapaSDK.GetSoftwareInventoryForUnit($Uuid, $UnitType)
	}
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			SoftwareName           = $aItem[0];
			SoftwareVersion        = $aItem[1];
			InstallDate            = $aItem[2];
			SoftwareMeteringModule = $aItem[3];
			SoftwareAppCode        = $aItem[4];
			SoftwareDescription    = $aItem[5];
			SoftwareID             = $aItem[6];
			SoftwareVendor         = $aItem[7]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246224/Create+group
	
	.DESCRIPTION
		A detailed description of the Create-CapaGroup function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER GroupName
		A description of the GroupName  parameter.
	
	.PARAMETER GroupType
		A description of the GroupType  parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.EXAMPLE
				PS C:\> Create-CapaGroup -CapaSDK $value1 -GroupName  'Value2' -GroupType  Calendar -UnitType Computer
	
	.NOTES
		Additional information about the function.
#>
function Create-CapaGroup {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Calendar', 'Department', 'Static')]
		[string]$GroupType,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType
	)
	
	$value = $CapaSDK.CreateGroup($GroupName, $GroupType, $UnitType)
	
	return $value
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247732/Set+unit+label
	
	.DESCRIPTION
		A detailed description of the Set-CapaUnitLabel function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.PARAMETER Label
		A description of the Label parameter.
	
	.EXAMPLE
		PS C:\> Set-CapaUnitLabel -CapaSDK $value1 -UnitName 'Value2' -UnitType 'Value3' -Label 'Value4'
	
	.NOTES
		Additional information about the function.
#>
function Set-CapaUnitLabel {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType,
		[Parameter(Mandatory = $true)]
		[string]$Label
	)
	
	$value = $CapaSDK.SetUnitLabel($UnitName, $UnitType, $Label)
	
	return $value
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247648/Remove+unit+from+business+unit
	
	.DESCRIPTION
		A detailed description of the Remove-CapaUnitFromBusinessUnit function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.EXAMPLE
		PS C:\> Remove-CapaUnitFromBusinessUnit -CapaSDK $value1 -UnitName 'Value2' -UnitType 'Value3'
	
	.NOTES
		Additional information about the function.
#>
function Remove-CapaUnitFromBusinessUnit {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)
	
	$value = $CapaSDK.RemoveUnitFromBusinessUnit($UnitName, $UnitType)
	
	return $value
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247294/Add+unit+to+business+unit
	
	.DESCRIPTION
		A detailed description of the Add-CapaUnitToBusinessUnit function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.PARAMETER BusinessUnit
		A description of the BusinessUnit parameter.
	
	.EXAMPLE
				PS C:\> Add-CapaUnitToBusinessUnit -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer -BusinessUnit 'Value4'
	
	.NOTES
		Additional information about the function.
#>
function Add-CapaUnitToBusinessUnit {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType,
		[Parameter(Mandatory = $true)]
		[string]$BusinessUnit
	)
	
	$value = $CapaSDK.AddUnitToBusinessUnit($UnitName, $UnitType, $BusinessUnit)
	
	return $value
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247318/Add+unit+to+group
	
	.DESCRIPTION
		A detailed description of the Add-CapaUnitToGroup function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.PARAMETER GroupName
		A description of the GroupName parameter.
	
	.PARAMETER GroupType
		A description of the GroupType parameter.
	
	.EXAMPLE
				PS C:\> Add-CapaUnitToGroup -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer -GroupName 'Value4' -GroupType Calendar
	
	.NOTES
		Additional information about the function.
#>
function Add-CapaUnitToGroup {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User', 'Printer')]
		[string]$UnitType,
		[Parameter(Mandatory = $true)]
		[string]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Calendar', 'Department', 'Reinstall', 'Security', 'Static', 'Dynamic_SQL', 'Dynamic_ADSI')]
		[string]$GroupType
	)
	
	if ($GroupType -eq 'Dynamic_SQL' -and $UnitType -eq 'Printer' -or $GroupType -eq 'Dynamic_ADSI' -and $UnitType -eq 'Printer') {
		Write-Host "GroupType $GroupType only works for UnitType Printer"
		return 'False'
	} else {
		$value = $CapaSDK.AddUnitToGroup($UnitName, $UnitType, $GroupName, $GroupType)
		
		return $value
	}
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247482/Get+unit+groups
	
	.DESCRIPTION
		A detailed description of the Get-CapaUnitGroups function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaUnitGroups -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitGroups {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetUnitGroups($UnitName, $UnitType)
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name        = $aItem[0];
			Type        = $aItem[1];
			unitTypeID  = $aItem[2];
			Description = $aItem[3];
			GUID        = $aItem[4];
			ID          = $aItem[5]
		}
	}
	
	Return $oaUnits
}


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
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246290/Get+groups+on+Business+Unit
	
	.DESCRIPTION
		A detailed description of the Get-CapaGroupsInBusinessUnit function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER BusinessUnit
		A description of the BusinessUnit parameter.
	
	.PARAMETER Type
		A description of the Type parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaGroupsInBusinessUnit -CapaSDK $value1 -BusinessUnit 'Value2'
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaGroupsInBusinessUnit {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$BusinessUnit,
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Security', 'Static')]
		[string]$Type = ''
	)
	
	$oaUnits = @()
	
	If ($Type -eq '') {
		$aUnits = $CapaSDK.GetGroupsInBusinessUnit($BusinessUnit)
	} Else {
		$aUnits = $CapaSDK.GetGroupsInBusinessUnit($BusinessUnit, $Type)
	}
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name        = $aItem[0];
			Type        = $aItem[1];
			unitTypeID  = $aItem[2];
			Description = $aItem[3];
			GUID        = $aItem[4];
			ID          = $aItem[5]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247592/Get+units+on+business+unit
	
	.DESCRIPTION
		A detailed description of the Get-CapaUnitsOnBusinessUnit function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER BusinessUnit
		A description of the BusinessUnit parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaUnitsOnBusinessUnit -CapaSDK $value1 -BusinessUnit 'Value2'
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitsOnBusinessUnit {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$BusinessUnit,
		[ValidateSet('Computer', 'User')]
		[string]$UnitType = ''
	)
	
	$oaUnits = @()
	
	if ($UnitType -eq '') {
		$aUnits = $CapaSDK.GetUnitsOnBusinessUnit($BusinessUnit)
	} Else {
		$aUnits = $CapaSDK.GetUnitsOnBusinessUnit($BusinessUnit, $UnitType)
	}
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name           = $aItem[0];
			Created        = $aItem[1];
			LastExecuted   = $aItem[2];
			Status         = $aItem[3];
			Description    = $aItem[4];
			GUID           = $aItem[5];
			ID             = $aItem[6];
			TypeName       = $aItem[7];
			UUID           = $aItem[8];
			IsMobileDevice = $aItem[9];
			Location       = $aItem[10]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246232/Create+group+in+Business+Unit
	
	.DESCRIPTION
		A detailed description of the Create-CapaGroupInBusinessUnit function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER GroupName
		A description of the GroupName parameter.
	
	.PARAMETER GroupType
		A description of the GroupType parameter.
	
	.PARAMETER UnitType
		A description of the UnitType  parameter.
	
	.PARAMETER BusinessUnit
		A description of the BusinessUnit parameter.
	
	.EXAMPLE
				PS C:\> Create-CapaGroupInBusinessUnit -CapaSDK $value1 -GroupName 'Value2' -GroupType Calendar -UnitType  'Value4' -BusinessUnit 'Value5'
	
	.NOTES
		Additional information about the function.
#>
function Create-CapaGroupInBusinessUnit {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Calendar', 'Department', 'Static')]
		[string]$GroupType,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType,
		[Parameter(Mandatory = $true)]
		[string]$BusinessUnit
	)
	
	$value = $CapaSDK.CreateGroupInBusinessUnit($GroupName, $GroupType, $UnitType, $BusinessUnit)
	
	return $value
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246124/Get+dll+version
	
	.DESCRIPTION
		A detailed description of the Get-CapaDllVersion function.
	
	.EXAMPLE
				PS C:\> Get-CapaDllVersion
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaDllVersion {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$value = $CapaSDK.GetDLLVersion()
	return $value
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246132/Get+schedule
	
	.DESCRIPTION
		A detailed description of the Get-CapaSchedule function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER Id
		A description of the Id parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaSchedule -CapaSDK $value1 -Id 'Value2'
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaSchedule {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$Id
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetSchedule($Id)
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split('|')
		$oaUnits += [pscustomobject]@{
			Id                = $aItem[0];
			ScheduleStart     = $aItem[1];
			ScheduleEnd       = $aItem[2];
			Occurrences       = $aItem[3];
			IntervalStart     = $aItem[4];
			IntervalEnd       = $aItem[5];
			Recurrence        = $aItem[6];
			RecurrencePattern = $aItem[7];
			Run               = $aItem[8];
			LastRun           = $aItem[9];
			Active            = $aItem[10];
			WOL               = $aItem[11];
			Guid              = $aItem[12]
		}
	}
	
	Return $oaUnits
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246216/Create+AD+group
	
	.DESCRIPTION
		A detailed description of the Create-CapaADGroup function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER GroupName
		A description of the GroupName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.PARAMETER LDAPPath
		A description of the LDAPPath parameter.
	
	.PARAMETER recursive
		A description of the recursive parameter.
	
	.EXAMPLE
				PS C:\> Create-CapaADGroup -CapaSDK $value1 -GroupName 'Value2' -UnitType Computer -LDAPPath 'Value4' -recursive 'Value5'
	
	.NOTES
		Additional information about the function.
#>
function Create-CapaADGroup {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[String]$LDAPPath,
		[Parameter(Mandatory = $true)]
		[String]$recursive
	)
	
	$value = $CapaSDK.CreateADGroup($GroupName, $UnitType, $LDAPPath, $recursive)
	return $value
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246248/Delete+Group+in+Business+Unit
	
	.DESCRIPTION
		A detailed description of the Remove-CapaGroupInBusinessUnit function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER GroupName
		A description of the GroupName parameter.
	
	.PARAMETER GroupType
		A description of the GroupType parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.PARAMETER BusinessUnit
		A description of the BusinessUnit parameter.
	
	.EXAMPLE
				PS C:\> Remove-CapaGroupInBusinessUnit -CapaSDK $value1 -GroupName 'Value2' -GroupType Calendar -UnitType Computer -BusinessUnit 'Value5'
	
	.NOTES
		Additional information about the function.
#>
function Remove-CapaGroupInBusinessUnit {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Calendar', 'Department', 'Static')]
		[String]$GroupType,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[String]$BusinessUnit
	)
	
	$value = $CapaSDK.DeleteGroupInBusinessUnit($GroupName, $GroupType, $UnitType, $BusinessUnit)
	return $value
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246256/Get+application+groups
	
	.DESCRIPTION
		A detailed description of the Get-CapaApplicationGroups function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaApplicationGroups -CapaSDK $value1
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaApplicationGroups {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetApplicationGroups()
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split('|')
		$oaUnits += [pscustomobject]@{
			Id          = $aItem[0];
			Name        = $aItem[1];
			Version     = $aItem[2];
			Vendor      = $aItem[3];
			AppCode     = $aItem[4];
			Description = $aItem[5];
			GUID        = $aItem[6]
		}
	}
	
	Return $oaUnits
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246264/Get+Group+Description
	
	.DESCRIPTION
		A detailed description of the Get-CapaGroupDescription function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER GroupName
		A description of the GroupName parameter.
	
	.PARAMETER GroupType
		A description of the GroupType parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaGroupDescription -CapaSDK $value1 -GroupName 'Value2' -GroupType Dynamic_ADSI
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaGroupDescription {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Security', 'Static')]
		[String]$GroupType
	)
	
	$value = $CapaSDK.GetGroupDescription($GroupName, $GroupType)
	return $value
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246272/Get+Group+Folder
	
	.DESCRIPTION
		A detailed description of the Get-CapaGroupFolder function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER GroupName
		A description of the GroupName parameter.
	
	.PARAMETER GroupType
		A description of the GroupType parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.EXAMPLE
		PS C:\> Get-CapaGroupFolder -CapaSDK $value1 -GroupName 'Value2' -GroupType Dynamic_ADSI
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaGroupFolder {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Department', 'Dynamic_SQL', 'Static')]
		[String]$GroupType,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)
	
	$value = $CapaSDK.GetGroupFolder($GroupName, $GroupType, $UnitType)
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246310/Set+Group+Description
	
	.DESCRIPTION
		A detailed description of the Set-CapaGroupDescription function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER GroupName
		A description of the GroupName parameter.
	
	.PARAMETER GroupType
		A description of the GroupType parameter.
	
	.PARAMETER Description
		A description of the Description parameter.
	
	.EXAMPLE
				PS C:\> Set-CapaGroupDescription -CapaSDK $value1 -GroupName 'Value2' -GroupType Dynamic_ADSI
	
	.NOTES
		Additional information about the function.
#>
function Set-CapaGroupDescription {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Security', 'Static')]
		[String]$GroupType,
		[Parameter(Mandatory = $false)]
		[String]$Description = ''
	)
	
	$value = $CapaSDK.SetGroupDescription($GroupName, $GroupType, $Description)
	return $value
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246318/Set+Group+Folder
	
	.DESCRIPTION
		A detailed description of the Set-CapaGroupFolder function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER GroupName
		A description of the GroupName parameter.
	
	.PARAMETER GroupType
		A description of the GroupType parameter.
	
	.PARAMETER FolderStructure
		A description of the FolderStructure  parameter.
	
	.EXAMPLE
				PS C:\> Set-CapaGroupFolder -CapaSDK $value1 -GroupName $value2 -GroupType Dynamic_ADSI -FolderStructure  $value4
	
	.NOTES
		Additional information about the function.
#>
function Set-CapaGroupFolder {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Department', 'Dynamic_SQL', 'Static')]
		$GroupType,
		[Parameter(Mandatory = $true)]
		$FolderStructure
	)
	
	$value = $CapaSDK.SetGroupFolder($GroupName, $GroupType, $FolderStructure)
	return $value
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246326/Set+Group+folder+in+a+Business+Unit
	
	.DESCRIPTION
		A detailed description of the Set-CapaGroupFolderInABusinessUnit function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER GroupName
		A description of the GroupName parameter.
	
	.PARAMETER GroupType
		A description of the GroupType parameter.
	
	.PARAMETER FolderStructure
		A description of the FolderStructure  parameter.
	
	.PARAMETER BusinessunitName
		A description of the BusinessunitName parameter.
	
	.EXAMPLE
				PS C:\> Set-CapaGroupFolderInABusinessUnit -CapaSDK 'Value1' -GroupName 'Value2' -GroupType Dynamic_ADSI -FolderStructure  'Value4' -BusinessunitName 'Value5'
	
	.NOTES
		Additional information about the function.
#>
function Set-CapaGroupFolderInABusinessUnit {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		[String]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Department', 'Dynamic_SQL', 'Static')]
		[String]$GroupType,
		[Parameter(Mandatory = $true)]
		[String]$FolderStructure,
		[Parameter(Mandatory = $true)]
		[string]$BusinessunitName
	)
	
	$value = $CapaSDK.SetGroupFolderBU($GroupName, $GroupType, $FolderStructure, $BusinessunitName)
	return $value
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246388/Get+metering+groups
	
	.DESCRIPTION
		A detailed description of the Get-CapaMeteringGroups function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaMeteringGroups -CapaSDK $value1
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaMeteringGroups
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetMeteringGroups()
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split('|')
		$oaUnits += [pscustomobject]@{
			Name		    = $aItem[0];
			Version	    = $aItem[1];
			Vendor	    = $aItem[2];
			AppCode	    = $aItem[3];
			Description	    = $aItem[4];
			MeteringModule = $aItem[5];
			GUID		   = $aItem[6];
			ID = $aItem[7]
		}
	}
	
	Return $oaUnits
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246408/Get+update+inventory+for+unit
	
	.DESCRIPTION
		A detailed description of the Get-CapaUpdateInventoryForUnit function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaUpdateInventoryForUnit -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaUpdateInventoryForUnit
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
	
	$aUnits = $CapaSDK.GetUpdateInventoryForUnit($UnitName, $UnitType)
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split('|')
		$oaUnits += [pscustomobject]@{
			Qfename		   = $aItem[0];
			InstallDate	       = $aItem[1];
			UpdateID		   = $aItem[2];
			UpdateName	       = $aItem[3];
			Revision    = $aItem[4];
			InstallCount = $aItem[5];
			Status		   = $aItem[6]
		}
	}
	
	Return $oaUnits
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246418/Get+User+Inventory
	
	.DESCRIPTION
		A detailed description of the Get-CapaUserInventory function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UserName
		A description of the UserName parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaUserInventory -CapaSDK $value1 -UserName $value2
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaUserInventory
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		$UserName
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetUserInventory($UserName)
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split('|')
		$oaUnits += [pscustomobject]@{
			Category	     = $aItem[0];
			Entry  = $aItem[1];
			Value	 = $aItem[2];
			Datatype   = $aItem[3];
			GUID	 = $aItem[4];
			ID = $aItem[5]
		}
	}
	
	Return $oaUnits
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246428/GetCustomInventoryCategoriesAndEntries
	
	.DESCRIPTION
		A detailed description of the Get-CapaCustomInventoryCategoriesAndEntries function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaCustomInventoryCategoriesAndEntries -CapaSDK $value1
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaCustomInventoryCategoriesAndEntries
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetUserInventory($UserName)
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split('|')
		
		$Datatype = Convert-CapaDataType -Datatype $aItem [2]
		
		$oaUnits += [pscustomobject]@{
			Category = $aItem[0];
			Entry    = $aItem[1];
			Datatype    = $Datatype
		}
	}
	
	Return $oaUnits
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246438/Set+custom+inventory
	
	.DESCRIPTION
		A detailed description of the Set-CapaCustomInventory function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.PARAMETER Uuid
		A description of the Uuid  parameter.
	
	.PARAMETER Section
		A description of the Section parameter.
	
	.PARAMETER Name
		A description of the Name  parameter.
	
	.PARAMETER Value
		A description of the Value  parameter.
	
	.PARAMETER DataType
		A description of the DataType  parameter.
	
	.EXAMPLE
		PS C:\> Set-CapaCustomInventory
	
	.NOTES
		Additional information about the function.
#>
function Set-CapaCustomInventory
{
	[CmdletBinding(DefaultParameterSetName = 'NameType')]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(ParameterSetName = 'NameType',
		           Mandatory = $true)]
		[String]
		$UnitName,
		[Parameter(ParameterSetName = 'NameType',
		           Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[String]
		$UnitType,
		[Parameter(ParameterSetName = 'Uuid',
		           Mandatory = $true)]
		[String]
		$Uuid,
		[Parameter(Mandatory = $true)]
		[String]
		$Section,
		[Parameter(Mandatory = $true)]
		[String]
		$Name,
		[Parameter(Mandatory = $true)]
		[String]
		$Value,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Integer', 'Time', 'String', 'Text', 'I', 'T', 'S', 'N')]
		[String]
		$DataType
	)
	
	switch ($UnitType) {
		"Computer" {
			$UnitType = "1"
		}
		"User" {
			$UnitType = "2"
		}
		default {}
	}
	
	switch ($DataType) {
		"Integer" {
			$DataType = "I"
		}
		"Time" {
			$DataType = "T"
		}
		"String" {
			$DataType = "S"
		}
		"Text"{
			$DataType = "N"
		}
		default {}
	}
	
	if ($PSCmdlet.ParameterSetName -eq "NameType")
	{
		$value = $CapaSDK.SetCustomInventory($UnitName, $UnitType, $Section, $Name, $Value, $DataType)
	}
	Else
	{
		$value = $CapaSDK.SetCustomInventoryUUID($Uuid, $Section, $Name, $Value, $DataType)
	}
	
	return $value
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246438/Set+custom+inventory
	
	.DESCRIPTION
		A detailed description of the Set-CapaSetCustomInventory function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.EXAMPLE
				PS C:\> Set-CapaSetCustomInventory
	
	.NOTES
		Additional information about the function.
#>
function Set-CapaHardwareInventory
{
	[CmdletBinding(DefaultParameterSetName = 'NameType')]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(ParameterSetName = 'NameType',
				   Mandatory = $true)]
		[String]$UnitName,
		[Parameter(ParameterSetName = 'NameType',
				   Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[String]$UnitType,
		[Parameter(ParameterSetName = 'Uuid',
				   Mandatory = $true)]
		[String]$Uuid,
		[Parameter(Mandatory = $true)]
		[String]$Section,
		[Parameter(Mandatory = $true)]
		[String]$Name,
		[Parameter(Mandatory = $true)]
		[String]$Value,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Integer', 'Time', 'String', 'Text', 'I', 'T', 'S', 'N')]
		[String]$DataType
	)
	
	switch ($UnitType)
	{
		"Computer" {
			$UnitType = "1"
		}
		"User" {
			$UnitType = "2"
		}
		default { }
	}
	
	switch ($DataType)
	{
		"Integer" {
			$DataType = "I"
		}
		"Time" {
			$DataType = "T"
		}
		"String" {
			$DataType = "S"
		}
		"Text"{
			$DataType = "N"
		}
		default { }
	}
	
	if ($PSCmdlet.ParameterSetName -eq "NameType")
	{
		$value = $CapaSDK.SetHardwareInventory($UnitName, $UnitType, $Section, $Name, $Value, $DataType)
	}
	Else
	{
		$value = $CapaSDK.SetHardwareInventoryUUID($Uuid, $Section, $Name, $Value, $DataType)
	}
	
	return $value
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246463/Link+profile+to+device
	
	.DESCRIPTION
		A detailed description of the Add-CapaUnitToProfile function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER Uuid
		A description of the Uuid parameter.
	
	.PARAMETER ProfileName
		A description of the ProfileName parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment  parameter.
	
	.EXAMPLE
				PS C:\> Add-CapaUnitToProfile -Uuid 'Value1'
	
	.NOTES
		Additional information about the function.
#>
function Add-CapaUnitToProfile
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(ParameterSetName = 'NameType',
				   Mandatory = $true)]
		[String]$UnitName,
		[Parameter(ParameterSetName = 'Uuid',
				   Mandatory = $true)]
		[String]$Uuid,
		[Parameter(Mandatory = $true)]
		[String]$ProfileName,
		[Parameter(Mandatory = $false)]
		[String]$ChangelogComment
	)
	
	switch ($PsCmdlet.ParameterSetName)
	{
		'Uuid' {
			$value = $CapaSDK.AddUnitToProfile($UnitName, $ProfileName, $ChangelogComment)
			break
		}
		'NameType' {
			$value = $CapaSDK.AddUnitToProfile($Uuid, $ProfileName, $ChangelogComment)
			break
		}
	}
	
	return $value
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246474/Unlink+profile+from+device
	
	.DESCRIPTION
		A detailed description of the Unlink-CapaUnitFromProfile function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER ProfileName
		A description of the ProfileName parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment parameter.
	
	.PARAMETER Uuid
		A description of the Uuid parameter.
	
	.EXAMPLE
				PS C:\> Unlink-CapaUnitFromProfile -Uuid 'Value1'
	
	.NOTES
		Additional information about the function.
#>
function Unlink-CapaUnitFromProfile
{
	[CmdletBinding(DefaultParameterSetName = 'Uuid')]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(ParameterSetName = 'NameType',
				   Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[String]$ProfileName,
		[Parameter(Mandatory = $true)]
		[String]$ChangelogComment,
		[Parameter(ParameterSetName = 'Uuid',
				   Mandatory = $true)]
		[String]$Uuid
	)
	
	switch ($PsCmdlet.ParameterSetName)
	{
		'NameType' {
			$value = $CapaSDK.UnlinkUnitFromProfile($UnitName, $ProfileName, $ChangelogComment)
			break
		}
		'Uuid' {
			$value = $CapaSDK.UnlinkUnitFromProfile($Uuid, $ProfileName, $ChangelogComment)
			break
		}
	}
	return $value
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246487/Remove+profile+from+device
	
	.DESCRIPTION
		A detailed description of the Remove-CapaProfileFromDevice function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UUID
		A description of the UUID  parameter.
	
	.PARAMETER ProfileName
		A description of the ProfileName parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment  parameter.
	
	.EXAMPLE
				PS C:\> Remove-CapaProfileFromDevice -UnitName 'Value1'
	
	.NOTES
		Additional information about the function.
#>
function Remove-CapaProfileFromDevice
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(ParameterSetName = 'NameType',
				   Mandatory = $true)]
		[String]$UnitName,
		[Parameter(ParameterSetName = 'Uuid',
				   Mandatory = $true)]
		[String]$UUID,
		[Parameter(Mandatory = $true)]
		[String]$ProfileName,
		[Parameter(Mandatory = $true)]
		[String]$ChangelogComment
	)
	
	switch ($PsCmdlet.ParameterSetName)
	{
		'NameType' {
			$value = $CapaSDK.RemoveUnitFromProfile($UnitName, $ProfileName, $ChangelogComment)
			break
		}
		'Uuid' {
			$value = $CapaSDK.RemoveUnitFromProfile($UUID, $ProfileName, $ChangelogComment)
			break
		}
	}
	return $value
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246500/Add+Exchange+Payload+to+Profile
	
	.DESCRIPTION
		A detailed description of the Add-CapaExchangePayloadToProfile function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER ProfileID
		A description of the ProfileID parameter.
	
	.PARAMETER AccountName
		A description of the AccountName  parameter.
	
	.PARAMETER DomainandUserName
		A description of the DomainandUserName parameter.
	
	.PARAMETER Password
		A description of the Password parameter.
	
	.PARAMETER EmailAddress
		A description of the EmailAddress parameter.
	
	.PARAMETER ExchangeActiveSyncHost
		A description of the ExchangeActiveSyncHost parameter.
	
	.PARAMETER UseSSL
		A description of the UseSSL parameter.
	
	.PARAMETER PastDaysofMailtoSync
		A description of the PastDaysofMailtoSync parameter.
	
	.PARAMETER AllowMove
		A description of the AllowMove parameter.
	
	.PARAMETER UseOnlyinMail
		A description of the UseOnlyinMail parameter.
	
	.PARAMETER UseSMIME
		A description of the UseSMIME parameter.
	
	.PARAMETER AllowRecentAddressSyncing
		A description of the AllowRecentAddressSyncing parameter.
	
	.PARAMETER Syncinterval
		A description of the Syncinterval parameter.
	
	.PARAMETER SyncEmail
		A description of the SyncEmail parameter.
	
	.PARAMETER SyncCalendar
		A description of the SyncCalendar parameter.
	
	.PARAMETER SyncContacts
		A description of the SyncContacts parameter.
	
	.PARAMETER SyncTasks
		A description of the SyncTasks parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment  parameter.
	
	.EXAMPLE
		PS C:\> Add-CapaExchangePayloadToProfile -CapaSDK $value1 -ProfileID $value2 -AccountName  'Value3' -DomainandUserName 'Value4' -Password $value5 -EmailAddress 'Value6' -ExchangeActiveSyncHost 'Value7' -UseSSL $value8
	
	.NOTES
		Additional information about the function.
#>
function Add-CapaExchangePayloadToProfile
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$ProfileID,
		[Parameter(Mandatory = $true)]
		[string]$AccountName,
		[Parameter(Mandatory = $true)]
		[string]$DomainandUserName,
		[Parameter(Mandatory = $false)]
		[securestring]$Password = "",
		[Parameter(Mandatory = $true)]
		[string]$EmailAddress,
		[Parameter(Mandatory = $true)]
		[string]$ExchangeActiveSyncHost,
		[Parameter(Mandatory = $true)]
		[ValidateSet('True', 'False')]
		[bool]$UseSSL,
		[Parameter(Mandatory = $false)]
		[ValidateSet('0', '1', '3', '7', '14', '31')]
		[int]$PastDaysofMailtoSync = 0,
		[ValidateSet('True', 'False')]
		[bool]$AllowMove = $false,
		[ValidateSet('True', 'False')]
		[bool]$UseOnlyinMail = $false,
		[ValidateSet('True', 'False')]
		[bool]$UseSMIME = $false,
		[ValidateSet('False', 'True')]
		[bool]$AllowRecentAddressSyncing = $false,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Automatic Push', 'Manually', '15 minutes', '30 minutes', '60 minutes')]
		[string]$Syncinterval,
		[ValidateSet('False', 'True')]
		[bool]$SyncEmail = $false,
		[ValidateSet('False', 'True')]
		[bool]$SyncCalendar = $false,
		[ValidateSet('False', 'True')]
		[bool]$SyncContacts = $false,
		[ValidateSet('False', 'True')]
		[bool]$SyncTasks = $false,
		[string]$ChangelogComment = ""
	)
	
	$value = $CapaSDK.AddExchangePayloadToProfile($ProfileID, $AccountName, $DomainandUserName, $Password, $EmailAddress, $ExchangeActiveSyncHost, $UseSSL, $PastDaysofMailtoSync, $AllowMove, $UseOnlyinMail, $UseSMIME, $AllowRecentAddressSyncing, $Syncinterval, $SyncEmail, $SyncCalendar, $SyncContacts, $SyncTasks, $ChangelogComment)
	return $value
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246510/Add+WiFi+Payload+to+Profile
	
	.DESCRIPTION
		A detailed description of the Add-CapaWifiPayloadToProfile function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER ProfileID
		A description of the ProfileID parameter.
	
	.PARAMETER NetworkName
		A description of the NetworkName parameter.
	
	.PARAMETER HiddenNetwork
		A description of the HiddenNetwork parameter.
	
	.PARAMETER AutoJoin
		A description of the AutoJoin parameter.
	
	.PARAMETER SecurityType
		A description of the SecurityType parameter.
	
	.PARAMETER Password
		A description of the Password parameter.
	
	.PARAMETER ProxyType
		A description of the ProxyType parameter.
	
	.PARAMETER ProxyServer
		A description of the ProxyServer parameter.
	
	.PARAMETER ProxyPort
		A description of the ProxyPort parameter.
	
	.PARAMETER ProxyAuthentication
		A description of the ProxyAuthentication parameter.
	
	.PARAMETER ProxyPassword
		A description of the ProxyPassword  parameter.
	
	.PARAMETER ProxyServerConfigURL
		A description of the ProxyServerConfigURL parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment parameter.
	
	.EXAMPLE
		PS C:\> Add-CapaWifiPayloadToProfile -CapaSDK $value1 -ProfileID $value2 -NetworkName 'Value3' -SecurityType None
	
	.NOTES
		Additional information about the function.
#>
function Add-CapaWifiPayloadToProfile
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$ProfileID,
		[Parameter(Mandatory = $true)]
		[string]$NetworkName,
		[ValidateSet('False', 'True')]
		[bool]$HiddenNetwork = $false,
		[ValidateSet('True', 'False')]
		[bool]$AutoJoin = $true,
		[Parameter(Mandatory = $true)]
		[ValidateSet('None', 'WEP', 'WPA', 'Any')]
		[string]$SecurityType,
		[string]$Password = "",
		[Parameter(Mandatory = $true)]
		[ValidateSet('Automatic', 'Manual', 'None')]
		[string]$ProxyType,
		[string]$ProxyServer = "",
		[string]$ProxyPort = "",
		[string]$ProxyAuthentication = "",
		[string]$ProxyPassword = "",
		[string]$ProxyServerConfigURL = "",
		[string]$ChangelogComment = ""
	)
	
	if ($Password -eq "" -and $SecurityType -ne "None")
	{
		Write-Error "Password cannot be NULL when choosing SecurityType: $SecurityType"
	}
	elseif ($ProxyType -eq "Manual" -and $ProxyServer -eq "")
	{
		Write-Error "ProxyServer cannot be NULL when choosing ProxyType: $ProxyType"
	}
	elseif ($ProxyType -eq "Manual" -and $ProxyPort -eq "")
	{
		Write-Error "ProxyPort cannot be NULL when choosing ProxyType: $ProxyType"
	}
	elseif ($ProxyType -eq "Manual" -and $ProxyAuthentication -eq "")
	{
		Write-Error "ProxyAuthentication cannot be NULL when choosing ProxyType: $ProxyType"
	}
	elseif ($ProxyType -eq "Manual" -and $ProxyPassword -eq "")
	{
		Write-Error "ProxyPassword cannot be NULL when choosing ProxyType: $ProxyType"
	}
	elseif ($ProxyType -eq "Automatic" -and $ProxyServerConfigURL -eq "")
	{
		Write-Error "ProxyServerConfigURL cannot be NULL when choosing ProxyType: $ProxyType"
	}
	Else
	{
		$value = $CapaSDK.AddWifiPayloadToProfile($ProfileID, $NetworkName, $HiddenNetwork, $AutoJoin, $SecurityType, $Password, $ProxyType, $ProxyType, $ProxyServer, $ProxyPort, $ProxyAuthentication, $ProxyPassword, $ProxyServerConfigURL, $ChangelogComment)
		return $value
	}
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246520/Add+edit+Enforce+Passcode+Android
	
	.DESCRIPTION
		A detailed description of the Add-CapaEnforcePasscodeAndroid function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER ProfileId
		A description of the ProfileId parameter.
	
	.PARAMETER Passcode
		A description of the Passcode  parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment parameter.
	
	.EXAMPLE
		PS C:\> Add-CapaEnforcePasscodeAndroid
	
	.NOTES
		Additional information about the function.
#>
function Add-CapaEnforcePasscodeAndroid
{
	[CmdletBinding()]
	[Alias("Edit-CapaEnforcePasscodeAndroid")]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$ProfileId,
		[Parameter(Mandatory = $true)]
		[string]$Passcode,
		$ChangelogComment = ""
	)
	
	$value = $CapaSDK.AddEditEnforcePasscodeAndroid($ProfileId, $Passcode, $ChangelogComment)
	return $value
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246531/Add+edit+Key+Value+setting+to+Android+AppConfig
	
	.DESCRIPTION
		A detailed description of the Add-KeyValueToAppConfigAndroid function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER DeviceApplicationID
		A description of the DeviceApplicationID  parameter.
	
	.PARAMETER Key
		A description of the Key parameter.
	
	.PARAMETER Value
		A description of the Value  parameter.
	
	.PARAMETER KeyValueType
		A description of the KeyValueType parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment parameter.
	
	.EXAMPLE
				PS C:\> Add-KeyValueToAppConfigAndroid -CapaSDK $value1 -DeviceApplicationID  $value2 -Key 'Value3' -Value  'Value4' -KeyValueType String
	
	.NOTES
		Additional information about the function.
#>
function Add-KeyValueToAppConfigAndroid
{
	[CmdletBinding()]
	[Alias("Edit-KeyValueToAppConfigAndroid")]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$DeviceApplicationID,
		[Parameter(Mandatory = $true)]
		[string]$Key,
		[Parameter(Mandatory = $true)]
		[string]$Value,
		[Parameter(Mandatory = $true)]
		[ValidateSet('String', 'Bool', 'Hidden', 'Integer')]
		$KeyValueType,
		$ChangelogComment = ""
	)
	
	$value = $CapaSDK.AddKeyValueToAppConfigAndroid($DeviceApplicationID, $Key, $Value, $KeyValueType, $ChangelogComment)
	return $value
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246542/Add+edit+Key+Value+setting+to+iOS+AppConfig
	
	.DESCRIPTION
		A detailed description of the Add-KeyValueToAppConfigIOS function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER DeviceApplicationID
		A description of the DeviceApplicationID  parameter.
	
	.PARAMETER Key
		A description of the Key  parameter.
	
	.PARAMETER Value
		A description of the Value  parameter.
	
	.PARAMETER KeyValueType
		A description of the KeyValueType parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment parameter.
	
	.EXAMPLE
		PS C:\> Add-KeyValueToAppConfigIOS
	
	.NOTES
		Additional information about the function.
#>
function Add-KeyValueToAppConfigIOS
{
	[CmdletBinding()]
	[Alias("Edit-KeyValueToAppConfigIOS")]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$DeviceApplicationID,
		[Parameter(Mandatory = $true)]
		[string]$Key,
		[Parameter(Mandatory = $true)]
		[string]$Value,
		[Parameter(Mandatory = $true)]
		[ValidateSet('String', 'Boolean', 'Int', 'Float', 'DateTime')]
		[string]$KeyValueType,
		[string]$ChangelogComment = ""
	)
	
	$value = $CapaSDK.AddKeyValueToAppConfigIOS($DeviceApplicationID, $Key, $Value, $KeyValueType, $ChangelogComment)
	return $value
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246552/Assign+Profile+to+Business+Unit
	
	.DESCRIPTION
		A detailed description of the Assign-CapaProfileToBusinessUnit function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER ProfileId
		A description of the ProfileId parameter.
	
	.PARAMETER BusinessUnitName
		A description of the BusinessUnitName parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment parameter.
	
	.EXAMPLE
				PS C:\> Assign-CapaProfileToBusinessUnit -CapaSDK $value1 -ProfileId $value2 -BusinessUnitName 'Value3'
	
	.NOTES
		Additional information about the function.
#>
function Assign-CapaProfileToBusinessUnit
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$ProfileId,
		[Parameter(Mandatory = $true)]
		[string]$BusinessUnitName,
		[string]$ChangelogComment = ""
	)
	
	$value = $CapaSDK.AssignProfileToBusinessUnit($ProfileId, $BusinessUnitName, $ChangelogComment)
	return $value
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246561/Clone+Device+Application
	
	.DESCRIPTION
		A detailed description of the Clone-CapaDeviceApplication function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER DeviceApplicationID
		A description of the DeviceApplicationID  parameter.
	
	.PARAMETER NewName
		A description of the NewName  parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment parameter.
	
	.EXAMPLE
				PS C:\> Clone-CapaDeviceApplication -CapaSDK $value1 -DeviceApplicationID  $value2 -NewName  'Value3'
	
	.NOTES
		Additional information about the function.
#>
function Clone-CapaDeviceApplication
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$DeviceApplicationID,
		[Parameter(Mandatory = $true)]
		[string]$NewName,
		[string]$ChangelogComment = ""
	)
	
	$value = $CapaSDK.CloneDeviceApplication($DeviceApplicationID, $NewName, $ChangelogComment)
	return $value
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246572/Create+Profile
	
	.DESCRIPTION
		A detailed description of the Create-CapaProfile function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER Name
		A description of the Name parameter.
	
	.PARAMETER Description
		A description of the Description parameter.
	
	.PARAMETER Priority
		A description of the Priority parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment parameter.
	
	.EXAMPLE
				PS C:\> Create-CapaProfile -CapaSDK $value1 -Name 'Value2' -Description 'Value3' -Priority $value4
	
	.NOTES
		Additional information about the function.
#>
function Create-CapaProfile
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$Name,
		[Parameter(Mandatory = $true)]
		[string]$Description,
		[Parameter(Mandatory = $true)]
		[int]$Priority,
		[string]$ChangelogComment = "",
		[string]$BusinessUnitId = ""
	)
	
	if ($BusinessUnitId -eq "")
	{
		$value = $CapaSDK.CreateProfile($Name, $Description, $Priority, $ChangelogComment)
	}
	else
	{
		$value = $CapaSDK.CreateProfileInBusinessUnit($Name, $Description, $Priority, $ChangelogComment, $BusinessUnitId)
	}
	
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246594/Edit+Exchange+Payload
	
	.DESCRIPTION
		A detailed description of the Edit-ExchangePayload function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER ProfileID
		A description of the ProfileID parameter.
	
	.PARAMETER CurrentAccountName
		A description of the CurrentAccountName parameter.
	
	.PARAMETER AccountName
		A description of the AccountName parameter.
	
	.PARAMETER DomainandUserName
		A description of the DomainandUserName parameter.
	
	.PARAMETER Password
		A description of the Password parameter.
	
	.PARAMETER EmailAddress
		A description of the EmailAddress parameter.
	
	.PARAMETER ExchangeActiveSyncHost
		A description of the ExchangeActiveSyncHost parameter.
	
	.PARAMETER UseSSL
		A description of the UseSSL parameter.
	
	.PARAMETER PastDaysofMailtoSync
		A description of the PastDaysofMailtoSync parameter.
	
	.PARAMETER AllowMove
		A description of the AllowMove parameter.
	
	.PARAMETER UseOnlyinMail
		A description of the UseOnlyinMail parameter.
	
	.PARAMETER UseSMIME
		A description of the UseSMIME parameter.
	
	.PARAMETER AllowRecentAddressSyncing
		A description of the AllowRecentAddressSyncing parameter.
	
	.PARAMETER Syncinterval
		A description of the Syncinterval parameter.
	
	.PARAMETER SyncEmail
		A description of the SyncEmail parameter.
	
	.PARAMETER SyncContacts
		A description of the SyncContacts parameter.
	
	.PARAMETER SyncTasks
		A description of the SyncTasks parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment parameter.
	
	.EXAMPLE
				PS C:\> Edit-ExchangePayload -CapaSDK $value1 -ProfileID $value2 -CurrentAccountName 'Value3' -AccountName 'Value4' -DomainandUserName 'Value5' -EmailAddress 'Value6' -ExchangeActiveSyncHost 'Value7' -UseSSL True -Syncinterval 'Automatic Push'
	
	.NOTES
		Additional information about the function.
#>
function Edit-ExchangePayload
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$ProfileID,
		[Parameter(Mandatory = $true)]
		[string]$CurrentAccountName,
		[Parameter(Mandatory = $true)]
		[string]$AccountName,
		[Parameter(Mandatory = $true)]
		[string]$DomainandUserName,
		[Parameter(Mandatory = $false)]
		[securestring]$Password = "",
		[Parameter(Mandatory = $true)]
		[string]$EmailAddress,
		[Parameter(Mandatory = $true)]
		[string]$ExchangeActiveSyncHost,
		[Parameter(Mandatory = $true)]
		[ValidateSet('True', 'False')]
		[bool]$UseSSL,
		[Parameter(Mandatory = $false)]
		[ValidateSet('0', '1', '3', '7', '14', '31')]
		[int]$PastDaysofMailtoSync = 0,
		[ValidateSet('True', 'False')]
		[bool]$AllowMove = $false,
		[ValidateSet('True', 'False')]
		[bool]$UseOnlyinMail = $false,
		[ValidateSet('True', 'False')]
		[bool]$UseSMIME = $false,
		[ValidateSet('False', 'True')]
		[bool]$AllowRecentAddressSyncing = $false,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Automatic Push', 'Manually', '15 minutes', '30 minutes', '60 minutes')]
		[string]$Syncinterval,
		[ValidateSet('False', 'True')]
		[bool]$SyncEmail = $false,
		[ValidateSet('False', 'True')]
		[bool]$SyncContacts = $false,
		[ValidateSet('False', 'True')]
		[bool]$SyncTasks = $false,
		[string]$ChangelogComment = ""
	)
	
	$value = $CapaSDK.EditExchangePayload($ProfileID, $CurrentAccountName, $AccountName, $DomainandUserName, $Password, $EmailAddress, $ExchangeActiveSyncHost, $UseSSL, $PastDaysofMailtoSync, $AllowMove, $UseOnlyinMail, $UseSMIME, $AllowRecentAddressSyncing, $Syncinterval, $SyncEmail, $SyncContacts, $SyncTasks, $ChangelogComment)
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246604/Edit+WiFi+Payload
	
	.DESCRIPTION
		A detailed description of the Edit-CapaWifiPayload function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER ProfileID
		A description of the ProfileID parameter.
	
	.PARAMETER NetworkName
		A description of the NetworkName parameter.
	
	.PARAMETER HiddenNetwork
		A description of the HiddenNetwork parameter.
	
	.PARAMETER AutoJoin
		A description of the AutoJoin parameter.
	
	.PARAMETER SecurityType
		A description of the SecurityType parameter.
	
	.PARAMETER Password
		A description of the Password parameter.
	
	.PARAMETER ProxyType
		A description of the ProxyType parameter.
	
	.PARAMETER ProxyServer
		A description of the ProxyServer parameter.
	
	.PARAMETER ProxyPort
		A description of the ProxyPort parameter.
	
	.PARAMETER ProxyAuthentication
		A description of the ProxyAuthentication parameter.
	
	.PARAMETER ProxyPassword
		A description of the ProxyPassword parameter.
	
	.PARAMETER ProxyServerConfigURL
		A description of the ProxyServerConfigURL parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment parameter.
	
	.EXAMPLE
				PS C:\> Edit-CapaWifiPayload -CapaSDK $value1 -ProfileID $value2 -NetworkName 'Value3' -SecurityType None -ProxyType Automatic
	
	.NOTES
		Additional information about the function.
#>
function Edit-CapaWifiPayload
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$ProfileID,
		[Parameter(Mandatory = $true)]
		[string]$CurrentNetworkName,
		[Parameter(Mandatory = $true)]
		[string]$NetworkName,
		[ValidateSet('False', 'True')]
		[bool]$HiddenNetwork = $false,
		[ValidateSet('True', 'False')]
		[bool]$AutoJoin = $true,
		[Parameter(Mandatory = $true)]
		[ValidateSet('None', 'WEP', 'WPA', 'Any')]
		[string]$SecurityType,
		[string]$Password = "",
		[Parameter(Mandatory = $true)]
		[ValidateSet('Automatic', 'Manual', 'None')]
		[string]$ProxyType,
		[string]$ProxyServer = "",
		[string]$ProxyPort = "",
		[string]$ProxyAuthentication = "",
		[string]$ProxyPassword = "",
		[string]$ProxyServerConfigURL = "",
		[string]$ChangelogComment = ""
	)
	
	if ($Password -eq "" -and $SecurityType -ne "None")
	{
		Write-Error "Password cannot be NULL when choosing SecurityType: $SecurityType"
	}
	elseif ($ProxyType -eq "Manual" -and $ProxyServer -eq "")
	{
		Write-Error "ProxyServer cannot be NULL when choosing ProxyType: $ProxyType"
	}
	elseif ($ProxyType -eq "Manual" -and $ProxyPort -eq "")
	{
		Write-Error "ProxyPort cannot be NULL when choosing ProxyType: $ProxyType"
	}
	elseif ($ProxyType -eq "Manual" -and $ProxyAuthentication -eq "")
	{
		Write-Error "ProxyAuthentication cannot be NULL when choosing ProxyType: $ProxyType"
	}
	elseif ($ProxyType -eq "Manual" -and $ProxyPassword -eq "")
	{
		Write-Error "ProxyPassword cannot be NULL when choosing ProxyType: $ProxyType"
	}
	elseif ($ProxyType -eq "Automatic" -and $ProxyServerConfigURL -eq "")
	{
		Write-Error "ProxyServerConfigURL cannot be NULL when choosing ProxyType: $ProxyType"
	}
	Else
	{
		$value = $CapaSDK.EditWifiPayload($ProfileID, $CurrentNetworkName, $NetworkName, $HiddenNetwork, $AutoJoin, $SecurityType, $Password, $ProxyType, $ProxyType, $ProxyServer, $ProxyPort, $ProxyAuthentication, $ProxyPassword, $ProxyServerConfigURL, $ChangelogComment)
		return $value
	}
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246614/Get+Device+Applications
	
	.DESCRIPTION
		A detailed description of the Get-CapaDeviceApplications function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaDeviceApplications -CapaSDK $value1
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaDeviceApplications
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetDeviceApplications()
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split('|')
		$oaUnits += [pscustomobject]@{
			ID = $aItem[0];
			Name    = $aItem[1];
			Description    = $aItem[2];
			Priority = $aItem[3];
			Version	 = $aItem[4];
			CMPID	     = $aItem[5];
			GUID	    = $aItem[6]
		}
	}
	
	Return $oaUnits
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246626/Get+Profiles
	
	.DESCRIPTION
		A detailed description of the Get-CapaProfiles function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaProfiles -CapaSDK $value1
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaProfiles
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetDeviceApplications()
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split('|')
		$oaUnits += [pscustomobject]@{
			ID		    = $aItem[0];
			Name	    = $aItem[1];
			Description = $aItem[2];
			Priority    = $aItem[3];
			Version	    = $aItem[4];
			CMPID	    = $aItem[5];
			GUID	    = $aItem[6]
		}
	}
	
	Return $oaUnits
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246638/Link+profile+to+group
	
	.DESCRIPTION
		A detailed description of the Link-CapaProfileToGroup function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER ProfileId
		A description of the ProfileId parameter.
	
	.PARAMETER GroupName
		A description of the GroupName parameter.
	
	.PARAMETER GroupType
		A description of the GroupType parameter.
	
	.PARAMETER BusinessUnitName
		A description of the BusinessUnitName parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment parameter.
	
	.EXAMPLE
				PS C:\> Link-CapaProfileToGroup -CapaSDK $value1 -ProfileId $value2 -GroupName 'Value3' -GroupType AD
	
	.NOTES
		Additional information about the function.
#>
function Link-CapaProfileToGroup
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$ProfileId,
		[Parameter(Mandatory = $true)]
		[string]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('AD', 'Department', 'Dynamic', 'Static')]
		[string]$GroupType,
		[string]$BusinessUnitName = "",
		[string]$ChangelogComment = ""
	)
	
	#TODO: Place script here
}
