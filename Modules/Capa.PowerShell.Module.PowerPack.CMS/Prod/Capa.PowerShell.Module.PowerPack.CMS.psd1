@{

	# Script module or binary module file associated with this manifest
	RootModule             = '.\Capa.PowerShell.Module.PowerPack.CMS.psm1'

	# Version number of this module.
	ModuleVersion          = '1.12.0'

	# ID used to uniquely identify this module
	GUID                   = 'ee5f81a6-b062-4484-8f64-86ed506c3a9e'

	# Author of this module
	Author                 = 'Mark5900'

	# Company or vendor of this module
	CompanyName            = ''

	# Copyright statement for this module
	Copyright              = ''

	# Description of the functionality provided by this module
	Description            = 'PowerShell module for CapaInstaller PowerPacks containing functions for CMS commands.
	For more information, see https://capasystems.atlassian.net/wiki/spaces/CI67DOC/pages/20342578761/PowerShell+Scripting+Library'

	# Minimum version of the Windows PowerShell engine required by this module
	PowerShellVersion      = '7.4'

	# Name of the Windows PowerShell host required by this module
	PowerShellHostName     = ''

	# Minimum version of the Windows PowerShell host required by this module
	PowerShellHostVersion  = ''

	# Minimum version of the .NET Framework required by this module
	DotNetFrameworkVersion = ''

	# Minimum version of the common language runtime (CLR) required by this module
	CLRVersion             = '2.0.50727'

	# Processor architecture (None, X86, Amd64, IA64) required by this module
	ProcessorArchitecture  = 'None'

	# Modules that must be imported into the global environment prior to importing
	# this module
	RequiredModules        = @()

	# Assemblies that must be loaded prior to importing this module
	RequiredAssemblies     = @()

	# Script files (.ps1) that are run in the caller's environment prior to
	# importing this module
	ScriptsToProcess       = @()

	# Type files (.ps1xml) to be loaded when importing this module
	TypesToProcess         = @()

	# Format files (.ps1xml) to be loaded when importing this module
	FormatsToProcess       = @()

	# Modules to import as nested modules of the module specified in
	# ModuleToProcess
	NestedModules          = @()

	# Functions to export from this module
	FunctionsToExport      = 'Add-PpCMSComputerToCalendarGroup',
    'Add-PpCMSComputerToDepartmentGroup',
    'Add-PpCMSComputerToPowerSchemeGroup',
    'Add-PpCMSComputerToReinstallGroup',
    'Add-PpCMSComputerToStaticGroup',
    'Add-PpCMSCustomInventory',
    'Add-PpCMSHardwareInventory',
    'Add-PpCMSPackageToUnit',
    'Add-PpCMSUnitToBusinessUnit',
    'Get-PpCMSAdvertisedPackages',
    'Get-PpCMSDeploymentTemplateVariable',
    'Get-PpCMSGroupMembership',
    'Get-PpCMSIsPackageLinked',
    'Get-PpCMSIsPackageScheduleEnabled',
    'Get-PpCMSPackage',
    'Get-PpCMSPackageStatus',
    'Get-PpCMSProperty',
    'Initialize-PpCMSRerunPackage',
    'Install-PpCMSAdvertisedPackage',
    'Invoke-PpCMSRunSystemAgent',
    'Invoke-PpCMSRunUserAgent',
		'Invoke-PpJobRetryLater',
    'Remove-PpCMSComputerFromCalendarGroup',
    'Remove-PpCMSComputerFromDepartmentGroup',
    'Remove-PpCMSComputerFromPowerSchemeGroup',
    'Remove-PpCMSComputerFromReinstallGroup',
    'Remove-PpCMSComputerFromStaticGroup',
    'Remove-PpCMSCustomInventory',
    'Remove-PpCMSHardwareInventory',
    'Remove-PpCMSPackageFromUnit',
    'Reset-PpCMSCustomInventory',
    'Set-PpCMSCurrentUser',
    'Set-PpCMSPackageStatusToInstalled',
    'Set-PpCMSPackageStatusToNotCompliant',
    'Test-PpCMSExistPackageOnManagementServer',
    'Uninstall-PpCMSPackageFromUnit'
	#For performance, list functions explicitly

	# Cmdlets to export from this module
	CmdletsToExport        = '*'

	# Variables to export from this module
	VariablesToExport      = '*'

	# Aliases to export from this module
	AliasesToExport        = '*' #For performance, list alias explicitly

	# DSC class resources to export from this module.
	#DSCResourcesToExport = ''

	# List of all modules packaged with this module
	ModuleList             = @()

	# List of all files packaged with this module
	FileList               = @()

	# Private data to pass to the module specified in ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
	PrivateData            = @{

		#Support for PowerShellGet galleries.
		PSData = @{

			ProjectUri = 'https://github.com/Mark5900/Capa.PowerShell.Module'

			LicenseUri = 'https://github.com/Mark5900/Capa.PowerShell.Module/blob/main/LICENSE'

			Tags       = @('CapaInstaller', 'PowerPack', 'CapaSystems')

		} # End of PSData hashtable

	} # End of PrivateData hashtable


}
