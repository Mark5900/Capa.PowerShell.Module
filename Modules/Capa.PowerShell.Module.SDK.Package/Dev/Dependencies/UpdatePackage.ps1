Import-Module Capa.PowerShell.Module.SDK.Authentication
Import-Module Capa.PowerShell.Module.SDK.Package
Import-Module SqlServer
<#
    .NOTES
    ===========================================================================
    Created with:	Visual Studio Code
    Created on:     2023-04-18
    Created by:		MARA
    Filename:       UpdatePackage.ps1
    ===========================================================================
    .DESCRIPTION
        Updates/create a package in your CapaInstaller environment.

        Remember to change the variables at the top of the script, to match your environment.

        Or use Settings.json created when using -Advanced on New-CapaPackageWithGit
#>
##################
### PARAMETERS ###
##################
# Change as needed
$CapaServer = ''
$SQLServer = ''
$Database = ''
$DefaultManagementPointDev = ''
$PackageBasePath = ''

# Do not change
$SettingsFile = Join-Path $PSScriptRoot 'Settings.json'
$Settings = @{
    CapaServer             = $CapaServer
    SQLServer              = $SQLServer
    Database               = $Database
    DefaultManagementPoint = $DefaultManagementPointDev
    PackageBasePath        = $PackageBasePath
}


#################
### FUNCTIONS ###
#################
function Get-PackageType {
    param (
        [Parameter(Mandatory = $true)]
        [string]$PackagePath
    )
    $ScriptsPath = Join-Path $PackagePath 'Scripts'

    if (Test-Path -Path $ScriptsPath) {
        $Files = Get-ChildItem -Path $ScriptsPath -File

        if ($Files[0].Extension -eq '.ps1') {
            return 'PowerPack'
        } Else {
            return 'VBScript'
        }
    } Else {
        throw "PackagePath '$PackagePath' does not contain a 'Scripts' folder"
    }
}

function Get-PackageInfo {
    param (
        [string]$Type = 'Normal',
        [pscustomobject]$Settings
    )
    if ($Type -eq 'Normal') {
        $Folders = Get-ChildItem -Path $PSScriptRoot -Directory

        if ($Folders.Count -eq 0) {
            throw "No folders found in '$PSScriptRoot'"
        } elseif (($Folders | Where-Object { $_.Name -eq 'Scripts' }).Count -eq 1) {
            <#
            Handels the example case:
            ..\Capa_PP_Test1\v1.0
        #>
            $Path = $PSScriptRoot -split '\\'

            if (($Folders | Where-Object { $_.Name -eq 'Kit' }).Count -eq 1) {
                $KitPath = Join-Path $PSScriptRoot 'Kit'
            } else {
                $KitPath = $null
            }

            $PackageInfo = [psobject]@{
                PackageVersion = $Path[$Path.Count - 1]
                PackageName    = $Path[$Path.Count - 2].Replace('Capa_PP_', '').Replace('Capa_VB_', '').Replace('Capa_', '')
                PackageType    = Get-PackageType -PackagePath $PSScriptRoot
                PackagePath    = $PSScriptRoot
                ScriptsPath    = Join-Path $PSScriptRoot 'Scripts'
                KitPath        = $KitPath
            }
        } elseif (($Folders.Count -eq 1) -and (Test-Path "$PSScriptRoot\$($Folders.Name)\Scripts") -eq $true) {
            <#
            Handels the example case:
            ..\Capa_PP_Test1 where there is a folder called v1.0
        #>
            $Path = $PSScriptRoot -split '\\'

            if ((Test-Path "$PSScriptRoot\$($Folders.Name)\Kit") -eq $true) {
                $KitPath = Join-Path $PSScriptRoot "$($Folders.Name)\Kit"
            } else {
                $KitPath = $null
            }

            $PackageInfo = [psobject]@{
                PackageVersion = $Folders.Name
                PackageName    = $Path[$Path.Count - 1].Replace('Capa_PP_', '').Replace('Capa_VB_', '').Replace('Capa_', '')
                PackageType    = Get-PackageType -PackagePath (Join-Path $PSScriptRoot $Folders.Name)
                PackagePath    = Join-Path $PSScriptRoot $Folders.Name
                ScriptsPath    = Join-Path $PSScriptRoot "$($Folders.Name)" 'Scripts'
                KitPath        = $KitPath
            }
        } Else {
            <#
            Handels the example case:
            ..\Capa_PP_Test1\ with the example folders v1.0 and v1.1
        #>
            $Text = $null
            $Path = $PSScriptRoot -split '\\'

            if ($Path[$Path.Count - 1] -eq 'Scripts') {
                $Text = "PackagePath '$PSScriptRoot' is not a valid package path"
            } Else {
                $Text = "PackagePath '$PSScriptRoot' does not contain a 'Scripts' folder"
            }

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
                    PackageName    = $Path[$Path.Count - 1].Replace('Capa_PP_', '').Replace('Capa_VB_', '').Replace('Capa_', '')
                    PackageType    = Get-PackageType -PackagePath (Join-Path $PSScriptRoot $Version)
                    PackagePath    = Join-Path $PSScriptRoot "$Version"
                    ScriptsPath    = Join-Path $PSScriptRoot "$Version\Scripts"
                    KitPath        = $KitPath
                }
            } else {
                Throw "The version '$Version' does not exist or does not contain a 'Scripts' folder"
            }
        }
    } else {
        $KitPath = Join-Path $PSScriptRoot 'Kit'

        if ((Test-Path -Path $KitPath) -eq $false) {
            $KitPath = $null
        }

        $PackageInfo = [psobject]@{
            PackageVersion = "p$($Settings.PackageVersion)"
            PackageName    = "$($Settings.SoftwareName) $($Settings.SoftwareVersion)"
            PackageType    = Get-PackageType -PackagePath $PSScriptRoot
            PackagePath    = $PSScriptRoot
            ScriptsPath    = Join-Path $PSScriptRoot 'Scripts'
            KitPath        = $KitPath
        }
    }

    return $PackageInfo
}

##############
### SCRIPT ###
##############
try {
    #region Variables
    if (Test-Path -Path $SettingsFile) {
        $Settings = Get-Content -Path $SettingsFile | ConvertFrom-Json
        $oCMS = Initialize-CapaSDK -Server $Settings.CapaServer -Database $Settings.Database -DefaultManagementPoint $Settings.DefaultManagementPoint
        $PackageInfo = Get-PackageInfo -Type 'Advanced' -Settings $Settings
    } Else {
        $oCMS = Initialize-CapaSDK -Server $CapaServer -Database $Database -DefaultManagementPoint $DefaultManagementPointDev
        $PackageInfo = Get-PackageInfo
    }

    $DoesThePackageExist = Exist-CapaPackage -CapaSDK $oCMS -Name $PackageInfo.PackageName -Version $PackageInfo.PackageVersion -Type Computer

    $Splatting = @{}
    $Splatting.CapaSDK = $oCMS
    $Splatting.PackageName = $PackageInfo.PackageName
    $Splatting.PackageVersion = $PackageInfo.PackageVersion
    #endregion

    #region Create the package if it does not exist
    if ($DoesThePackageExist -eq $false) {
        if ($PackageInfo.PackageType -eq 'PowerPack') {
            [string]$InstallScriptContent = Get-Content -Path "$($PackageInfo.ScriptsPath)\Install.ps1"
            [string]$UninstallScriptContent = Get-Content -Path "$($PackageInfo.ScriptsPath)\Uninstall.ps1"

            if ([string]::IsNullOrEmpty($PackageInfo) -eq $false) {
                $Splatting.KitFolderPath = $PackageInfo.KitPath
            }

            $Splatting.SqlServerInstance = $Settings.SQLServer
            $Splatting.Database = $Settings.Database

            $bStatus = New-CapaPowerPack @Splatting -InstallScriptContent $InstallScriptContent -UninstallScriptContent $UninstallScriptContent
            If ($bStatus -eq $false) {
                Throw "Failed to create PowerPack package '$($PackageInfo.PackageName) $($PackageInfo.PackageVersion)'"
            }
        } else {
            $Splatting.UnitType = 'Computer'
            $Splatting.DisplayName = "$($PackageInfo.PackageName) $($PackageInfo.PackageVersion)"

            $bStatus = New-CapaPackage @Splatting
            If ($bStatus -eq $false) {
                Throw "Failed to create VB package '$($PackageInfo.PackageName) $($PackageInfo.PackageVersion)'"
            }

            <#
                TODO: #256 Bug hot fix
                The package is created in CI, but the folder containing the scripts and kit is not created.
                This is a workaround to create the folder and can be removed when the bug is fixed.
            #>
            $VBPackageBaseFolder = "$PackageBasePath\$($PackageInfo.PackageName)\$($PackageInfo.PackageVersion)"
            $VBScriptsFolder = "$VBPackageBaseFolder\Scripts"
            $VBInstallScript = "$VBScriptsFolder\$($PackageInfo.PackageName).cis"
            $VBUninstallScript = "$VBScriptsFolder\$($PackageInfo.PackageName)_Uninstall.cis"
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
            Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $SqlQuery -TrustServerCertificate
        }
    }
    #endregion

    #region Update the package
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
        $InstallScriptPath = "$($PackageInfo.ScriptsPath)\$($PackageInfo.PackageName).cis"
        $UninstallScriptPath = "$($PackageInfo.ScriptsPath)\$($PackageInfo.PackageName)_Uninstall.cis"

        if (Test-Path -Path $InstallScriptPath) {
            $InstallScriptContent = Get-Content -Path $InstallScriptPath | Out-String
        } Else {
            $InstallScriptPath = "$($PackageInfo.ScriptsPath)\$($Settings.SoftwareName).cis"

            if (Test-Path -Path $InstallScriptPath) {
                $InstallScriptContent = Get-Content -Path $InstallScriptPath | Out-String
            } Else {
                $InstallScriptContent = $null
            }
        }
        if (Test-Path -Path $UninstallScriptPath) {
            $UninstallScriptContent = Get-Content -Path $UninstallScriptPath | Out-String
        } Else {
            $UninstallScriptPath = "$($PackageInfo.ScriptsPath)\$($Settings.SoftwareName)_Uninstall.cis"

            if (Test-Path -Path $UninstallScriptPath) {
                $UninstallScriptContent = Get-Content -Path $UninstallScriptPath | Out-String
            } Else {
                $UninstallScriptContent = $null
            }
        }

        $Splatting = @{
            PackageName     = $PackageInfo.PackageName
            PackageVersion  = $PackageInfo.PackageVersion
            PackageType     = $PackageInfo.PackageType
            PackageBasePath = $PackageBasePath

        }
    }

    if ($null -ne $InstallScriptContent) {
        $bStatus = Update-CapaPackageScriptAndKit @Splatting -ScriptType 'Install' -ScriptContent $InstallScriptContent
        If ($bStatus -eq $false) {
            Throw "Failed to update install script for package '$($PackageInfo.PackageName) $($PackageInfo.PackageVersion)'"
        }
    }

    if ($null -ne $UninstallScriptContent) {
        $bStatus = Update-CapaPackageScriptAndKit @Splatting -ScriptType 'Uninstall' -ScriptContent $UninstallScriptContent
        If ($bStatus -eq $false) {
            Throw "Failed to update uninstall script for package '$($PackageInfo.PackageName) $($PackageInfo.PackageVersion)'"
        }
    }

    if ($PackageInfo.KitPath) {
        $KitSplatt = @{
            PackageName     = $PackageInfo.PackageName
            PackageVersion  = $PackageInfo.PackageVersion
            KitFolderPath   = $PackageInfo.KitPath
            PackageBasePath = $PackageBasePath
        }
        $bStatus = Update-CapaPackageScriptAndKit @KitSplatt
        If ($bStatus -eq $false) {
            Throw "Failed to update kit for package '$($PackageInfo.PackageName) $($PackageInfo.PackageVersion)'"
        }

        $RebuildSplat = @{
            CapaSDK        = $oCMS
            PackageName    = $PackageInfo.PackageName
            PackageVersion = $PackageInfo.PackageVersion
            PackageType    = 'Computer'
            PointID        = $Settings.DefaultManagementPoint
        }
        $bStatus = Rebuild-CapaKitFileOnPoint @RebuildSplat
        If ($bStatus -eq $false) {
            Throw "Failed to rebuild kit for package '$($PackageInfo.PackageName) $($PackageInfo.PackageVersion)'"
        }
    }
    #endregion

} Catch {
    Write-Error $_.Exception.Message
    Exit 1
}
