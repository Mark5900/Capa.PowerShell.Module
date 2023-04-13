Import-Module Capa.PowerShell.Module
Import-Module SqlServer

$CapaServer = 'CISRVKURSUS'
$Database = 'CapaInstaller'
$DefaultManagementPointDev = '1'
$DefaultManagementPointProd = $null #Keep null if you don't have two enviroments

$oCMSDev = Initialize-CapaSDK -Server $CapaServer -Database $Database

# TestFunction
function New-CapaPackageWithGit {
    param (
        [Parameter(Mandatory = $true)]
        [string]$PackageName,
        [Parameter(Mandatory = $true)]
        [string]$PackageVersion,
        [Parameter(Mandatory = $true)]
        [ValidateSet('VB', 'PowerPack')]
        [string]$PackageType,
        [Parameter(Mandatory = $true)]
        [string]$BasePath,
        $CapaServer,
        $Database,
        $DefaultManagementPoint
    )
    try {
        # Parameters
        $GitIgnoreFile = Join-Path $PSScriptRoot 'Dependencies\.gitignore'

        if ($PackageType -eq 'VB') {
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
        #TODO: Make script to support development

        # Create scripts
        if ($PackageType -eq 'VB') {
            $InstallScriptDestination = Join-Path $ScriptPath '$PackageName.cis'
            $UninstallScriptDestination = Join-Path $ScriptPath '$PackageName__Uninstall.cis'

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
