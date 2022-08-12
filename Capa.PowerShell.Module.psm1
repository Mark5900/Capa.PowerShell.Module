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
function Get-CapaPackages
{
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $false)]
		[ValidateSet('Computer', 'User')]
		[string]$Type = ""
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetPackages($Type)
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split("|")
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
function Get-CapaGroups
{
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $false)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Security', 'Static')]
		[string]$Type = ""
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetGroups($Type)
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split("|")
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
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246910/Get+group+packages
	
	.DESCRIPTION
		A detailed description of the Get-CapaGroupPackages function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER GroupName
		A description of the GroupName parameter.
	
	.PARAMETER Type
		A description of the Type parameter.
	
	.EXAMPLE
		PS C:\> Get-CapaGroupPackages -CapaSDK $CapaSDK -GroupName $GroupName -Type Dynamic_ADSI
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaGroupPackages
{
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Security', 'Static')]
		[string]$Type
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetGroupPackages($GroupName, $Type)
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split("|")
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
		[string]$Type,
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion
	)
	
	$aUnits = $CapaSDK.GetPackageFolder($PackageName, $PackageVersion, $Type)
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
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247572/Get+units
	
	.DESCRIPTION
		A detailed description of the Get-CapaUnits function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER Type
		A description of the Type parameter.
	
	.EXAMPLE
		PS C:\> Get-CapaUnits -CapaSDK $CapaSDK -Type Computer
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaUnits
{
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$Type
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetUnits($Type)
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split("|")
		$oaUnits += [pscustomobject]@{
			Name		   = $aItem[0];
			Created	       = $aItem[1];
			LastExecuted   = $aItem[2];
			Status		   = $aItem[3];
			Description    = $aItem[4];
			GUID		   = $aItem[5];
			ID			   = $aItem[6];
			TypeName	   = $aItem[7];
			UUID		   = $aItem[8];
			IsMobileDevice = $aItem[9];
			location	   = $aItem[10]
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
		[string]$Name,
		[Parameter(Mandatory = $true)]
		[string]$Version,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$Type
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetUnits($Type)
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split("|")
		$oaUnits += [pscustomobject]@{
			Name		   = $aItem[0];
			Created	       = $aItem[1];
			LastExecuted   = $aItem[2];
			Status		   = $aItem[3];
			Description    = $aItem[4];
			GUID		   = $aItem[5];
			ID			   = $aItem[6];
			TypeName	   = $aItem[7];
			UUID		   = $aItem[8];
			IsMobileDevice = $aItem[9];
			location	   = $aItem[10]
		}
	}
	
	Return $oaUnits
}

<#
    Custom functions to things Capa SDK does not cotain
#>
<#
	.SYNOPSIS
		A brief description of the Get-CapaPackagesGroups function.
	
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
function Get-CapaPackagesGroups
{
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $false)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Security', 'Static')]
		[string]$GroupType = "",
		[Parameter(Mandatory = $false)]
		[ValidateSet('Computer', 'User')]
		[string]$PackageType = ""
	)
	
	$oaUnits = Get-CapaPackages -CapaSDK $CapaSDK -Type $PackageType
	$oaUnits | Add-Member -NotePropertyName LinkedGroups -NotePropertyValue ""
	
	$AllGroups = Get-CapaGroups -CapaSDK $CapaSDK -Type $GroupType
	foreach ($Group in $AllGroups)
	{
		if ($Group.Type -ne "Catalog" -and $Group.Type -ne "PowerScheme")
		{
			$AllGroupPackages = Get-CapaGroupPackages -CapaSDK $CapaSDK -GroupName $Group.Name -Type $Group.Type
			foreach ($Package in $AllGroupPackages)
			{
				$CurrentPCK = $oaUnits | Where-Object { $_.Name -eq $Package.Name -and $_.Version -eq $Package.Version }
				If ($CurrentPCK.LinkedGroups -eq "")
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
function Initialize-CapaSDK
{
	[CmdletBinding()]
	param
	(
		[string]$CapaSdkDllPath = "",
		[Parameter(Mandatory = $true)]
		[string]$Server,
		[Parameter(Mandatory = $true)]
		[string]$Database = "",
		[string]$UserName = "",
		[string]$Password = "",
		[Parameter(Mandatory = $true)]
		[string]$DefaultManagementPoint,
		[string]$InstanceManagementPoint
	)
	
	$CapaSDKDllName = "CapaInstaller.SDK.dll"
	$ModulePaths = $env:PSModulePath -split ";"
	
	# If CapaSdkDllPath i not null then insert DLL file in module folder
	If ($CapaSdkDllPath -ne "")
	{
		foreach ($Path in $ModulePaths)
		{
			$TestPath = "$Path\Capa.PowerShell.Module\"
			If (Test-Path $TestPath)
			{
				$Destination = "$TestPath\$CapaSDKDllName"
				Copy-Item -Path $CapaSdkDllPath -Destination $Destination -Force
			}
		}
	}
	# Finds CapaInstaller SDK DLL, if it does not exist then ask for the DLL file
	Else
	{
		$NewDllFilePath = ""
		foreach ($Path in $ModulePaths)
		{
			$TestPath = "$Path\Capa.PowerShell.Module\"
			If (Test-Path $TestPath)
			{
				$TestDllPath = "$TestPath\$CapaSDKDllName"
				If (Test-Path $TestDllPath)
				{
					$Destination = $TestDllPath
				}
				elseif ($NewDllFilePath -eq "")
				{
					#Browsing file
					Add-Type -AssemblyName System.Windows.Forms
					$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog
					$FileBrowser.Filter = "Dll (*.dll)| *.dll"
					[void]$FileBrowser.ShowDialog()
					$NewDllFilePath = $FileBrowser.FileName
					
					$Destination = "$TestDllPath\$CapaSDKDllName"
					Copy-Item -Path $NewDllFilePath -Destination $Destination -Force
				}
				Else
				{
					$Destination = "$TestDllPath\$CapaSDKDllName"
					Copy-Item -Path $NewDllFilePath -Destination $Destination -Force
				}
			}
			
		}
	}
	
	Add-Type -Path $Destination
	$oCMS = New-Object CapaInstaller.SDK
	
	If ($UserName -ne "" -or $Password -ne "")
	{
		$oCMS.SetDatabaseSettings($Server, $Database, $true, $UserName, $Password) | Out-Null
	}
	else
	{
		$oCMS.SetDatabaseSettings($Server, $Database, $false) | Out-Null
	}
	
	if ($DefaultManagementPoint -ne "")
	{
		$oCMS.SetDefaultManagementPoint($DefaultManagementPoint) | Out-Null
	}
	
	if ($InstanceManagementPoint -ne "")
	{
		$oCMS.SetInstanceManagementPoint($InstanceManagementPoint) | Out-Null
	}
	
	return $oCMS
}