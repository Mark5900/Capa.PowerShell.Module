Import-Module PSMSI
$ProductName = 'Capa.PowerShell.Module'
$UpgradeCode = '84859CA1-0F7D-47BF-8D36-AE22F5E171AD'
$Version = '1.0.19.0'


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

Remove-Item ".\Installers\Capa.PowerShell.Module.$Version.x64.wxs" -Force
Remove-Item ".\Installers\Capa.PowerShell.Module.$Version.x64.wxsobj" -Force