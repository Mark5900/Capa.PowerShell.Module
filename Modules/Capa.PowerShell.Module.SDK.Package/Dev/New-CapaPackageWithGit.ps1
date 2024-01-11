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

		if ($PackageType -eq 'VBScript') {
			$InstallScript = Join-Path $PSScriptRoot 'Dependencies\Install.cis'
			$UninstallScript = Join-Path $PSScriptRoot 'Dependencies\Uninstall.cis'
		} ElseIf ($PackageType -eq 'PowerPack') {
			$InstallScript = Join-Path $PSScriptRoot 'Dependencies\Install.ps1'
			$UninstallScript = Join-Path $PSScriptRoot 'Dependencies\Uninstall.ps1'
		}

		if ($Advanced) {
			$PackagePath = Join-Path $BasePath "Capa_$SoftwareName"
			$ScriptPath = Join-Path $PackagePath 'Scripts'
			$KitPath = Join-Path $PackagePath 'Kit'
			$GitHubActionsPath = Join-Path $PackagePath '.github\workflows'
			$GitHubActionsFile = Join-Path $PSScriptRoot 'Dependencies\main.yml'
			$SettingsPath = Join-Path $PackagePath 'Settings.json'
			$SettingsFile = Join-Path $PSScriptRoot 'Dependencies\Settings.json'
		} Else {
			$PackagePath = Join-Path $BasePath "Capa_$PackageName"
			$VersionPath = Join-Path $PackagePath $PackageVersion
			$ScriptPath = Join-Path $VersionPath 'Scripts'
			$KitPath = Join-Path $VersionPath 'Kit'
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
			$Setting.PackageVersion = $PackageVersion
			$Setting | Out-File -FilePath $SettingsPath -Force
		}
		#endregion

		#region Copy UpdatePackage.ps1
		if ((Test-Path "$PackagePath\UpdatePackage.ps1") ) {
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

		# TODO: Copy main.yml
		# TODO: Copy Install/Uninstall script
		#endregion

		return 0
	} Catch {
		$PSCmdlet.ThrowTerminatingError($PSitem)
		return -1
	}
}