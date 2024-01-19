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
			$GitHubActionsFile = Join-Path $PSScriptRoot 'Dependencies\main.yml'
			$SettingsPath = Join-Path $PackagePath 'Settings.json'
			$SettingsFile = Join-Path $PSScriptRoot 'Dependencies\Settings.json'
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
			Copy-Item -Path $GitHubActionsFile -Destination $GitHubActionsPath -Force | Out-Null
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