# TODO: #179 Update and add tests

<#
    .SYNOPSIS
        Creates a new PowerPack in CapaInstaller

    .DESCRIPTION
        Creates a new PowerPack in CapaInstaller using the CapaSDK and the SqlServer module

    .PARAMETER CapaSDK
        The CapaSDK object

    .PARAMETER PackageName
        The name of the package

    .PARAMETER PackageVersion
        The version of the package

    .PARAMETER DisplayName
        The display name of the package, if not specified then the package name and version will be used

    .PARAMETER InstallScriptContent
        The install script content of the package, if not specified then the default install script will be used

    .PARAMETER UninstallScriptContent
        The uninstall script content of the package, if not specified then the default uninstall script will be used

    .PARAMETER KitFolderPath
        The path to the kit folder, if not specified then a dummy kit folder will be created

    .PARAMETER ChangelogComment
        The changelog comment of the package

    .PARAMETER SqlServerInstance
        The SQL Server instance

    .PARAMETER Database
        The Capa database name

    .PARAMETER Credential
        The SQL Server credential

    .EXAMPLE
        New-CapaPowerPack -CapaSDK $oCMSDev -PackageName 'Test1' -PackageVersion 'v1.0' -DisplayName 'Test1' -SqlServerInstance $CapaServer -Database $Database

    .Example
        New-CapaPowerPack -CapaSDK $oCMSDev -PackageName 'Test1' -PackageVersion 'v1.0' -DisplayName 'Test1' -InstallScriptContent 'Write-Host "Hello World"' -SqlServerInstance $CapaServer -Database $Database

    .Example
        New-CapaPowerPack -CapaSDK $oCMSDev -PackageName 'Test1' -PackageVersion 'v1.0' -DisplayName 'Test1' -KitFolderPath 'C:\Temp\Kit' -SqlServerInstance $CapaServer -Database $Database

    .Notes
        This is a custom function that is not part of the CapaSDK
#>
function New-CapaPowerPack {
	param (
		[Parameter(Mandatory = $true)]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[String]$PackageVersion,
		[string]$DisplayName = "$PackageName $PackageVersion",
		[String]$InstallScriptContent,
		[String]$UninstallScriptContent,
		[String]$KitFolderPath,
		[string]$ChangelogComment = '',
		[Parameter(Mandatory = $true)]
		[string]$SqlServerInstance,
		[Parameter(Mandatory = $true)]
		[string]$Database,
		[pscredential]$Credential = $null
	)
	$XMLFile = Join-Path $PSScriptRoot 'Dependencies' 'ciPackage.xml'
	$KitFile = Join-Path $PSScriptRoot 'Dependencies' 'CapaInstaller.kit'
	$TempFolder = "C:\Users\$env:UserName\AppData\Local\CapaInstaller\CMS\TempScripts"
	$TempTempFolder = Join-Path $TempFolder 'Temp'
	$PackageTempFolder = Join-Path $TempTempFolder "$($PackageName)_$($PackageVersion)"
	$PackageZipFile = Join-Path $TempTempFolder "$($PackageName)_$($PackageVersion).zip"


	Try {
		# Create Temp Folder
		If (!(Test-Path $TempFolder)) {
			New-Item -ItemType Directory -Path $TempTempFolder -Force | Out-Null
		}
		New-Item -ItemType Directory -Path "$PackageTempFolder\Zip" -Force | Out-Null
		Copy-Item -Path $KitFile -Destination "$PackageTempFolder\Zip\CapaInstaller.kit" -Force | Out-Null
		New-Item -ItemType Directory -Path "$PackageTempFolder\Scripts" -Force | Out-Null

		# Create XML File
		$XML = [xml](Get-Content $XMLFile)
		$XML.Info.Package.Name = $PackageName
		$XML.Info.Package.Version = $PackageVersion
		$XML.Info.Package.DisplayName = $DisplayName

		If ([string]::IsNullOrEmpty($InstallScriptContent) -eq $false) {
			$InstallScriptContentBytes = [System.Text.Encoding]::UTF8.GetBytes("$InstallScriptContent")
			$XML.Info.Package.InstallScriptContent = [System.Convert]::ToBase64String($InstallScriptContentBytes)
		}

		If ([string]::IsNullOrEmpty($UninstallScriptContent) -eq $false) {
			$UninstallScriptContentBytes = [System.Text.Encoding]::UTF8.GetBytes("$UninstallScriptContent")
			$XML.Info.Package.UnInstallScriptContent = [System.Convert]::ToBase64String($UninstallScriptContentBytes)
		}

		Set-Content -Path "$PackageTempFolder\ciPackage.xml" -Value $XML.OuterXml

		# Create kit folder
		If ([string]::IsNullOrEmpty($KitFolderPath) -eq $false) {
			Copy-Item -Path $KitFolderPath -Destination "$PackageTempFolder\Kit" -Recurse -Force | Out-Null
		} else {
			New-Item -ItemType Directory -Path "$PackageTempFolder\Kit" -Force | Out-Null
			New-Item -ItemType File -Path "$PackageTempFolder\Kit\Dummy.txt" -Force | Out-Null
			Add-Content -Value 'Placeholder for the build of CapaInstaller.kit' -Path "$PackageTempFolder\Kit\Dummy.txt"
		}

		# Create zip file
		Compress-Archive -Path "$PackageTempFolder\*" -DestinationPath $PackageZipFile -Force | Out-Null

		# Add to CI
		$Status = Import-CapaPackage -CapaSDK $CapaSDK -FilePath $PackageZipFile -OverrideCIPCdata $true -ImportFolderStructure $true -ImportSchedule $true -ChangelogComment $ChangelogComment

		# The SDK is missing support for PowerPack, so we need to use SqlServer module to edit in job table
		$Query = "UPDATE JOB
    Set POWERPACK = 'True', INSTALLSCRIPTCONTENT = '$($XML.Info.Package.InstallScriptContent)', UNINSTALLSCRIPTCONTENT =' $($XML.Info.Package.UnInstallScriptContent)'
    Where NAME = '$PackageName'
    AND VERSION = '$PackageVersion'"

		if ($Null -eq $Credential) {
			Invoke-Sqlcmd -ServerInstance $SqlServerInstance -Database $Database -Query $Query -TrustServerCertificate
		} else {
			Invoke-Sqlcmd -ServerInstance $SqlServerInstance -Database $Database -Query $Query -Credential $Credential
		}

		# Remove Temp Folder
		Remove-Item -Path $TempTempFolder -Recurse -Force | Out-Null

		return $Status
	} Catch {
		$PSCmdlet.ThrowTerminatingError($PSitem)
		return -1
	}
}
