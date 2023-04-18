Import-Module Capa.PowerShell.Module.SDK.Authentication
Import-Module Capa.PowerShell.Module.SDK.Package
Import-Module SqlServer
<#
    .NOTES
    ===========================================================================
    Created with:	Visual Studio Code
    Created on:     2023-04-18
    Created by:		MARA
    Organization:	
    Filename:       UpdatePackage.ps1
    ===========================================================================
    .DESCRIPTION
        Updates/create a package in your CapaInstaller environment.
        Remember to change the variables at the top of the script, to match your environment.
#>
##################
# Change as needed
$CapaServer = ''
$SQLServer = ''
$Database = ''
$DefaultManagementPointDev = ''
$PackageBasePath = ''

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
        $PackageType = 'VBScript'
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
try {
    $oCMSDev = Initialize-CapaSDK -Server $CapaServer -Database $Database -DefaultManagementPoint $DefaultManagementPointDev
    $PackageInfo = Get-PackageInfo

    $DoesPackageExist = Get-CapaPackages -CapaSDK $oCMSDev -Type Computer | Where-Object { $_.Name -eq $PackageInfo.PackageName -and $_.Version -eq $PackageInfo.PackageVersion }
    if ($null -eq $DoesPackageExist -or $DoesPackageExist.Count -eq 0) {
        if ($PackageInfo.PackageType -eq 'PowerPack') {
            [string]$InstallScriptContent = Get-Content -Path "$($PackageInfo.ScriptsPath)\Install.ps1"
            [string]$UninstallScriptContent = Get-Content -Path "$($PackageInfo.ScriptsPath)\Uninstall.ps1"

            if ($null -ne $PackageInfo.KitPath) {
                $Splatting = @{
                    CapaSDK                = $oCMSDev
                    PackageName            = $PackageInfo.PackageName
                    PackageVersion         = $PackageInfo.PackageVersion
                    SqlServerInstance      = $SQLServer
                    Database               = $Database
                    KitFolderPath          = $PackageInfo.KitPath
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

            $Package = New-CapaPowerPack @Splatting
        } else {
            $Splatting = @{
                CapaSDK        = $oCMSDev
                PackageName    = $PackageInfo.PackageName
                PackageVersion = $PackageInfo.PackageVersion
                UnitType       = 'Computer'
                DisplayName    = "$($PackageInfo.PackageName) $($PackageInfo.PackageVersion)"
            }

            $Package = Create-CapaPackage @Splatting

            <#
                Bug hot fix
                The package is created in CI, but the folder containing the scripts and kit is not created.
                This is a workaround to create the folder and can be removed when the bug is fixed.
            #>
            $VBPackageBaseFolder = "$PackageBasePath\$($PackageInfo.PackageName)\$($PackageInfo.PackageVersion)"
            $VBScriptsFolder = "$VBPackageBaseFolder\Scripts"
            $VBInstallScript = "$ScriptsFolder\$($PackageInfo.PackageName).cis"
            $VBUninstallScript = "$ScriptsFolder\$($PackageInfo.PackageName)_Uninstall.cis"
            $VBKitFolder = "$VBPackageBaseFolder\Kit"
            $VBKitDummyFile = "$VBKitFolder\Dummy.txt"
            if ((Test-Path $VBScriptsFolder) -eq $false) {
                New-Item -Path $VBScriptsFolder -ItemType Directory | Out-Null
            }
            if ((Test-Path $VBInstallScript) -eq $false) {
                New-Item -Path $VBInstallScript -ItemType File | Out-Null
            }
            if ((Test-Path $VBUninstallScript) -eq $false) {
                New-Item -Path $VBUninstallScript -ItemType File | Out-Null
            }
            if ((Test-Path $VBKitFolder) -eq $false) {
                New-Item -Path $VBKitFolder -ItemType Directory | Out-Null
            }
            if ((Test-Path $VBKitDummyFile) -eq $false) {
                New-Item -Path $VBKitDummyFile -ItemType File | Out-Null
                Set-Content -Path $VBKitDummyFile -Value 'Dummy file'
            }

            $SqlQuery = "UPDATE JOB
            Set UNINSTALLSCRIPT = 1
            Where NAME = '$($PackageInfo.PackageName)'
            AND VERSION = '$($PackageInfo.PackageVersion)'"
            Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $SqlQuery
        }
    }

    # Update package
    if ($PackageInfo.PackageType -eq 'PowerPack') {
        $InstallScriptContent = Get-Content -Path "$($PackageInfo.ScriptsPath)\Install.ps1" | Out-String
        $UninstallScriptContent = Get-Content -Path "$($PackageInfo.ScriptsPath)\Uninstall.ps1" | Out-String

        $Splatting = @{
            PackageName       = $PackageInfo.PackageName
            PackageVersion    = $PackageInfo.PackageVersion
            PackageType       = $PackageInfo.PackageType
            SqlServerInstance = $SQLServer
            Database          = $Database
        }
    } else {
        $InstallScriptContent = Get-Content -Path "$($PackageInfo.ScriptsPath)\$($PackageInfo.PackageName).cis" | Out-String
        $UninstallScriptContent = Get-Content -Path "$($PackageInfo.ScriptsPath)\$($PackageInfo.PackageName)_Uninstall.cis" | Out-String
    
        $Splatting = @{
            PackageName     = $PackageInfo.PackageName
            PackageVersion  = $PackageInfo.PackageVersion
            PackageType     = $PackageInfo.PackageType
            PackageBasePath = $PackageBasePath

        }
    }

    Update-CapaPackageScriptAndKit @Splatting -ScriptType 'Install' -ScriptContent $InstallScriptContent
    Update-CapaPackageScriptAndKit @Splatting -ScriptType 'Uninstall' -ScriptContent $UninstallScriptContent
    
    if ($PackageInfo.KitPath) {
        $KitSplatt = @{
            PackageName     = $PackageInfo.PackageName
            PackageVersion  = $PackageInfo.PackageVersion
            KitFolderPath   = $PackageInfo.KitPath
            PackageBasePath = $PackageBasePath
        }
        Update-CapaPackageScriptAndKit @KitSplatt

        $RebuildSplat = @{
            CapaSDK        = $oCMSDev
            PackageName    = $PackageInfo.PackageName
            PackageVersion = $PackageInfo.PackageVersion
            PackageType    = 'Computer'
            ServerName     = $CapaServer
        }
        Rebuild-CapaKitFileOnManagementServer @RebuildSplat
        Write-Host "Remember to rebuild CapaInstaller.kit for $($PackageInfo.PackageName) $($PackageInfo.PackageVersion)"
    }
} catch {
    Write-Error $_.Exception.Message
}
