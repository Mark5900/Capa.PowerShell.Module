Import-Module Capa.PowerShell.Module
Import-Module SqlServer

$CapaServer = 'CISRVKURSUS'
$Database = 'CapaInstaller'
$DefaultManagementPointDev = '1'
$DefaultManagementPointProd = $null #Keep null if you don't have two enviroments

$oCMSDev = Initialize-CapaSDK -Server $CapaServer -Database $Database

function Update-CapaPackageScriptAndKit {
    param (
        [Parameter(Mandatory = $true)]
        [String]$PackageName,
        [Parameter(Mandatory = $true)]
        [String]$PackageVersion,
        [Parameter(Mandatory = $true)]
        [String]$ScriptContent,
        [Parameter(Mandatory = $true)]
        [ValidateSet('Install', 'Uninstall')]
        [String]$ScriptType,
        [Parameter(Mandatory = $true)]
        [ValidateSet('PowerPack', 'VBScript')]
        [String]$PackageType,
        [Parameter(Mandatory = $true, ParameterSetName = 'VBScript')]
        [Parameter(Mandatory = $true, ParameterSetName = 'PowerPackWithKit')]
        [Parameter(Mandatory = $true, ParameterSetName = 'VBScriptWithKit')]
        [String]$PackageFolderPath,
        [Parameter(Mandatory = $true, ParameterSetName = 'PowerPack')]
        [Parameter(Mandatory = $true, ParameterSetName = 'PowerPackWithKit')]
        [string]$SqlServerInstance,
        [Parameter(Mandatory = $true, ParameterSetName = 'PowerPack')]
        [Parameter(Mandatory = $true, ParameterSetName = 'PowerPackWithKit')]
        [string]$Database,
        [Parameter(Mandatory = $false, ParameterSetName = 'PowerPack')]
        [Parameter(Mandatory = $true, ParameterSetName = 'PowerPackWithKit')]
        [pscredential]$Credential = $null,
        [Parameter(Mandatory = $true, ParameterSetName = 'PowerPackWithKit')]
        [Parameter(Mandatory = $true, ParameterSetName = 'VBScriptWithKit')]
        [String]$KitFolderPath
    )
    
}