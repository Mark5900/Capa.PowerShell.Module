Import-Module Capa.PowerShell.Module.SDK.Authentication
Import-Module Capa.PowerShell.Module.SDK.Package
Import-Module SqlServer
<#
    .NOTES
    ===========================================================================
    Created with:	Visual Studio Code
    Created on: 
    Created by:		MARA
    Organization:	
    Filename:
    ===========================================================================
    .DESCRIPTION
        TODO: A description of the file.
#>
##################
### PARAMETERS ###
##################
# DO NOT CHANGE

# Change as needed
$CapaServer = 'CISRVKURSUS'
$SQLServer = 'CISRVKURSUS'
$Database = 'CapaInstaller'
$DefaultManagementPointDev = '1'

#################
### FUNCTIONS ###
#################
function Get-PackageType {
    param (
        $String
    )
    
    If ($String -like 'Capa_PP_*') {
        $PackageType = 'PowerPack'
    } else {
        $PackageType = 'VB'
    }

    return $PackageType
}
function Get-PackageInfo {
    param (
        
    )
    # Get PackageVersion
    $Folders = Get-ChildItem -Path $PSScriptRoot -Directory
    if (($Folders | Where-Object { $_.Name -eq 'Scripts' }).Count -eq 1) {
        $Path = $PSScriptRoot -split '\\'

        if (($Folders | Where-Object { $_.Name -eq 'Kit' }).Count -eq 1) {
            $KitPath = Join-Path $PSScriptRoot 'Kit'
        } else {
            $KitPath = $null
        }
        
        $PackageInfo = [psobject]@{
            PackageVersion = $Path[$Path.Count - 1]
            PackageName    = $Path[$Path.Count - 2].Replace('Capa_PP_', '').Replace('Capa_VB_', '')
            PackageType    = Get-PackageType $Path[$Path.Count - 2]
            PackagePath    = $PSScriptRoot
            ScriptsPath    = Join-Path $PSScriptRoot 'Scripts'
            KitPath        = $KitPath
        }
    } elseif (($Folders.Count -eq 1) -and (Test-Path "$PSScriptRoot\$($Folders.Name)\Scripts") -eq $true) {
        $Path = $PSScriptRoot -split '\\'

        if ((Test-Path "$PSScriptRoot\$($Folders.Name)\Kit") -eq $true) {
            $KitPath = Join-Path $PSScriptRoot "$($Folders.Name)\Kit"
        } else {
            $KitPath = $null
        }

        $PSScriptRoot
        $Folders.Name
        "$PSScriptRoot\$($Folders.Name)\Scripts"

        
        $PackageInfo = [psobject]@{
            PackageVersion = $Folders.Name
            PackageName    = $Path[$Path.Count - 1].Replace('Capa_PP_', '').Replace('Capa_VB_', '')
            PackageType    = Get-PackageType $Path[$Path.Count - 1]
            PackagePath    = Join-Path $PSScriptRoot $Folders.Name
            ScriptsPath    = Join-Path $PSScriptRoot "$($Folders.Name)" 'Scripts'
            KitPath        = $KitPath
        }
    } elseif ($Folders.Count -eq 0) {
        Write-Error 'No folders found'
    } else {
        $Text = $null
        $Path = $PSScriptRoot -split '\\'

        foreach ($Folder in $Folders) {
            if ((Test-Path "$PSScriptRoot\$($Folder.Name)\Scripts") -eq $true) {
                if ($null -eq $Text) {
                    $Text = $Folder.Name
                } else {
                    $Text += ", $($Folder.Name)"
                }
            }
        }

        $Version = Read-Host "Which version do you want to use? ($Text)"

        if ((Test-Path "$PSScriptRoot\$Version\Scripts") -eq $true) {
            if ((Test-Path "$PSScriptRoot\$Version\Kit") -eq $true) {
                $KitPath = Join-Path $PSScriptRoot "$Version\Kit"
            } else {
                $KitPath = $null
            }

            $PackageInfo = [psobject]@{
                PackageVersion = $Version
                PackageName    = $Path[$Path.Count - 1].Replace('Capa_PP_', '').Replace('Capa_VB_', '')
                PackageType    = Get-PackageType $Path[$Path.Count - 1]
                PackagePath    = Join-Path $PSScriptRoot "$Version"
                ScriptsPath    = Join-Path $PSScriptRoot "$Version\Scripts"
                KitPath        = $KitPath
            }
        } else {
            Write-Error 'No folders found'
        }
    }

    return $PackageInfo
}

##############
### SCRIPT ###
##############
$oCMSDev = Initialize-CapaSDK -Server $CapaServer -Database $Database -DefaultManagementPoint $DefaultManagementPointDev
$PackageInfo = Get-PackageInfo

$DoesPackageExist = Get-CapaPackages -CapaSDK $oCMSDev -Type Computer | Where-Object { $_.Name -eq $PackageInfo.PackageName -and $_.Version -eq $PackageInfo.PackageVersion }
if ($null -eq $DoesPackageExist -or $DoesPackageExist.Count -eq 0) {
    if ($PackageInfo.PackageType -eq 'PowerPack') {
        $InstallScriptContent = Get-Content -Path "$($PackageInfo.ScriptsPath)\Install.ps1"
        $UninstallScriptContent = Get-Content -Path "$($PackageInfo.ScriptsPath)\Uninstall.ps1"

        if ($null -ne $PackageInfo.KitPath) {
            $Splatting = @{
                CapaSDK                = $oCMSDev
                PackageName            = $PackageInfo.PackageName
                PackageVersion         = $PackageInfo.PackageVersion
                SqlServerInstance      = $SQLServer
                Database               = $Database
                $KitFolderPath         = $PackageInfo.KitPath
                InstallScriptContent   = $InstallScriptContent
                UninstallScriptContent = $UninstallScriptContent
            }
        } else {
            $Splatting = @{
                CapaSDK                = $oCMSDev
                PackageName            = $PackageInfo.PackageName
                PackageVersion         = $PackageInfo.PackageVersion
                SqlServerInstance      = $SQLServer
                Database               = $Database
                InstallScriptContent   = $InstallScriptContent
                UninstallScriptContent = $UninstallScriptContent
            }
        }

        $Package = New-CapaPowerPack $Splatting
    } else {
        $Splatting = @{
            CapaSDK        = $oCMSDev
            PackageName    = $PackageInfo.PackageName
            PackageVersion = $PackageInfo.PackageVersion
            UnitType       = 'Computer'
            DisplayName    = "$($PackageInfo.PackageName) $($PackageInfo.PackageVersion)"
        }

        $Package = Create-CapaPackage
    }
}

#TODO: Update package