Import-Module Capa.PowerShell.Module
Import-Module SqlServer

$CapaServer = 'CISRVKURSUS'
$Database = 'CapaInstaller'
$DefaultManagementPointDev = '1'
$DefaultManagementPointProd = $null #Keep null if you don't have two enviroments

$oCMSDev = Initialize-CapaSDK -Server $CapaServer -Database $Database

New-CapaPowerPack -CapaSDK $oCMSDev -PackageName 'Test1' -PackageVersion 'v1.0' -DisplayName 'Test1' -SqlServerInstance $CapaServer -Database $Database
New-CapaPowerPack -CapaSDK $oCMSDev -PackageName 'Test2' -PackageVersion 'v1.0' -DisplayName 'Test2' -InstallScriptContent "Write-Host 'Test2 Install Script'" -UninstallScriptContent "Write-Host 'Test2 Uninstall Script'" -SqlServerInstance $CapaServer -Database $Database
New-CapaPowerPack -CapaSDK $oCMSDev -PackageName 'Test3' -PackageVersion 'v1.0' -DisplayName 'Test3' -KitFolderPath 'D:\CapaInstaller\CMPProduction\ComputerJobs\7-Zip 22.00 EN\v2.0\Kit' -SqlServerInstance $CapaServer -Database $Database