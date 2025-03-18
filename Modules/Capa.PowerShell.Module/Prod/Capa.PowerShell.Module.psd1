@{
	# Version number of this module.
	ModuleVersion          = '1.12.3'

	# ID used to uniquely identify this module
	GUID                   = '517a4a6a-a4f8-4a8b-bf99-5fe75a1e7786'

	# Author of this module
	Author                 = 'Mark5900'

	# Company or vendor of this module
	CompanyName            = ''

	# Copyright statement for this module
	Copyright              = ''

	# Description of the functionality provided by this module
	Description            = 'This module contains cmdlets for CapaInstaller SDK and PowerPack.'

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
	RequiredModules        = @(@{ ModuleName = 'Capa.PowerShell.Module.SDK'; RequiredVersion = '1.12.3'; },
		@{ ModuleName = 'Capa.PowerShell.Module.PowerPack'; RequiredVersion = '1.12.3'; })

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
	FunctionsToExport      = @() #For performance, list functions explicitly

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

			Tags       = @('CapaInstaller', 'SDK', 'PowerPack', 'CapaSystems')

		} # End of PSData hashtable



	} # End of PrivateData hashtable
}
