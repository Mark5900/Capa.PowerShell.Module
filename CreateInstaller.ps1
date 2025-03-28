Import-Module PSMSI
Import-Module platyPS
<#
    .NOTES
    ===========================================================================
    Created with:	Visual Studio Code
    Created on:		22-04-2023
    Created by:		Mark5900
    ===========================================================================
    .DESCRIPTION
        Used to create a new version of the Capa.PowerShell.Module
#>
##################
### PARAMETERS ###
##################
# DO NOT CHANGE
$ProductName = 'Capa.PowerShell.Module'
$UpgradeCode = '84859CA1-0F7D-47BF-8D36-AE22F5E171AD'
# Change as needed
$VersionFile = Join-Path $PSScriptRoot 'version.txt'

try {
	$Version = (Get-Content -Path $VersionFile).Trim()
	$Prerelease = $false
	$FullVersion = $Version

	if ($Version -like '*-*') {
		$Version = $Version.Split('-')[0]
		$PrereleaseVersion = ($FullVersion -split '-', 2)[1]
		$PrereleaseVersion = $PrereleaseVersion.Replace('.', '')
		$Prerelease = $true
	}
} catch {
	Get-ChildItem $PSScriptRoot
	exit
}

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
			$ModuleFile = Join-Path $Folder.FullName 'Prod' "$($Folder.Name).psm1"
			Set-Content -Path $ModuleFile -Value ''

			$Files = Get-ChildItem -Path $DevFolder -File | Where-Object { $_.Name -notlike '*Tests.ps1' }
			foreach ($File in $Files) {
				Get-Content -Path $File.FullName | Out-File -FilePath $ModuleFile -Append
				Add-Content -Path $ModuleFile -Value "`n"
			}

			# Copy folders from dev to module folder, exclude Tests_Helper_Scripts
			$FoldersInDev = Get-ChildItem -Path $DevFolder -Directory -Exclude 'Tests_Helper_Scripts'
			foreach ($FolderInDev in $FoldersInDev) {
				$DestinationFolder = Join-Path $Folder.FullName 'Prod' $FolderInDev.Name

				if ((Test-Path $DestinationFolder) -eq $true) {
					Remove-Item -Path $DestinationFolder -Recurse -Force
				}

				Copy-Item -Path $FolderInDev.FullName -Destination $DestinationFolder -Recurse -Force
			}
		}
	}
}

function Update-APSDFile {
	param (
		[Parameter(Mandatory = $true)]
		[string]$Version,
		[Parameter(Mandatory = $true)]
		[string]$path
	)
	$Manifest = Import-PowerShellDataFile -Path $path

	$NewManifest = @{}
	foreach ($key in $Manifest.GetEnumerator()) {
		if ([string]::IsNullOrEmpty($key.Value)) {
			continue
		}

		switch ($key.Key) {
			'PrivateData' {
				foreach ($privateKey in $key.Value.PSData.GetEnumerator()) {
					if ([string]::IsNullOrEmpty($privateKey.Value)) {
						continue
					}
					if ($privateKey.Key -eq 'Prerelease') {
						continue
					}

					$NewManifest[$privateKey.Key] = $privateKey.Value
				}

			}
			'RequiredModules' {
				$NewRequiredModules = @()
				foreach ($module in $key.Value) {
					#if ($Prerelease) {
					#	if ([string]::IsNullOrEmpty($module.ModuleVersion)) {
					#		$UseModuleVersion = $module.RequiredVersion
					#	} else {
					#		$UseModuleVersion = $module.ModuleVersion
					#	}
					#} else {
					#	$UseModuleVersion = $Version
					#}

					#$NewRequiredModules += @{
					#	ModuleName = $module.ModuleName
					#ModuleVersion = $UseModuleVersion
					#}

					#$NewRequiredModules += $module.ModuleName
					if ([string]::IsNullOrEmpty($module.ModuleName)) {
						$ModuleName = $module
					} else {
						$ModuleName = $module.ModuleName
					}

					if ($Prerelease) {
						$NewRequiredModules += $ModuleName
					} else {
						$NewRequiredModules += @{
							ModuleName    = $ModuleName
							ModuleVersion = $Version
						}
					}
				}
				$NewManifest[$key.Key] = $NewRequiredModules
			}
			default {
				$NewManifest[$key.Key] = $key.Value
			}
		}
	}

	$NewManifest['ModuleVersion'] = $version

	if ($Prerelease) {
		$NewManifest.Add('Prerelease', $PrereleaseVersion)
	}

	New-ModuleManifest -Path $path @NewManifest
}

function Update-PSDVersions {
	param (
		[Parameter(Mandatory = $true)]
		[string]$Version
	)
	$LogPrefix = 'Update-PSDVersions:'
	$ModulePath = Join-Path $PSScriptRoot 'Modules'

	$Folders = Get-ChildItem -Path $ModulePath -Directory
	foreach ($Folder in $Folders) {
		Write-Host "$LogPrefix Updating $($Folder.Name)"

		$PsdPath = Join-Path $Folder.FullName 'Prod' "$($Folder.Name).psd1"
		if (Test-Path $PsdPath) {
			Update-APSDFile -Version $Version -Path $PsdPath
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
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module\Prod\Capa.PowerShell.Module.psd1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK\Prod\Capa.PowerShell.Module.SDK.psd1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Authentication' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Authentication\Prod\Capa.PowerShell.Module.SDK.Authentication.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Authentication\Prod\Capa.PowerShell.Module.SDK.Authentication.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Container' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Container\Prod\Capa.PowerShell.Module.SDK.Container.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Container\Prod\Capa.PowerShell.Module.SDK.Container.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Group' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Group\Prod\Capa.PowerShell.Module.SDK.Group.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Group\Prod\Capa.PowerShell.Module.SDK.Group.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Inventory' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Inventory\Prod\Capa.PowerShell.Module.SDK.Inventory.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Inventory\Prod\Capa.PowerShell.Module.SDK.Inventory.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.MDM' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.MDM\Prod\Capa.PowerShell.Module.SDK.MDM.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.MDM\Prod\Capa.PowerShell.Module.SDK.MDM.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.OSDeployment' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.OSDeployment\Prod\Capa.PowerShell.Module.SDK.OSDeployment.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.OSDeployment\Prod\Capa.PowerShell.Module.SDK.OSDeployment.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Package' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Capa.PowerShell.Module.SDK.Package.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Capa.PowerShell.Module.SDK.Package.psm1
							New-InstallerDirectory -DirectoryName 'Dependencies' -Content {
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Dependencies\CapaInstaller.kit
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Dependencies\.gitignore
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Dependencies\ciPackage.xml
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Dependencies\Install.cis
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Dependencies\Uninstall.cis
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Dependencies\Install.ps1
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Dependencies\Uninstall.ps1
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Dependencies\UpdatePackage.ps1
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Dependencies\main.yml
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Dependencies\Settings.json
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Dependencies\versioning.yml
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Dependencies\MinorVersionSetSameStatus.ps1
							}
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.SystemSdk' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.SystemSdk\Prod\Capa.PowerShell.Module.SDK.SystemSdk.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.SystemSdk\Prod\Capa.PowerShell.Module.SDK.SystemSdk.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Unit' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Unit\Prod\Capa.PowerShell.Module.SDK.Unit.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Unit\Prod\Capa.PowerShell.Module.SDK.Unit.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.User' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.User\Prod\Capa.PowerShell.Module.SDK.User.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.User\Prod\Capa.PowerShell.Module.SDK.User.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Utilities' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Utilities\Prod\Capa.PowerShell.Module.SDK.Utilities.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Utilities\Prod\Capa.PowerShell.Module.SDK.Utilities.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.VPP' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.VPP\Prod\Capa.PowerShell.Module.SDK.VPP.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.VPP\Prod\Capa.PowerShell.Module.SDK.VPP.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.WSUS' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.WSUS\Prod\Capa.PowerShell.Module.SDK.WSUS.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.WSUS\Prod\Capa.PowerShell.Module.SDK.WSUS.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack\Prod\Capa.PowerShell.Module.PowerPack.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack\Prod\Capa.PowerShell.Module.PowerPack.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Exit' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Exit\Prod\Capa.PowerShell.Module.PowerPack.Exit.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Exit\Prod\Capa.PowerShell.Module.PowerPack.Exit.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.File' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.File\Prod\Capa.PowerShell.Module.PowerPack.File.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.File\Prod\Capa.PowerShell.Module.PowerPack.File.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Ini' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Ini\Prod\Capa.PowerShell.Module.PowerPack.Ini.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Ini\Prod\Capa.PowerShell.Module.PowerPack.Ini.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Job' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Job\Prod\Capa.PowerShell.Module.PowerPack.Job.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Job\Prod\Capa.PowerShell.Module.PowerPack.Job.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Log' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Log\Prod\Capa.PowerShell.Module.PowerPack.Log.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Log\Prod\Capa.PowerShell.Module.PowerPack.Log.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.MSI' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.MSI\Prod\Capa.PowerShell.Module.PowerPack.MSI.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.MSI\Prod\Capa.PowerShell.Module.PowerPack.MSI.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Reg' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Reg\Prod\Capa.PowerShell.Module.PowerPack.Reg.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Reg\Prod\Capa.PowerShell.Module.PowerPack.Reg.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Service' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Service\Prod\Capa.PowerShell.Module.PowerPack.Service.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Service\Prod\Capa.PowerShell.Module.PowerPack.Service.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Shell' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Shell\Prod\Capa.PowerShell.Module.PowerPack.Shell.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Shell\Prod\Capa.PowerShell.Module.PowerPack.Shell.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Sys' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Sys\Prod\Capa.PowerShell.Module.PowerPack.Sys.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Sys\Prod\Capa.PowerShell.Module.PowerPack.Sys.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.CMS' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.CMS\Prod\Capa.PowerShell.Module.PowerPack.CMS.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.CMS\Prod\Capa.PowerShell.Module.PowerPack.CMS.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.UsrMgr' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.UsrMgr\Prod\Capa.PowerShell.Module.PowerPack.UsrMgr.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.UsrMgr\Prod\Capa.PowerShell.Module.PowerPack.UsrMgr.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Winget' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Winget\Prod\Capa.PowerShell.Module.PowerPack.Winget.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Winget\Prod\Capa.PowerShell.Module.PowerPack.Winget.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.Tools' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.Tools\Prod\Capa.PowerShell.Module.Tools.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.Tools\Prod\Capa.PowerShell.Module.Tools.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.CCS' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.CCS\Prod\Capa.PowerShell.Module.CCS.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.CCS\Prod\Capa.PowerShell.Module.CCS.psm1
							New-InstallerDirectory -DirectoryName 'Dependencies' -Content {
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.CCS\Prod\Dependencies\CapaInstaller.Custom.BusinessLayer.dll
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.CCS\Prod\Dependencies\CCSProxy.dll
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.CCS\Prod\Dependencies\DevComponents.DotNetBar2.dll
								New-InstallerFile -Source '.\Modules\Capa.PowerShell.Module.CCS\Prod\Dependencies\InstallationScreen.exe'
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.CCS\Prod\Dependencies\InstallationScreen.Library.dll
							}
						}
					}
				}
			}
		}
	}-OutputDirectory (Join-Path $PSScriptRoot 'Installers') -RequiresElevation -Version $Version -Manufacturer 'Mark5900' -Platform x64

	Remove-Item "$PSScriptRoot\Installers\$ProductName.$Version.x64.wxs" -Force
	Remove-Item "$PSScriptRoot\Installers\$ProductName.$Version.x64.wxsobj" -Force

	$Path = Join-Path $PSScriptRoot 'Installers' "$ProductName.$Version.x64.msi"
	if ($Prerelease) {
		$NewName = "$ProductName.$Version.x64-$PrereleaseVersion.msi"
		Rename-Item -Path $Path -NewName $NewName
		$Path = Join-Path $PSScriptRoot 'Installers' $NewName
	}

	Write-Host "Installer created at: $Path"
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
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK\Prod\Capa.PowerShell.Module.SDK.psd1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Authentication' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Authentication\Prod\Capa.PowerShell.Module.SDK.Authentication.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Authentication\Prod\Capa.PowerShell.Module.SDK.Authentication.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Container' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Container\Prod\Capa.PowerShell.Module.SDK.Container.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Container\Prod\Capa.PowerShell.Module.SDK.Container.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Group' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Group\Prod\Capa.PowerShell.Module.SDK.Group.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Group\Prod\Capa.PowerShell.Module.SDK.Group.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Inventory' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Inventory\Prod\Capa.PowerShell.Module.SDK.Inventory.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Inventory\Prod\Capa.PowerShell.Module.SDK.Inventory.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.MDM' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.MDM\Prod\Capa.PowerShell.Module.SDK.MDM.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.MDM\Prod\Capa.PowerShell.Module.SDK.MDM.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.OSDeployment' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.OSDeployment\Prod\Capa.PowerShell.Module.SDK.OSDeployment.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.OSDeployment\Prod\Capa.PowerShell.Module.SDK.OSDeployment.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Package' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Capa.PowerShell.Module.SDK.Package.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Capa.PowerShell.Module.SDK.Package.psm1
							New-InstallerDirectory -DirectoryName 'Dependencies' -Content {
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Dependencies\CapaInstaller.kit
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Dependencies\.gitignore
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Dependencies\ciPackage.xml
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Dependencies\Install.cis
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Dependencies\Uninstall.cis
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Dependencies\Install.ps1
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Dependencies\Uninstall.ps1
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Dependencies\UpdatePackage.ps1
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Dependencies\main.yml
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Dependencies\Settings.json
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Dependencies\versioning.yml
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Package\Prod\Dependencies\MinorVersionSetSameStatus.ps1
							}
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.SystemSdk' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.SystemSdk\Prod\Capa.PowerShell.Module.SDK.SystemSdk.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.SystemSdk\Prod\Capa.PowerShell.Module.SDK.SystemSdk.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Unit' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Unit\Prod\Capa.PowerShell.Module.SDK.Unit.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Unit\Prod\Capa.PowerShell.Module.SDK.Unit.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.User' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.User\Prod\Capa.PowerShell.Module.SDK.User.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.User\Prod\Capa.PowerShell.Module.SDK.User.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.Utilities' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Utilities\Prod\Capa.PowerShell.Module.SDK.Utilities.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.Utilities\Prod\Capa.PowerShell.Module.SDK.Utilities.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.VPP' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.VPP\Prod\Capa.PowerShell.Module.SDK.VPP.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.VPP\Prod\Capa.PowerShell.Module.SDK.VPP.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.SDK.WSUS' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.WSUS\Prod\Capa.PowerShell.Module.SDK.WSUS.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.SDK.WSUS\Prod\Capa.PowerShell.Module.SDK.WSUS.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.Tools' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.Tools\Prod\Capa.PowerShell.Module.Tools.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.Tools\Prod\Capa.PowerShell.Module.Tools.psm1
						}
					}
				}
			}
		}
	}-OutputDirectory (Join-Path $PSScriptRoot 'Installers') -RequiresElevation -Version $Version -Manufacturer 'Mark5900' -Platform x64
	Remove-Item "$PSScriptRoot\Installers\$ProductName.$Version.x64.wxs" -Force
	Remove-Item "$PSScriptRoot\Installers\$ProductName.$Version.x64.wxsobj" -Force

	$Path = Join-Path $PSScriptRoot 'Installers' "$ProductName.$Version.x64.msi"
	if ($Prerelease) {
		$NewName = "$ProductName.$Version.x64-$PrereleaseVersion.msi"
		Rename-Item -Path $Path -NewName $NewName
		$Path = Join-Path $PSScriptRoot 'Installers' $NewName
	}

	Write-Host "Installer created at: $Path"
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
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack\Prod\Capa.PowerShell.Module.PowerPack.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack\Prod\Capa.PowerShell.Module.PowerPack.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Exit' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Exit\Prod\Capa.PowerShell.Module.PowerPack.Exit.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Exit\Prod\Capa.PowerShell.Module.PowerPack.Exit.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.File' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.File\Prod\Capa.PowerShell.Module.PowerPack.File.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.File\Prod\Capa.PowerShell.Module.PowerPack.File.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Ini' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Ini\Prod\Capa.PowerShell.Module.PowerPack.Ini.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Ini\Prod\Capa.PowerShell.Module.PowerPack.Ini.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Job' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Job\Prod\Capa.PowerShell.Module.PowerPack.Job.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Job\Prod\Capa.PowerShell.Module.PowerPack.Job.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Log' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Log\Prod\Capa.PowerShell.Module.PowerPack.Log.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Log\Prod\Capa.PowerShell.Module.PowerPack.Log.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.MSI' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.MSI\Prod\Capa.PowerShell.Module.PowerPack.MSI.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.MSI\Prod\Capa.PowerShell.Module.PowerPack.MSI.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Reg' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Reg\Prod\Capa.PowerShell.Module.PowerPack.Reg.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Reg\Prod\Capa.PowerShell.Module.PowerPack.Reg.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Service' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Service\Prod\Capa.PowerShell.Module.PowerPack.Service.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Service\Prod\Capa.PowerShell.Module.PowerPack.Service.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Shell' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Shell\Prod\Capa.PowerShell.Module.PowerPack.Shell.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Shell\Prod\Capa.PowerShell.Module.PowerPack.Shell.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Sys' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Sys\Prod\Capa.PowerShell.Module.PowerPack.Sys.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Sys\Prod\Capa.PowerShell.Module.PowerPack.Sys.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.CMS' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.CMS\Prod\Capa.PowerShell.Module.PowerPack.CMS.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.CMS\Prod\Capa.PowerShell.Module.PowerPack.CMS.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.UsrMgr' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.UsrMgr\Prod\Capa.PowerShell.Module.PowerPack.UsrMgr.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.UsrMgr\Prod\Capa.PowerShell.Module.PowerPack.UsrMgr.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.PowerPack.Winget' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Winget\Prod\Capa.PowerShell.Module.PowerPack.Winget.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.PowerPack.Winget\Prod\Capa.PowerShell.Module.PowerPack.Winget.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.Tools' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.Tools\Prod\Capa.PowerShell.Module.Tools.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.Tools\Prod\Capa.PowerShell.Module.Tools.psm1
						}
					}
					New-InstallerDirectory -DirectoryName 'Capa.PowerShell.Module.CCS' -Content {
						New-InstallerDirectory -DirectoryName $Version -Content {
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.CCS\Prod\Capa.PowerShell.Module.CCS.psd1
							New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.CCS\Prod\Capa.PowerShell.Module.CCS.psm1
							New-InstallerDirectory -DirectoryName 'Dependencies' -Content {
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.CCS\Prod\Dependencies\CapaInstaller.Custom.BusinessLayer.dll
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.CCS\Prod\Dependencies\CCSProxy.dll
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.CCS\Prod\Dependencies\DevComponents.DotNetBar2.dll
								New-InstallerFile -Source '.\Modules\Capa.PowerShell.Module.CCS\Prod\Dependencies\InstallationScreen.exe'
								New-InstallerFile -Source .\Modules\Capa.PowerShell.Module.CCS\Prod\Dependencies\InstallationScreen.Library.dll
							}
						}
					}
				}
			}
		}
	}-OutputDirectory (Join-Path $PSScriptRoot 'Installers') -RequiresElevation -Version $Version -Manufacturer 'Mark5900' -Platform x64

	Remove-Item "$PSScriptRoot\Installers\$ProductName.$Version.x64.wxs" -Force
	Remove-Item "$PSScriptRoot\Installers\$ProductName.$Version.x64.wxsobj" -Force

	$Path = Join-Path $PSScriptRoot 'Installers' "$ProductName.$Version.x64.msi"
	if ($Prerelease) {
		$NewName = "$ProductName.$Version.x64-$PrereleaseVersion.msi"
		Rename-Item -Path $Path -NewName $NewName
		$Path = Join-Path $PSScriptRoot 'Installers' $NewName
	}
	Write-Host "Installer created at: $Path"
}

function GenerateFunctionsDocumentation {
	$ModulePath = Join-Path $PSScriptRoot 'Modules'

	$OverviewPath = Join-Path $PSScriptRoot 'Documentation' 'Overview of all functions in modules.md'
	Remove-Item -Path $OverviewPath -Force -ErrorAction SilentlyContinue
	New-Item -Path $OverviewPath -ItemType File
	Add-Content -Path $OverviewPath -Value '# Overview of all functions in modules'
	Add-Content -Path $OverviewPath -Value ''

	$Folders = Get-ChildItem -Path $ModulePath -Directory
	foreach ($Folder in $Folders) {
		Write-Host "Generating documentation for $($Folder.Name)"

		# Functions documentation
		$PSMPath = Join-Path $Folder.FullName 'Prod' "$($Folder.Name).psm1"
		if ((Test-Path $PSMPath) -eq $false) {
			continue
		}

		Import-Module $PSMPath -Force

		New-MarkdownHelp -Module $Folder.Name -OutputFolder .\Documentation\Functions -Force -AlphabeticParamsOrder -NoMetadata

		# Add to Overview of all functions in modules.md
		Add-Content -Path $OverviewPath -Value "## $($Folder.Name)"

		if ($Folder.Name -eq 'Capa.PowerShell.Module.Tools') {
			Add-Content -Path $OverviewPath -Value 'This module contains custom functions that are include bothe in the SDK and PowerPack modules, so you can use them were you need them.'
		}

		Add-Content -Path $OverviewPath -Value ''

		$DevPath = Join-Path $Folder.FullName 'Dev'
		$Files = Get-ChildItem -Path $DevPath -File | Where-Object { $_.Name -notlike '*Tests.ps1' }

		foreach ($File in $Files) {
			Add-Content -Path $OverviewPath -Value "- [$($File.BaseName)](Functions/$($File.BaseName).md)"

			# Add what module the function is in to the function documentation
			$FunctionPath = Join-Path $PSScriptRoot 'Documentation' 'Functions' "$($File.BaseName).md"

			if ((Test-Path $FunctionPath) -eq $false) {
				continue
			}

			$Content = Get-Content -Path $FunctionPath

			$Content = $Content -replace '## SYNOPSIS', "Module: $($Folder.Name)`n`n## SYNOPSIS"
			Set-Content -Path $FunctionPath -Value $Content
		}
	}

	Add-Content -Path $OverviewPath -Value ''
}

##############
### SCRIPT ###
##############
Update-PSDVersions -Version $Version
Import-FunctionsToPSMFiles
GenerateFunctionsDocumentation
try {
	Remove-Item -Path (Join-Path $PSScriptRoot 'Installers') -Recurse -Force

	New-ModuleInstaller -Version $Version -ProductName $ProductName -UpgradeCode $UpgradeCode
	New-ModuleInstallerSDKOnly -Version $Version -ProductName $ProductName -UpgradeCode $UpgradeCode
	New-ModuleInstallerPowerPackOnly -Version $Version -ProductName $ProductName -UpgradeCode $UpgradeCode
} catch {
	Write-Host "Error: $_"
	exit
}
