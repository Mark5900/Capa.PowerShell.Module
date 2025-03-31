#
# Module manifest for module 'Capa.PowerShell.Module.SDK.SystemSdk'
#
# Generated by: Mark5900
#
# Generated on: 3/31/2025
#

@{

# Script module or binary module file associated with this manifest.
RootModule = './Capa.PowerShell.Module.SDK.SystemSdk.psm1'

# Version number of this module.
ModuleVersion = '1.13.2'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '06c7c9b0-705e-4a88-aa0d-a284b797b031'

# Author of this module
Author = 'Mark5900'

# Company or vendor of this module
CompanyName = 'Unknown'

# Copyright statement for this module
Copyright = '(c) Mark5900. All rights reserved.'

# Description of the functionality provided by this module
Description = 'PowerShell module for CapaInstaller SDK containing functions for System functions.
	For more information, see https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19382173123/SDK+-+CapaInstaller+Software+Development+Kit+functions'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '7.0'

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
ClrVersion = '2.0.50727'

# Processor architecture (None, X86, Amd64) required by this module
ProcessorArchitecture = 'None'

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'Count-CapaConscomActions', 'Get-CapaBusinessUnits', 
               'Get-CapaExternalTools', 'Get-CapaManagementPoint', 
               'Get-CapaManagementServers', 'Rebuild-CapaKitFileOnPoint', 
               'Rebuild-CapaKitFileOnManagementServer', 
               'Reset-CapaLastRunDateOnGlobalTask'

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = '*'

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = '*'

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'CapaInstaller', 'SDK', 'CapaSystems'

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/Mark5900/Capa.PowerShell.Module/blob/main/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/Mark5900/Capa.PowerShell.Module'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        # ReleaseNotes = ''

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

