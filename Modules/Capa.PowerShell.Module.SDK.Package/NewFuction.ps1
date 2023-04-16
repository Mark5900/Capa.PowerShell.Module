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
        $GitIgnoreFile = Join-Path $PSScriptRoot 'Dependecies\.gitignore'
        $UpdatePackageScript = Join-Path $PSScriptRoot 'Dependecies\UpdatePackage.ps1'

        if ($PackageType -eq 'VB') {
            $Prefix = 'VB'
            $TempInstallScript = Join-Path $PSScriptRoot 'Dependecies\Install.cis'
            $TempUninstallScript = Join-Path $PSScriptRoot 'Dependecies\Uninstall.cis'
        } ElseIf ($PackageType -eq 'PowerPack') {
            $Prefix = 'PP'
            $TempInstallScript = Join-Path $PSScriptRoot 'Dependecies\Install.ps1'
            $TempUninstallScript = Join-Path $PSScriptRoot 'Dependecies\Uninstall.ps1'
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
        }

        # Create scripts
        if ($PackageType -eq 'VB') {
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


# Test
New-CapaPackageWithGit -PackageName 'Test' -PackageVersion 'v1.0' -PackageType 'VB' -BasePath 'D:\PowerShell'
#New-CapaPackageWithGit -PackageName 'Test2' -PackageVersion 'v1.0' -PackageType 'PowerPack' -BasePath 'D:\PowerShell' -CapaServer $CapaServer -Database $Database -DefaultManagementPoint $DefaultManagementPointDev