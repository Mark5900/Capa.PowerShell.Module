@{
	# Version number of this module.
	ModuleVersion          = '1.5.0'

	# ID used to uniquely identify this module
	GUID                   = '153c22bb-4705-4a73-847c-49bb1756c4a5'

	# Author of this module
	Author                 = 'Mark5900'

	# Company or vendor of this module
	CompanyName            = ''

	# Copyright statement for this module
	Copyright              = '(c) 2023. All rights reserved.'

	# Description of the functionality provided by this module
	Description            = 'PowerShell module for CapaInstaller containing functions for the SDK.'

	# Minimum version of the Windows PowerShell engine required by this module
	PowerShellVersion      = '7.0'

	# Name of the Windows PowerShell host required by this module
	PowerShellHostName     = ''

	# Minimum version of the Windows PowerShell host required by this module
	PowerShellHostVersion  = ''

	# Minimum version of the .NET Framework required by this module
	DotNetFrameworkVersion = '3.5'

	# Minimum version of the common language runtime (CLR) required by this module
	CLRVersion             = '2.0.50727'

	# Processor architecture (None, X86, Amd64, IA64) required by this module
	ProcessorArchitecture  = 'None'

	# Modules that must be imported into the global environment prior to importing
	# this module
	RequiredModules        = @(@{ ModuleName = 'Capa.PowerShell.Module.SDK.Authentication'; RequiredVersion = '1.5.0'; },
		@{ ModuleName = 'Capa.PowerShell.Module.SDK.Container'; RequiredVersion = '1.5.0'; },
		@{ ModuleName = 'Capa.PowerShell.Module.SDK.Group'; RequiredVersion = '1.5.0'; },
		@{ ModuleName = 'Capa.PowerShell.Module.SDK.Inventory'; RequiredVersion = '1.5.0'; },
		@{ ModuleName = 'Capa.PowerShell.Module.SDK.MDM'; RequiredVersion = '1.5.0'; },
		@{ ModuleName = 'Capa.PowerShell.Module.SDK.OSDeployment'; RequiredVersion = '1.5.0'; },
		@{ ModuleName = 'Capa.PowerShell.Module.SDK.Package'; RequiredVersion = '1.5.0'; },
		@{ ModuleName = 'Capa.PowerShell.Module.SDK.SystemSdk'; RequiredVersion = '1.5.0'; },
		@{ ModuleName = 'Capa.PowerShell.Module.SDK.Unit'; RequiredVersion = '1.5.0'; },
		@{ ModuleName = 'Capa.PowerShell.Module.SDK.User'; RequiredVersion = '1.5.0'; },
		@{ ModuleName = 'Capa.PowerShell.Module.SDK.Utilities'; RequiredVersion = '1.5.0'; },
		@{ ModuleName = 'Capa.PowerShell.Module.SDK.VPP'; RequiredVersion = '1.5.0'; },
		@{ ModuleName = 'Capa.PowerShell.Module.SDK.WSUS'; RequiredVersion = '1.5.0'; })

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
	FunctionsToExport      = '*' #For performance, list functions explicitly

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

			Tags       = @('CapaInstaller', 'SDK', 'CapaSystems')

		} # End of PSData hashtable

	} # End of PrivateData hashtable


}
