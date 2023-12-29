Import-Module PSMSI
<#
    .NOTES
    ===========================================================================
    Created with:	Visual Studio Code
    Created on:		22-04-2023
    Created by:		Mark5900
    Organization:	IT-Center Fyn
    Filename:
    ===========================================================================
    .DESCRIPTION
        TODO: A description of the file.
#>
##################
### PARAMETERS ###
##################
# DO NOT CHANGE
$ProductName = 'Capa.PowerShell.Module'
$UpgradeCode = '84859CA1-0F7D-47BF-8D36-AE22F5E171AD'
# Change as needed
$Version = '1.0.22.0'

#################
### FUNCTIONS ###
#################
function Import-FunctionsToPSMFiles {
    $ModulePath = Join-Path $PSScriptRoot 'Modules'

    $Folders = Get-ChildItem -Path $ModulePath -Directory
    foreach ($Folder in $Folders) {
        $DevFolder = Join-Path $Folder.FullName 'Dev'

        if ((Test-Path $DevFolder) -eq $true) {
            # Add all functions to the PSM1 files
            $ModuleFile = Join-Path $Folder.FullName "$($Folder.Name).psm1"
            Set-Content -Path $ModuleFile -Value ''

            $Files = Get-ChildItem -Path $DevFolder -File | Where-Object { $_.Name -notlike '*Tests.ps1' }
            foreach ($File in $Files) {
                Get-Content -Path $File.FullName | Out-File -FilePath $ModuleFile -Append
                Add-Content -Path $ModuleFile -Value "`n"
            }

            # Copy folders from dev to module folder
            $FoldersInDev = Get-ChildItem -Path $DevFolder -Directory
            foreach ($FolderInDev in $FoldersInDev) {
                $DestinationFolder = Join-Path $Folder.FullName $FolderInDev.Name

                if ((Test-Path $DestinationFolder) -eq $true) {
                    Remove-Item -Path $DestinationFolder -Recurse -Force
                }

                Copy-Item -Path $FolderInDev.FullName -Destination $DestinationFolder -Recurse -Force
            }
        }
    }
}

function New-ModuleInstaller {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Version,
        [Parameter(Mandatory = $true)]
        [string]$ProductName,
        [Parameter(Mandatory = $true)]
        [string]$UpgradeCode
    )
    New-Installer -ProductName $ProductName -UpgradeCode $UpgradeCode -Content {
        New-InstallerDirectory -PredefinedDirectoryName ProgramFiles64Folder -Content {
            New-InstallerDirectory -DirectoryName 'PowerShell' -Content {
                New-InstallerDirectory -DirectoryName 'Modules' -Content {
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module\Capa.PowerShell.Module.psd1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK\Capa.PowerShell.Module.SDK.psd1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Authentication' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Authentication\Capa.PowerShell.Module.SDK.Authentication.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Authentication\Capa.PowerShell.Module.SDK.Authentication.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Container' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Container\Capa.PowerShell.Module.SDK.Container.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Container\Capa.PowerShell.Module.SDK.Container.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Group' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Group\Capa.PowerShell.Module.SDK.Group.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Group\Capa.PowerShell.Module.SDK.Group.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Inventory' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Inventory\Capa.PowerShell.Module.SDK.Inventory.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Inventory\Capa.PowerShell.Module.SDK.Inventory.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.MDM' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.MDM\Capa.PowerShell.Module.SDK.MDM.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.MDM\Capa.PowerShell.Module.SDK.MDM.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.OSDeployment' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.OSDeployment\Capa.PowerShell.Module.SDK.OSDeployment.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.OSDeployment\Capa.PowerShell.Module.SDK.OSDeployment.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Package' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Capa.PowerShell.Module.SDK.Package.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Capa.PowerShell.Module.SDK.Package.psm1
                        New-InstallerDirectory -DirectoryName 'Dependencies' -Content {
                            New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Dependencies\CapaInstaller.kit
                            New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Dependencies\.gitignore
                            New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Dependencies\ciPackage.xml
                            New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Dependencies\Install.cis
                            New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Dependencies\Uninstall.cis
                            New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Dependencies\Install.ps1
                            New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Dependencies\Uninstall.ps1
                            New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Dependencies\UpdatePackage.ps1
                        }
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.SystemSdk' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.SystemSdk\Capa.PowerShell.Module.SDK.SystemSdk.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.SystemSdk\Capa.PowerShell.Module.SDK.SystemSdk.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Unit' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Unit\Capa.PowerShell.Module.SDK.Unit.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Unit\Capa.PowerShell.Module.SDK.Unit.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.User' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.User\Capa.PowerShell.Module.SDK.User.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.User\Capa.PowerShell.Module.SDK.User.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Utilities' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Utilities\Capa.PowerShell.Module.SDK.Utilities.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Utilities\Capa.PowerShell.Module.SDK.Utilities.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.VPP' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.VPP\Capa.PowerShell.Module.SDK.VPP.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.VPP\Capa.PowerShell.Module.SDK.VPP.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.WSUS' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.WSUS\Capa.PowerShell.Module.SDK.WSUS.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.WSUS\Capa.PowerShell.Module.SDK.WSUS.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack\Capa.PowerShell.Module.PowerPack.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack\Capa.PowerShell.Module.PowerPack.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Exit' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Exit\Capa.PowerShell.Module.PowerPack.Exit.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Exit\Capa.PowerShell.Module.PowerPack.Exit.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.File' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.File\Capa.PowerShell.Module.PowerPack.File.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.File\Capa.PowerShell.Module.PowerPack.File.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Ini' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Ini\Capa.PowerShell.Module.PowerPack.Ini.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Ini\Capa.PowerShell.Module.PowerPack.Ini.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Job' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Job\Capa.PowerShell.Module.PowerPack.Job.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Job\Capa.PowerShell.Module.PowerPack.Job.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Log' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Log\Capa.PowerShell.Module.PowerPack.Log.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Log\Capa.PowerShell.Module.PowerPack.Log.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.MSI' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.MSI\Capa.PowerShell.Module.PowerPack.MSI.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.MSI\Capa.PowerShell.Module.PowerPack.MSI.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Reg' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Reg\Capa.PowerShell.Module.PowerPack.Reg.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Reg\Capa.PowerShell.Module.PowerPack.Reg.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Service' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Service\Capa.PowerShell.Module.PowerPack.Service.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Service\Capa.PowerShell.Module.PowerPack.Service.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Shell' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Shell\Capa.PowerShell.Module.PowerPack.Shell.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Shell\Capa.PowerShell.Module.PowerPack.Shell.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Sys' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Sys\Capa.PowerShell.Module.PowerPack.Sys.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Sys\Capa.PowerShell.Module.PowerPack.Sys.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.UsrMgr' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.UsrMgr\Capa.PowerShell.Module.PowerPack.UsrMgr.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.UsrMgr\Capa.PowerShell.Module.PowerPack.UsrMgr.psm1
                    }
                }
            }
        }
    }-OutputDirectory (Join-Path $PSScriptRoot 'Installers') -RequiresElevation -Version $Version -Manufacturer 'Mark5900' -Platform x64

    Remove-Item "$PSScriptRoot\Installers\$ProductName.$Version.x64.wxs" -Force
    Remove-Item "$PSScriptRoot\Installers\$ProductName.$Version.x64.wxsobj" -Force
}

function New-ModuleInstallerSDKOnly {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Version,
        [Parameter(Mandatory = $true)]
        [string]$ProductName,
        [Parameter(Mandatory = $true)]
        [string]$UpgradeCode
    )
    $ProductName = "$ProductName.SDK"
    New-Installer -ProductName $ProductName -UpgradeCode $UpgradeCode -Content {
        New-InstallerDirectory -PredefinedDirectoryName ProgramFiles64Folder -Content {
            New-InstallerDirectory -DirectoryName 'PowerShell' -Content {
                New-InstallerDirectory -DirectoryName 'Modules' -Content {
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK\Capa.PowerShell.Module.SDK.psd1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Authentication' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Authentication\Capa.PowerShell.Module.SDK.Authentication.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Authentication\Capa.PowerShell.Module.SDK.Authentication.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Container' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Container\Capa.PowerShell.Module.SDK.Container.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Container\Capa.PowerShell.Module.SDK.Container.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Group' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Group\Capa.PowerShell.Module.SDK.Group.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Group\Capa.PowerShell.Module.SDK.Group.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Inventory' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Inventory\Capa.PowerShell.Module.SDK.Inventory.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Inventory\Capa.PowerShell.Module.SDK.Inventory.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.MDM' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.MDM\Capa.PowerShell.Module.SDK.MDM.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.MDM\Capa.PowerShell.Module.SDK.MDM.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.OSDeployment' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.OSDeployment\Capa.PowerShell.Module.SDK.OSDeployment.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.OSDeployment\Capa.PowerShell.Module.SDK.OSDeployment.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Package' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Capa.PowerShell.Module.SDK.Package.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Capa.PowerShell.Module.SDK.Package.psm1
                        New-InstallerDirectory -DirectoryName 'Dependencies' -Content {
                            New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Dependencies\CapaInstaller.kit
                            New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Dependencies\.gitignore
                            New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Dependencies\ciPackage.xml
                            New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Dependencies\Install.cis
                            New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Dependencies\Uninstall.cis
                            New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Dependencies\Install.ps1
                            New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Dependencies\Uninstall.ps1
                            New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Dependencies\UpdatePackage.ps1
                        }
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.SystemSdk' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.SystemSdk\Capa.PowerShell.Module.SDK.SystemSdk.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.SystemSdk\Capa.PowerShell.Module.SDK.SystemSdk.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Unit' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Unit\Capa.PowerShell.Module.SDK.Unit.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Unit\Capa.PowerShell.Module.SDK.Unit.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.User' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.User\Capa.PowerShell.Module.SDK.User.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.User\Capa.PowerShell.Module.SDK.User.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Utilities' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Utilities\Capa.PowerShell.Module.SDK.Utilities.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Utilities\Capa.PowerShell.Module.SDK.Utilities.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.VPP' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.VPP\Capa.PowerShell.Module.SDK.VPP.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.VPP\Capa.PowerShell.Module.SDK.VPP.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.WSUS' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.WSUS\Capa.PowerShell.Module.SDK.WSUS.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.WSUS\Capa.PowerShell.Module.SDK.WSUS.psm1
                    }
                }
            }
        }
    }-OutputDirectory (Join-Path $PSScriptRoot 'Installers') -RequiresElevation -Version $Version -Manufacturer 'Mark5900' -Platform x64
    Remove-Item "$PSScriptRoot\Installers\$ProductName.$Version.x64.wxs" -Force
    Remove-Item "$PSScriptRoot\Installers\$ProductName.$Version.x64.wxsobj" -Force
}

function New-ModuleInstallerPowerPackOnly {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Version,
        [Parameter(Mandatory = $true)]
        [string]$ProductName,
        [Parameter(Mandatory = $true)]
        [string]$UpgradeCode
    )
    $ProductName = "$ProductName.PowerPack"
    New-Installer -ProductName $ProductName -UpgradeCode $UpgradeCode -Content {
        New-InstallerDirectory -PredefinedDirectoryName ProgramFiles64Folder -Content {
            New-InstallerDirectory -DirectoryName 'PowerShell' -Content {
                New-InstallerDirectory -DirectoryName 'Modules' -Content {
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack\Capa.PowerShell.Module.PowerPack.psd1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Exit' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Exit\Capa.PowerShell.Module.PowerPack.Exit.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Exit\Capa.PowerShell.Module.PowerPack.Exit.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.File' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.File\Capa.PowerShell.Module.PowerPack.File.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.File\Capa.PowerShell.Module.PowerPack.File.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Ini' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Ini\Capa.PowerShell.Module.PowerPack.Ini.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Ini\Capa.PowerShell.Module.PowerPack.Ini.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Job' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Job\Capa.PowerShell.Module.PowerPack.Job.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Job\Capa.PowerShell.Module.PowerPack.Job.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Log' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Log\Capa.PowerShell.Module.PowerPack.Log.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Log\Capa.PowerShell.Module.PowerPack.Log.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.MSI' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.MSI\Capa.PowerShell.Module.PowerPack.MSI.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.MSI\Capa.PowerShell.Module.PowerPack.MSI.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Reg' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Reg\Capa.PowerShell.Module.PowerPack.Reg.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Reg\Capa.PowerShell.Module.PowerPack.Reg.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Service' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Service\Capa.PowerShell.Module.PowerPack.Service.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Service\Capa.PowerShell.Module.PowerPack.Service.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Shell' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Shell\Capa.PowerShell.Module.PowerPack.Shell.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Shell\Capa.PowerShell.Module.PowerPack.Shell.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Sys' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Sys\Capa.PowerShell.Module.PowerPack.Sys.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Sys\Capa.PowerShell.Module.PowerPack.Sys.psm1
                    }
                    New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.UsrMgr' -Content {
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.UsrMgr\Capa.PowerShell.Module.PowerPack.UsrMgr.psd1
                        New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.UsrMgr\Capa.PowerShell.Module.PowerPack.UsrMgr.psm1
                    }
                }
            }
        }
    }-OutputDirectory (Join-Path $PSScriptRoot 'Installers') -RequiresElevation -Version $Version -Manufacturer 'Mark5900' -Platform x64

    Remove-Item "$PSScriptRoot\Installers\$ProductName.$Version.x64.wxs" -Force
    Remove-Item "$PSScriptRoot\Installers\$ProductName.$Version.x64.wxsobj" -Force
}

function GenerateSyntaxText {
    param (
        $GetHelp
    )
    $Text = ''

    foreach ($Syntax in $GetHelp.Syntax.syntaxItem) {
        $Text += '```powershell'
        $Text += "`n"

        $Text += "$($Syntax.Name)`n"
        foreach ($Parameter in $Syntax.Parameter) {
            $Text += "`t-"

            if ($Parameter.Required) {
                $Text += "$($Parameter.Name)"
            } else {
                $Text += "[$($Parameter.Name)]"
            }

            $Text += " <$($Parameter.parameterValue)>`n"
        }


        $Text += '```'
        $Text += "`n"
    }

    return $Text
}

function GenerateExaplesText {
    param (
        $GetHelp
    )
    $Text = ''
    $Number = 1

    foreach ($Example in $GetHelp.Examples.example) {
        $Text += "### Example $Number"
        $Text += "`n"

        $Text += '```powershell'
        $Text += "`n"

        $Text += "$($Example.code)`n"

        $Text += '```'
        $Text += "`n"

        if ($null -ne $Example.remarks -and $Example.remarks -ne '') {
            $Text += "$($Example.remarks)`n"
        }

        $Number++
    }

    return $Text
}

function Get-ValidateSet {
    param(
        $FunctionPath
    )
    $ValidateSet = @()
    $Values = $null
    $FileContent = Get-Content $FunctionPath

    foreach ($Line in $FileContent) {
        if ($Line -like '*ValidateSet*') {
            $Values += $Line
            $ParameterName = $null
        }

        if ($Line -like '*$*' -and $Line -notlike '*Mandatory*') {
            $ParameterName = $Line
        }

        if ($null -ne $Values -and $null -ne $ParameterName) {
            $ValidateSetValue = $null

            $Values = $Values.Split(',')
            foreach ($Value in $Values) {
                $text = GetStringBetweenTwoStrings -Content $Value -firstString "'" -secondString "'"

                if ($null -ne $ValidateSetValue) {
                    $ValidateSetValue += ", $text"
                } else {
                    $ValidateSetValue = $text
                }
            }

            $ParameterName = $ParameterName.Split('=')[0].Trim()
            $ParameterName = $ParameterName.Split('$')[1].Trim()

            $ValidateSet += @{ Name = $ParameterName; Values = $ValidateSetValue }

            $Values = $null
        }
    }

    return $ValidateSet
}

function GenerateParametersText {
    param (
        $GetHelp,
        $FunctionPath
    )
    $Text = ''
    $ValidateSet = Get-ValidateSet -FunctionPath $FunctionPath

    foreach ($Parameter in $GetHelp.Parameters.parameter) {
        $Text += "-**$($Parameter.name)**`n`n"
        $Text += "$($Parameter.description.Text)`n"
        $Text += "| Name | Value |`n"
        $Text += "| ---- | ---- |`n"
        $Text += "| Type: | $($Parameter.type.name) |`n"

        # Accepted values: for parameters
        # FIXME - this is not working for all parameters but some of them
        if ($Validate.Name -contains $Parameter.name) {
            Write-Host "Found validate set for $($Parameter.name)"
            $Value = $ValidateSet | Where-Object { $_.Name -eq $Parameter.name }
            Write-Host "Values: $($Value.Values)"
            $Text += "| Accepted values: | $($Value.Values) | `n"
        }

        $Text += "| Position: | $($Parameter.position) | `n"

        if ($null -eq $Parameter.defaultValue -or $Parameter.defaultValue -eq '') {
            $Value = 'None'
        } else {
            $Value = $Parameter.defaultValue
        }
        $Text += "| Default value: | $Value | `n"

        $Text += "| Accept pipeline input: | $($Parameter.pipelineInput) | `n"
        $Text += "| Accept wildcard characters: | $($Parameter.globbing) | `n`n"
    }

    return $Text
}

function GetStringBetweenTwoStrings {
    param (
        $importPath,
        $firstString,
        $secondString,
        $Content = $null
    )

    #Get content from file
    if ($null -eq $Content) {
        $file = Get-Content $importPath
    } else {
        $file = $Content
    }

    #Regex pattern to compare two strings
    $pattern = "$firstString(.*?)$secondString"

    #Perform the opperation
    $result = [regex]::Match($file, $pattern).Groups[1].Value

    #Return result
    return $result

}

function GenerateFunctionsDocumentation {
    $DocumentationFolder = Join-Path $PSScriptRoot 'Documentation' 'Functions'
    $ModulePath = Join-Path $PSScriptRoot 'Modules'

    # Add overview page for all functions in documentation folder
    $OverviewFile = Join-Path $PSScriptRoot 'Documentation' 'Overview of all functions in modules.md'
    Out-File -FilePath $OverviewFile -InputObject '# Overview of all functions in modules' -Force

    # Delete all files in the folder
    Get-ChildItem -Path $DocumentationFolder -Recurse | Remove-Item -Force

    # Generate documentation for all functions in the modules
    $Folders = Get-ChildItem -Path $ModulePath -Directory
    foreach ($Folder in $Folders) {
        $DevFolder = Join-Path $Folder.FullName 'Dev'

        if (Test-Path $DevFolder) {
            $Files = Get-ChildItem -Path $DevFolder -File | Where-Object { $_.Name -notlike '*Tests.ps1' }

            # Add overview page for all functions in module
            Out-File -FilePath $OverviewFile -InputObject "`n## $($Folder.Name)`n" -Append

            foreach ($File in $Files) {
                Write-Host "Generating documentation for $($File.Name)"

                $FunctionName = $File.Name -replace '.ps1'
                $DocumentationFile = Join-Path $DocumentationFolder "$FunctionName.md"

                Import-Module $File.FullName -Force
                $GetHelp = Get-Help $FunctionName -Full

                # Title
                Out-File -FilePath $DocumentationFile -InputObject "# $($GetHelp.Name)" -Append

                # Module
                Out-File -FilePath $DocumentationFile -InputObject "Module: $($Folder.Name)`n" -Append

                # Synopsis
                Out-File -FilePath $DocumentationFile -InputObject "$($GetHelp.Synopsis)`n" -Append

                # Syntax
                Out-File -FilePath $DocumentationFile -InputObject "## Syntax`n" -Append
                Out-File -FilePath $DocumentationFile -InputObject (GenerateSyntaxText -GetHelp $GetHelp) -Append

                # Description
                Out-File -FilePath $DocumentationFile -InputObject "## Description`n" -Append
                Out-File -FilePath $DocumentationFile -InputObject "$($GetHelp.Description.Text)`n" -Append

                # Examples
                Out-File -FilePath $DocumentationFile -InputObject "## Examples`n" -Append
                Out-File -FilePath $DocumentationFile -InputObject (GenerateExaplesText -GetHelp $GetHelp) -Append

                # Parameters
                Out-File -FilePath $DocumentationFile -InputObject "## Parameters`n" -Append
                $Text = GenerateParametersText -GetHelp $GetHelp -FunctionPath $File.FullName
                Out-File -FilePath $DocumentationFile -InputObject ($Text) -Append

                # Notes
                Out-File -FilePath $DocumentationFile -InputObject "## Notes`n" -Append
                Out-File -FilePath $DocumentationFile -InputObject "$((GetStringBetweenTwoStrings -firstString '.NOTES' -secondString '#>' -importPath $File.FullName).trim())" -Append

                #TODO: Add overview page for all functions in documentation folder
                Out-File -FilePath $OverviewFile -InputObject "* [$($GetHelp.Name)](Functions/$($GetHelp.Name).md)" -Append
            }
        }
    }
}

##############
### SCRIPT ###
##############
Import-FunctionsToPSMFiles
GenerateFunctionsDocumentation
New-ModuleInstaller -Version $Version -ProductName $ProductName -UpgradeCode $UpgradeCode
New-ModuleInstallerSDKOnly -Version $Version -ProductName $ProductName -UpgradeCode $UpgradeCode
New-ModuleInstallerPowerPackOnly -Version $Version -ProductName $ProductName -UpgradeCode $UpgradeCode