<#
    .SYNOPSIS
        Use this function to update a package script and kit in Capa.

    .DESCRIPTION
        Use this function to update a package script and kit in Capa.
        You will need SqlServer module installed if you want to update a PowerPack script.

    .PARAMETER PackageName
        The name of the package.

    .PARAMETER PackageVersion
        The version of the package.

    .PARAMETER ScriptContent
        The content of the script.

    .PARAMETER ScriptType
        The type of the script. Valid values are: Install, Uninstall, UserConfiguration.

    .PARAMETER PackageType
        The type of the package. Valid values are: PowerPack, VBScript.

    .PARAMETER PackageBasePath
        The path to the package folder. Example: \\CISRVKURSUS.CIKURSUS.local\CMPProduction\ComputerJobs

    .PARAMETER SqlServerInstance
        The name of the SQL Server instance.

    .PARAMETER Database
        The name of the database.

    .PARAMETER Credential
        The credentials to use when connecting to the SQL Server instance.
        Default is to use the current user's credentials.

    .PARAMETER KitFolderPath
        The path to the folder containing files to set as kit.

	.EXAMPLE
		$ScriptContent = Get-Content -Path 'C:\Users\CIKursus\Downloads\InstallScript.ps1' | Out-String
		Update-CapaPackageScriptAndKit -PackageName 'Test1' -PackageVersion 'v1.0' -ScriptContent $ScriptContent -ScriptType 'Install' -PackageType 'PowerPack' -SqlServerInstance $CapaServer -Database $Database

    .EXAMPLE
        Update-CapaPackageScriptAndKit -PackageName 'Test1' -PackageVersion 'v1.0' -ScriptContent "Write-Host 'Hello World'" -ScriptType 'Install' -PackageType 'PowerPack' -SqlServerInstance $CapaServer -Database $Database

    .EXAMPLE
        Update-CapaPackageScriptAndKit -PackageName 'Test1' -PackageVersion 'v1.0' -ScriptContent "Write-Host 'Hello World'" -ScriptType 'Uninstall' -PackageType 'PowerPack' -SqlServerInstance $CapaServer -Database $Database

    .EXAMPLE
        Update-CapaPackageScriptAndKit -PackageName 'Test1' -PackageVersion 'v1.0' -ScriptContent "Write-Host 'Hello World'" -ScriptType 'Install' -PackageType 'PowerPack' -SqlServerInstance $CapaServer -Database $Database -PackageBasePath 'D:\CapaInstaller\CMPProduction\ComputerJobs' -KitFolderPath 'C:\Users\CIKursus\Downloads\Kit'

    .EXAMPLE
        Update-CapaPackageScriptAndKit -PackageName 'Opgave 1' -PackageVersion 'v1.0' -ScriptContent "Write-Host 'Hello World'" -ScriptType 'Install' -PackageType 'VBScript' -PackageBasePath 'D:\CapaInstaller\CMPProduction\ComputerJobs'

    .EXAMPLE
        Update-CapaPackageScriptAndKit -PackageName 'Opgave 1' -PackageVersion 'v1.0' -ScriptContent "Write-Host 'Hello World'" -ScriptType 'Uninstall' -PackageType 'VBScript' -PackageBasePath 'D:\CapaInstaller\CMPProduction\ComputerJobs'

    .EXAMPLE
        Update-CapaPackageScriptAndKit -PackageName 'Opgave 1' -PackageVersion 'v1.0' -PackageBasePath 'D:\CapaInstaller\CMPProduction\ComputerJobs' -KitFolderPath 'C:\Users\CIKursus\Downloads\Kit\'

    .NOTES
        This is a custom function that is not part of the CapaSDK
#>
function Update-CapaPackageScriptAndKit {
	param (
		[Parameter(Mandatory = $true)]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[String]$PackageVersion,
		[Parameter(Mandatory = $true, ParameterSetName = 'PowerPack')]
		[Parameter(Mandatory = $true, ParameterSetName = 'VBScript')]
		[Parameter(Mandatory = $true, ParameterSetName = 'PowerPackWithKit')]
		[Parameter(Mandatory = $true, ParameterSetName = 'VBScriptWithKit')]
		[String]$ScriptContent,
		[Parameter(Mandatory = $true, ParameterSetName = 'PowerPack')]
		[Parameter(Mandatory = $true, ParameterSetName = 'VBScript')]
		[Parameter(Mandatory = $true, ParameterSetName = 'PowerPackWithKit')]
		[Parameter(Mandatory = $true, ParameterSetName = 'VBScriptWithKit')]
		[ValidateSet('Install', 'Uninstall', 'UserConfiguration')]
		[String]$ScriptType,
		[Parameter(Mandatory = $true, ParameterSetName = 'PowerPack')]
		[Parameter(Mandatory = $true, ParameterSetName = 'VBScript')]
		[Parameter(Mandatory = $true, ParameterSetName = 'PowerPackWithKit')]
		[Parameter(Mandatory = $true, ParameterSetName = 'VBScriptWithKit')]
		[ValidateSet('PowerPack', 'VBScript')]
		[String]$PackageType,
		[Parameter(Mandatory = $true, ParameterSetName = 'VBScript')]
		[Parameter(Mandatory = $true, ParameterSetName = 'PowerPackWithKit')]
		[Parameter(Mandatory = $true, ParameterSetName = 'VBScriptWithKit')]
		[Parameter(Mandatory = $true, ParameterSetName = 'Kit')]
		[String]$PackageBasePath,
		[Parameter(Mandatory = $true, ParameterSetName = 'PowerPack')]
		[Parameter(Mandatory = $true, ParameterSetName = 'PowerPackWithKit')]
		[string]$SqlServerInstance,
		[Parameter(Mandatory = $true, ParameterSetName = 'PowerPack')]
		[Parameter(Mandatory = $true, ParameterSetName = 'PowerPackWithKit')]
		[string]$Database,
		[Parameter(Mandatory = $false, ParameterSetName = 'PowerPack')]
		[Parameter(Mandatory = $false, ParameterSetName = 'PowerPackWithKit')]
		[pscredential]$Credential,
		[Parameter(Mandatory = $true, ParameterSetName = 'PowerPackWithKit')]
		[Parameter(Mandatory = $true, ParameterSetName = 'VBScriptWithKit')]
		[Parameter(Mandatory = $true, ParameterSetName = 'Kit')]
		[String]$KitFolderPath
	)
	# Parameters
	if ([string]::IsNullOrEmpty($PackageBasePath) -eq $false) {
		if ($PackageBasePath -like "*\$PackageVersion" -or $PackageBasePath -like "*\$PackageVersion\") {
			$PackagePath = $PackageBasePath
		} elseif ($PackageBasePath -like "*\$PackageName" -or $PackageBasePath -like "*\$PackageName\") {
			$PackagePath = Join-Path $PackageBasePath $PackageVersion
		} else {
			$PackagePath = Join-Path $PackageBasePath $PackageName $PackageVersion
		}

		if ((Test-Path $PackagePath) -eq $false) {
			Write-Error "PackagePath: $PackagePath does not exist"
			throw 'Cannot find the package. Check PackageBasePath'
		}

		$ScriptPath = Join-Path $PackagePath 'Scripts' $ScriptName
		$KitPath = Join-Path $PackagePath 'Kit'
	}

	if ($ScriptType -eq 'Install') {
		$ScriptName = "$PackageName.cis"
		$DBColumnName = 'INSTALLSCRIPTCONTENT'
	} elseif ($ScriptType -eq 'Uninstall') {
		$ScriptName = "$($PackageName)_Uninstall.cis"
		$DBColumnName = 'UNINSTALLSCRIPTCONTENT'
	} elseif ($ScriptType -eq 'UserConfiguration') {
		$ScriptName = "$($PackageName)_Us.cis"
		$DBColumnName = 'USERCONFIGSCRIPTCONTENT'
	}

	if ([string]::IsNullOrEmpty($ScriptPath) -eq $false) {
		$ScriptFile = Join-Path $ScriptPath $ScriptName
	}

	# Script
	try {
		# Update script
		if ($PSCmdlet.ParameterSetName -like 'PowerPack*') {
			$ScriptContentBytes = [System.Text.Encoding]::UTF8.GetBytes("$ScriptContent")
			$ScriptContentBase64 = [System.Convert]::ToBase64String($ScriptContentBytes)

			$SqlQuery = "UPDATE JOB
            Set $DBColumnName = '$ScriptContentBase64'
            Where NAME = '$PackageName'
            AND VERSION = '$PackageVersion'"

			If ($Credential) {
				Invoke-Sqlcmd -ServerInstance $SqlServerInstance -Database $Database -Query $SqlQuery -Credential $Credential -TrustServerCertificate
			} else {
				Invoke-Sqlcmd -ServerInstance $SqlServerInstance -Database $Database -Query $SqlQuery -TrustServerCertificate
			}
		}
		If ($PSCmdlet.ParameterSetName -like 'VBScript*') {
			Set-Content -Path $ScriptFile -Value $ScriptContent -Force
		}

		# Update Kit
		If ($PSCmdlet.ParameterSetName -like '*Kit') {
			Get-ChildItem -Path $KitPath -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force | Out-Null
			Copy-Item -Path "$KitFolderPath\*" -Destination $KitPath -Recurse -Force | Out-Null
		}

		return $true
	} catch {
		throw $PSitem
	}

}
