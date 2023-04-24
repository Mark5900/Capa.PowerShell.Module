<#
    .SYNOPSIS
        Create a new Capa package with Git
    
    .DESCRIPTION
        Creates a local folder structure you can use with Git to manage your deployment of Capa packages.
        The folder structure is based on the Capa package structure.

    .PARAMETER PackageName
        The name of the package

    .PARAMETER PackageVersion
        The version of the package

    .PARAMETER PackageType
        The type of the package. Valid values are VBScript and PowerPack

    .PARAMETER BasePath
        The base path where the package folder will be created

    .PARAMETER CapaServer
        The name of the Capa server

    .PARAMETER Database
        The name of the Capa database

    .PARAMETER DefaultManagementPoint
        The default management point in Capa it should be set to the id of the development management point.

    .EXAMPLE
        New-CapaPackageWithGit -PackageName 'Test' -PackageVersion 'v1.0' -PackageType 'VBScript' -BasePath 'D:\PowerShell'

    .EXAMPLE
        New-CapaPackageWithGit -PackageName 'Test2' -PackageVersion 'v1.0' -PackageType 'PowerPack' -BasePath 'D:\PowerShell' -CapaServer $CapaServer -Database $Database -DefaultManagementPoint $DefaultManagementPointDev

    .NOTES
        This is a custom function for Capa. It is not part of the Capa SDK.
#>
function New-CapaPackageWithGit {
	param (
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('VBScript', 'PowerPack')]
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[string]$BasePath,
		$CapaServer,
		$SQLServer,
		$Database,
		$DefaultManagementPoint,
		$PackageBasePath
	)
	try {
		# Parameters
		$GitIgnoreFile = Join-Path $PSScriptRoot 'Dependencies\.gitignore'
		$UpdatePackageScript = Join-Path $PSScriptRoot 'Dependencies\UpdatePackage.ps1'

		if ($PackageType -eq 'VBScript') {
			$Prefix = 'VB'
			$TempInstallScript = Join-Path $PSScriptRoot 'Dependencies\Install.cis'
			$TempUninstallScript = Join-Path $PSScriptRoot 'Dependencies\Uninstall.cis'
		} ElseIf ($PackageType -eq 'PowerPack') {
			$Prefix = 'PP'
			$TempInstallScript = Join-Path $PSScriptRoot 'Dependencies\Install.ps1'
			$TempUninstallScript = Join-Path $PSScriptRoot 'Dependencies\Uninstall.ps1'
		}

		$PackagePath = Join-Path $BasePath "Capa_$($Prefix)_$PackageName"
		$VersionPath = Join-Path $PackagePath $PackageVersion
		$ScriptPath = Join-Path $VersionPath 'Scripts'

		# Create folder
		New-Item -Path $ScriptPath -ItemType Directory -Force | Out-Null

		# Copy files
		Copy-Item -Path $GitIgnoreFile -Destination $PackagePath -Force | Out-Null

		# Copy UpdatePackage.ps1
		if ((Test-Path "$PackagePath\UpdatePackage.ps1") -eq $false) {
			$UpdatePackageScriptPath = Join-Path $PackagePath 'UpdatePackage.ps1'

			Copy-Item -Path $UpdatePackageScript -Destination $PackagePath -Force | Out-Null

			# Replace in UpdatePackage.ps1
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

		# Create scripts
		if ($PackageType -eq 'VBScript') {
			$InstallScriptDestination = Join-Path $ScriptPath "$PackageName.cis"
			$UninstallScriptDestination = Join-Path $ScriptPath "$($PackageName)_Uninstall.cis"

			$InstallContent = Get-Content $TempInstallScript
			$InstallContent = $InstallContent.Replace('PACKAGENAME', $PackageName)
			$InstallContent = $InstallContent.Replace('PACKAGEVERSION', $PackageVersion)
			$InstallContent = $InstallContent.Replace('CREATEDBY', $env:username)
			$InstallContent = $InstallContent.Replace('TIME', (Get-Date -Format 'dd-MM-yyyy HH:mm:ss'))
			New-Item -Path $InstallScriptDestination -ItemType File -Force | Out-Null
			$InstallContent | Out-File -FilePath $InstallScriptDestination -Force

			$UninstallContent = Get-Content $TempUninstallScript
			$UninstallContent = $UninstallContent.Replace('PACKAGENAME', $PackageName)
			$UninstallContent = $UninstallContent.Replace('PACKAGEVERSION', $PackageVersion)
			$UninstallContent = $UninstallContent.Replace('CREATEDBY', $env:username)
			$UninstallContent = $UninstallContent.Replace('TIME', (Get-Date -Format 'dd-MM-yyyy HH:mm:ss'))
			New-Item -Path $UninstallScriptDestination -ItemType File -Force | Out-Null
			$UninstallContent | Out-File -FilePath $UninstallScriptDestination -Force
		} else {
			Copy-Item -Path $TempInstallScript -Destination $ScriptPath -Force | Out-Null
			Copy-Item -Path $TempUninstallScript -Destination $ScriptPath -Force | Out-Null
		}
	} catch {

		$PSCmdlet.ThrowTerminatingError($PSitem)
		return -1
	}
}
