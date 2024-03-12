<#
	.SYNOPSIS
		Get the error message for a WinGet error code.

	.DESCRIPTION
		Get the error message for a WinGet error code.

	.PARAMETER Decimal
		The error code in decimal.

	.EXAMPLE
		Get-PpWingetReturnCodeDescription -Decimal -1978335231

	.NOTES
		Custom function not from CapaSystems.
		Source: https://github.com/microsoft/winget-cli/blob/master/doc/windows/package-manager/winget/returnCodes.md
#>
function Get-PpWingetReturnCodeDescription {
	param (
		[Parameter(Mandatory = $true)]
		[int]$Decimal
	)
	switch ($Decimal) {
		0 {
			Job_WriteLog -Text 'Command completed successfully'
			return 'Command completed successfully'
		}
		-1978335231 {
			Job_WriteLog -Text 'Internal Error'
			return 'Internal Error'
		}
		-1978335230 {
			Job_WriteLog -Text 'Invalid command line arguments'
			return 'Invalid command line arguments'
		}
		-1978335229 {
			Job_WriteLog -Text 'Executing command failed'
			return 'Executing command failed'
		}
		-1978335228 {
			Job_WriteLog -Text 'Opening manifest failed'
			return 'Opening manifest failed'
		}
		-1978335227 {
			Job_WriteLog -Text 'Cancellation signal received'
			return 'Cancellation signal received'
		}
		-1978335226 {
			Job_WriteLog -Text 'Running ShellExecute failed'
			return 'Running ShellExecute failed'
		}
		-1978335225 {
			Job_WriteLog -Text 'Cannot process manifest. The manifest version is higher than supported. Please update the client.'
			return 'Cannot process manifest. The manifest version is higher than supported. Please update the client.'
		}
		-1978335224 {
			Job_WriteLog -Text 'Downloading installer failed'
			return 'Downloading installer failed'
		}
		-1978335223 {
			Job_WriteLog -Text 'Cannot write to index; it is a higher schema version'
			return 'Cannot write to index; it is a higher schema version'
		}
		-1978335222 {
			Job_WriteLog -Text 'The index is corrupt'
			return 'The index is corrupt'
		}
		-1978335221 {
			Job_WriteLog -Text 'The configured source information is corrupt'
			return 'The configured source information is corrupt'
		}
		-1978335220 {
			Job_WriteLog -Text 'The source name is already configured'
			return 'The source name is already configured'
		}
		-1978335219 {
			Job_WriteLog -Text 'The source type is invalid'
			return 'The source type is invalid'
		}
		-1978335218 {
			Job_WriteLog -Text 'The MSIX file is a bundle, not a package'
			return 'The MSIX file is a bundle, not a package'
		}
		-1978335217 {
			Job_WriteLog -Text 'Data required by the source is missing'
			return 'Data required by the source is missing'
		}
		-1978335216 {
			Job_WriteLog -Text 'None of the installers are applicable for the current system'
			return 'None of the installers are applicable for the current system'
		}
		-1978335215 {
			Job_WriteLog -Text 'The installer file''s hash does not match the manifest'
			return 'The installer file''s hash does not match the manifest'
		}
		-1978335214 {
			Job_WriteLog -Text 'The source name does not exist'
			return 'The source name does not exist'
		}
		-1978335213 {
			Job_WriteLog -Text 'The source location is already configured under another name'
			return 'The source location is already configured under another name'
		}
		-1978335212 {
			Job_WriteLog -Text 'No packages found'
			return 'No packages found'
		}
		-1978335211 {
			Job_WriteLog -Text 'No sources are configured'
			return 'No sources are configured'
		}
		-1978335210 {
			Job_WriteLog -Text 'Multiple packages found matching the criteria'
			return 'Multiple packages found matching the criteria'
		}
		-1978335209 {
			Job_WriteLog -Text 'No manifest found matching the criteria'
			return 'No manifest found matching the criteria'
		}
		-1978335208 {
			Job_WriteLog -Text 'Failed to get Public folder from source package'
			return 'Failed to get Public folder from source package'
		}
		-1978335207 {
			Job_WriteLog -Text 'Command requires administrator privileges to run'
			return 'Command requires administrator privileges to run'
		}
		-1978335206 {
			Job_WriteLog -Text 'The source location is not secure'
			return 'The source location is not secure'
		}
		-1978335205 {
			Job_WriteLog -Text 'The Microsoft Store client is blocked by policy'
			return 'The Microsoft Store client is blocked by policy'
		}
		-1978335204 {
			Job_WriteLog -Text 'The Microsoft Store app is blocked by policy'
			return 'The Microsoft Store app is blocked by policy'
		}
		-1978335203 {
			Job_WriteLog -Text 'The feature is currently under development. It can be enabled using winget settings.'
			return 'The feature is currently under development. It can be enabled using winget settings.'
		}
		-1978335202 {
			Job_WriteLog -Text 'Failed to install the Microsoft Store app'
			return 'Failed to install the Microsoft Store app'
		}
		-1978335201 {
			Job_WriteLog -Text 'Failed to perform auto complete'
			return 'Failed to perform auto complete'
		}
		-1978335200 {
			Job_WriteLog -Text 'Failed to initialize YAML parser'
			return 'Failed to initialize YAML parser'
		}
		-1978335199 {
			Job_WriteLog -Text 'Encountered an invalid YAML key'
			return 'Encountered an invalid YAML key'
		}
		-1978335198 {
			Job_WriteLog -Text 'Encountered a duplicate YAML key'
			return 'Encountered a duplicate YAML key'
		}
		-1978335197 {
			Job_WriteLog -Text 'Invalid YAML operation'
			return 'Invalid YAML operation'
		}
		-1978335196 {
			Job_WriteLog -Text 'Failed to build YAML doc'
			return 'Failed to build YAML doc'
		}
		-1978335195 {
			Job_WriteLog -Text 'Invalid YAML emitter state'
			return 'Invalid YAML emitter state'
		}
		-1978335194 {
			Job_WriteLog -Text 'Invalid YAML data'
			return 'Invalid YAML data'
		}
		-1978335193 {
			Job_WriteLog -Text 'LibYAML error'
			return 'LibYAML error'
		}
		-1978335192 {
			Job_WriteLog -Text 'Manifest validation succeeded with warning'
			return 'Manifest validation succeeded with warning'
		}
		-1978335191 {
			Job_WriteLog -Text 'Manifest validation failed'
			return 'Manifest validation failed'
		}
		-1978335190 {
			Job_WriteLog -Text 'Manifest is invalid'
			return 'Manifest is invalid'
		}
		-1978335189 {
			Job_WriteLog -Text 'No applicable update found'
			return 'No applicable update found'
		}
		-1978335188 {
			Job_WriteLog -Text 'winget upgrade --all completed with failures'
			return 'winget upgrade --all completed with failures'
		}
		-1978335187 {
			Job_WriteLog -Text 'Installer failed security check'
			return 'Installer failed security check'
		}
		-1978335186 {
			Job_WriteLog -Text 'Download size does not match expected content length'
			return 'Download size does not match expected content length'
		}
		-1978335185 {
			Job_WriteLog -Text 'Uninstall command not found'
			return 'Uninstall command not found'
		}
		-1978335184 {
			Job_WriteLog -Text 'Running uninstall command failed'
			return 'Running uninstall command failed'
		}
		-1978335183 {
			Job_WriteLog -Text 'ICU break iterator error'
			return 'ICU break iterator error'
		}
		-1978335182 {
			Job_WriteLog -Text 'ICU casemap error'
			return 'ICU casemap error'
		}
		-1978335181 {
			Job_WriteLog -Text 'ICU regex error'
			return 'ICU regex error'
		}
		-1978335180 {
			Job_WriteLog -Text 'Failed to install one or more imported packages'
			return 'Failed to install one or more imported packages'
		}
		-1978335179 {
			Job_WriteLog -Text 'Could not find one or more requested packages'
			return 'Could not find one or more requested packages'
		}
		-1978335178 {
			Job_WriteLog -Text 'Json file is invalid'
			return 'Json file is invalid'
		}
		-1978335177 {
			Job_WriteLog -Text 'The source location is not remote'
			return 'The source location is not remote'
		}
		-1978335176 {
			Job_WriteLog -Text 'The configured rest source is not supported'
			return 'The configured rest source is not supported'
		}
		-1978335175 {
			Job_WriteLog -Text 'Invalid data returned by rest source'
			return 'Invalid data returned by rest source'
		}
		-1978335174 {
			Job_WriteLog -Text 'Operation is blocked by Group Policy'
			return 'Operation is blocked by Group Policy'
		}
		-1978335173 {
			Job_WriteLog -Text 'Rest source internal error'
			return 'Rest source internal error'
		}
		-1978335172 {
			Job_WriteLog -Text 'Invalid rest source url'
			return 'Invalid rest source url'
		}
		-1978335171 {
			Job_WriteLog -Text 'Unsupported MIME type returned by rest source'
			return 'Unsupported MIME type returned by rest source'
		}
		-1978335170 {
			Job_WriteLog -Text 'Invalid rest source contract version'
			return 'Invalid rest source contract version'
		}
		-1978335169 {
			Job_WriteLog -Text 'The source data is corrupted or tampered'
			return 'The source data is corrupted or tampered'
		}
		-1978335168 {
			Job_WriteLog -Text 'Error reading from the stream'
			return 'Error reading from the stream'
		}
		-1978335167 {
			Job_WriteLog -Text 'Package agreements were not agreed to'
			return 'Package agreements were not agreed to'
		}
		-1978335166 {
			Job_WriteLog -Text 'Error reading input in prompt'
			return 'Error reading input in prompt'
		}
		-1978335165 {
			Job_WriteLog -Text 'The search request is not supported by one or more sources'
			return 'The search request is not supported by one or more sources'
		}
		-1978335164 {
			Job_WriteLog -Text 'The rest source endpoint is not found.'
			return 'The rest source endpoint is not found.'
		}
		-1978335163 {
			Job_WriteLog -Text 'Failed to open the source.'
			return 'Failed to open the source.'
		}
		-1978335162 {
			Job_WriteLog -Text 'Source agreements were not agreed to'
			return 'Source agreements were not agreed to'
		}
		-1978335161 {
			Job_WriteLog -Text 'Header size exceeds the allowable limit of 1024 characters. Please reduce the size and try again.'
			return 'Header size exceeds the allowable limit of 1024 characters. Please reduce the size and try again.'
		}
		-1978335160 {
			Job_WriteLog -Text 'Missing resource file'
			return 'Missing resource file'
		}
		-1978335159 {
			Job_WriteLog -Text 'Running MSI install failed'
			return 'Running MSI install failed'
		}
		-1978335158 {
			Job_WriteLog -Text 'Arguments for msiexec are invalid'
			return 'Arguments for msiexec are invalid'
		}
		-1978335157 {
			Job_WriteLog -Text 'Failed to open one or more sources'
			return 'Failed to open one or more sources'
		}
		-1978335156 {
			Job_WriteLog -Text 'Failed to validate dependencies'
			return 'Failed to validate dependencies'
		}
		-1978335155 {
			Job_WriteLog -Text 'One or more package is missing'
			return 'One or more package is missing'
		}
		-1978335154 {
			Job_WriteLog -Text 'Invalid table column'
			return 'Invalid table column'
		}
		-1978335153 {
			Job_WriteLog -Text 'The upgrade version is not newer than the installed version'
			return 'The upgrade version is not newer than the installed version'
		}
		-1978335152 {
			Job_WriteLog -Text 'Upgrade version is unknown and override is not specified'
			return 'Upgrade version is unknown and override is not specified'
		}
		-1978335151 {
			Job_WriteLog -Text 'ICU conversion error'
			return 'ICU conversion error'
		}
		-1978335150 {
			Job_WriteLog -Text 'Failed to install portable package'
			return 'Failed to install portable package'
		}
		-1978335149 {
			Job_WriteLog -Text 'Volume does not support reparse points.'
			return 'Volume does not support reparse points.'
		}
		-1978335148 {
			Job_WriteLog -Text 'Portable package from a different source already exists.'
			return 'Portable package from a different source already exists.'
		}
		-1978335147 {
			Job_WriteLog -Text 'Unable to create symlink, path points to a directory.'
			return 'Unable to create symlink, path points to a directory.'
		}
		-1978335146 {
			Job_WriteLog -Text 'The installer cannot be run from an administrator context.'
			return 'The installer cannot be run from an administrator context.'
		}
		-1978335145 {
			Job_WriteLog -Text 'Failed to uninstall portable package'
			return 'Failed to uninstall portable package'
		}
		-1978335144 {
			Job_WriteLog -Text 'Failed to validate DisplayVersion values against index.'
			return 'Failed to validate DisplayVersion values against index.'
		}
		-1978335143 {
			Job_WriteLog -Text 'One or more arguments are not supported.'
			return 'One or more arguments are not supported.'
		}
		-1978335142 {
			Job_WriteLog -Text 'Embedded null characters are disallowed for SQLite'
			return 'Embedded null characters are disallowed for SQLite'
		}
		-1978335141 {
			Job_WriteLog -Text 'Failed to find the nested installer in the archive.'
			return 'Failed to find the nested installer in the archive.'
		}
		-1978335140 {
			Job_WriteLog -Text 'Failed to extract archive.'
			return 'Failed to extract archive.'
		}
		-1978335139 {
			Job_WriteLog -Text 'Invalid relative file path to nested installer provided.'
			return 'Invalid relative file path to nested installer provided.'
		}
		-1978335138 {
			Job_WriteLog -Text 'The server certificate did not match any of the expected values.'
			return 'The server certificate did not match any of the expected values.'
		}
		-1978335137 {
			Job_WriteLog -Text 'Install location must be provided.'
			return 'Install location must be provided.'
		}
		-1978335136 {
			Job_WriteLog -Text 'Archive malware scan failed.'
			return 'Archive malware scan failed.'
		}
		-1978335135 {
			Job_WriteLog -Text 'Found at least one version of the package installed.'
			return 'Found at least one version of the package installed.'
		}
		-1978335134 {
			Job_WriteLog -Text 'A pin already exists for the package.'
			return 'A pin already exists for the package.'
		}
		-1978335133 {
			Job_WriteLog -Text 'There is no pin for the package.'
			return 'There is no pin for the package.'
		}
		-1978335132 {
			Job_WriteLog -Text 'Unable to open the pin database.'
			return 'Unable to open the pin database.'
		}
		-1978335131 {
			Job_WriteLog -Text 'One or more applications failed to install'
			return 'One or more applications failed to install'
		}
		-1978335130 {
			Job_WriteLog -Text 'One or more applications failed to uninstall'
			return 'One or more applications failed to uninstall'
		}
		-1978335129 {
			Job_WriteLog -Text 'One or more queries did not return exactly one match'
			return 'One or more queries did not return exactly one match'
		}
		-1978335128 {
			Job_WriteLog -Text 'The package has a pin that prevents upgrade.'
			return 'The package has a pin that prevents upgrade.'
		}
		-1978335127 {
			Job_WriteLog -Text 'The package currently installed is the stub package'
			return 'The package currently installed is the stub package'
		}
		-1978335126 {
			Job_WriteLog -Text 'Application shutdown signal received'
			return 'Application shutdown signal received'
		}
		-1978335125 {
			Job_WriteLog -Text 'Failed to download package dependencies.'
			return 'Failed to download package dependencies.'
		}
		-1978335124 {
			Job_WriteLog -Text 'Failed to download package. Download for offline installation is prohibited.'
			return 'Failed to download package. Download for offline installation is prohibited.'
		}
		-1978335123 {
			Job_WriteLog -Text 'A required service is busy or unavailable. Try again later.'
			return 'A required service is busy or unavailable. Try again later.'
		}
		-1978335122 {
			Job_WriteLog -Text 'The guid provided does not correspond to a valid resume state.'
			return 'The guid provided does not correspond to a valid resume state.'
		}
		-1978335121 {
			Job_WriteLog -Text 'The current client version did not match the client version of the saved state.'
			return 'The current client version did not match the client version of the saved state.'
		}
		-1978335120 {
			Job_WriteLog -Text 'The resume state data is invalid.'
			return 'The resume state data is invalid.'
		}
		-1978335119 {
			Job_WriteLog -Text 'Unable to open the checkpoint database.'
			return 'Unable to open the checkpoint database.'
		}
		-1978335118 {
			Job_WriteLog -Text 'Exceeded max resume limit.'
			return 'Exceeded max resume limit.'
		}
		-1978335117 {
			Job_WriteLog -Text 'Invalid authentication info.'
			return 'Invalid authentication info.'
		}
		-1978335116 {
			Job_WriteLog -Text 'Authentication method not supported.'
			return 'Authentication method not supported.'
		}
		-1978335115 {
			Job_WriteLog -Text 'Authentication failed.'
			return 'Authentication failed.'
		}
		-1978335114 {
			Job_WriteLog -Text 'Authentication failed. Interactive authentication required.'
			return 'Authentication failed. Interactive authentication required.'
		}
		-1978335113 {
			Job_WriteLog -Text 'Authentication failed. User cancelled.'
			return 'Authentication failed. User cancelled.'
		}
		-1978335112 {
			Job_WriteLog -Text 'Authentication failed. Authenticated account is not the desired account.'
			return 'Authentication failed. Authenticated account is not the desired account.'
		}
		-1978335111 {
			Job_WriteLog -Text 'Repair command not found.'
			return 'Repair command not found.'
		}
		-1978335110 {
			Job_WriteLog -Text 'Repair operation is not applicable.'
			return 'Repair operation is not applicable.'
		}
		-1978335109 {
			Job_WriteLog -Text 'Repair operation failed.'
			return 'Repair operation failed.'
		}
		-1978335108 {
			Job_WriteLog -Text 'The installer technology in use doesn''t support repair.'
			return 'The installer technology in use doesn''t support repair.'
		}
		-1978335107 {
			Job_WriteLog -Text 'Repair operations involving administrator privileges are not permitted on packages installed within the user scope.'
			return 'Repair operations involving administrator privileges are not permitted on packages installed within the user scope.'
		}
		-1978334975 {
			Job_WriteLog -Text 'Application is currently running. Exit the application then try again.'
			return 'Application is currently running. Exit the application then try again.'
		}
		-1978334974 {
			Job_WriteLog -Text 'Another installation is already in progress. Try again later.'
			return 'Another installation is already in progress. Try again later.'
		}
		-1978334973 {
			Job_WriteLog -Text 'One or more file is being used. Exit the application then try again.'
			return 'One or more file is being used. Exit the application then try again.'
		}
		-1978334972 {
			Job_WriteLog -Text 'This package has a dependency missing from your system.'
			return 'This package has a dependency missing from your system.'
		}
		-1978334971 {
			Job_WriteLog -Text 'There''s no more space on your PC. Make space, then try again.'
			return 'There''s no more space on your PC. Make space, then try again.'
		}
		-1978334970 {
			Job_WriteLog -Text 'There''s not enough memory available to install. Close other applications then try again.'
			return 'There''s not enough memory available to install. Close other applications then try again.'
		}
		-1978334969 {
			Job_WriteLog -Text 'This application requires internet connectivity. Connect to a network then try again.'
			return 'This application requires internet connectivity. Connect to a network then try again.'
		}
		-1978334968 {
			Job_WriteLog -Text 'This application encountered an error during installation. Contact support.'
			return 'This application encountered an error during installation. Contact support.'
		}
		-1978334967 {
			Job_WriteLog -Text 'Restart your PC to finish installation.'
			return 'Restart your PC to finish installation.'
		}
		-1978334966 {
			Job_WriteLog -Text 'Installation failed. Restart your PC then try again.'
			return 'Installation failed. Restart your PC then try again.'
		}
		-1978334965 {
			Job_WriteLog -Text 'Your PC will restart to finish installation.'
			return 'Your PC will restart to finish installation.'
		}
		-1978334964 {
			Job_WriteLog -Text 'You cancelled the installation.'
			return 'You cancelled the installation.'
		}
		-1978334963 {
			Job_WriteLog -Text 'Another version of this application is already installed.'
			return 'Another version of this application is already installed.'
		}
		-1978334962 {
			Job_WriteLog -Text 'A higher version of this application is already installed.'
			return 'A higher version of this application is already installed.'
		}
		-1978334961 {
			Job_WriteLog -Text 'Organization policies are preventing installation. Contact your admin.'
			return 'Organization policies are preventing installation. Contact your admin.'
		}
		-1978334960 {
			Job_WriteLog -Text 'Failed to install package dependencies.'
			return 'Failed to install package dependencies.'
		}
		-1978334959 {
			Job_WriteLog -Text 'Application is currently in use by another application.'
			return 'Application is currently in use by another application.'
		}
		-1978334958 {
			Job_WriteLog -Text 'Invalid parameter.'
			return 'Invalid parameter.'
		}
		-1978334957 {
			Job_WriteLog -Text 'Package not supported by the system.'
			return 'Package not supported by the system.'
		}
		-1978334956 {
			Job_WriteLog -Text 'The installer does not support upgrading an existing package.'
			return 'The installer does not support upgrading an existing package.'
		}
		-1978334719 {
			Job_WriteLog -Text 'The Apps and Features Entry for the package could not be found.'
			return 'The Apps and Features Entry for the package could not be found.'
		}
		-1978334718 {
			Job_WriteLog -Text 'The install location is not applicable.'
			return 'The install location is not applicable.'
		}
		-1978334717 {
			Job_WriteLog -Text 'The install location could not be found.'
			return 'The install location could not be found.'
		}
		-1978334716 {
			Job_WriteLog -Text 'The hash of the existing file did not match.'
			return 'The hash of the existing file did not match.'
		}
		-1978334715 {
			Job_WriteLog -Text 'File not found.'
			return 'File not found.'
		}
		-1978334714 {
			Job_WriteLog -Text 'The file was found but the hash was not checked.'
			return 'The file was found but the hash was not checked.'
		}
		-1978334713 {
			Job_WriteLog -Text 'The file could not be accessed.'
			return 'The file could not be accessed.'
		}
		-1978286079 {
			Job_WriteLog -Text 'The configuration file is invalid.'
			return 'The configuration file is invalid.'
		}
		-1978286078 {
			Job_WriteLog -Text 'The YAML syntax is invalid.'
			return 'The YAML syntax is invalid.'
		}
		-1978286077 {
			Job_WriteLog -Text 'A configuration field has an invalid type.'
			return 'A configuration field has an invalid type.'
		}
		-1978286076 {
			Job_WriteLog -Text 'The configuration has an unknown version.'
			return 'The configuration has an unknown version.'
		}
		-1978286075 {
			Job_WriteLog -Text 'An error occurred while applying the configuration.'
			return 'An error occurred while applying the configuration.'
		}
		-1978286074 {
			Job_WriteLog -Text 'The configuration contains a duplicate identifier.'
			return 'The configuration contains a duplicate identifier.'
		}
		-1978286073 {
			Job_WriteLog -Text 'The configuration is missing a dependency.'
			return 'The configuration is missing a dependency.'
		}
		-1978286072 {
			Job_WriteLog -Text 'The configuration has an unsatisfied dependency.'
			return 'The configuration has an unsatisfied dependency.'
		}
		-1978286071 {
			Job_WriteLog -Text 'An assertion for the configuration unit failed.'
			return 'An assertion for the configuration unit failed.'
		}
		-1978286070 {
			Job_WriteLog -Text 'The configuration was manually skipped.'
			return 'The configuration was manually skipped.'
		}
		-1978286069 {
			Job_WriteLog -Text 'A warning was thrown and the user declined to continue execution.'
			return 'A warning was thrown and the user declined to continue execution.'
		}
		-1978286068 {
			Job_WriteLog -Text 'The dependency graph contains a cycle which cannot be resolved.'
			return 'The dependency graph contains a cycle which cannot be resolved.'
		}
		-1978286067 {
			Job_WriteLog -Text 'The configuration has an invalid field value.'
			return 'The configuration has an invalid field value.'
		}
		-1978286066 {
			Job_WriteLog -Text 'The configuration is missing a field.'
			return 'The configuration is missing a field.'
		}
		-1978285823 {
			Job_WriteLog -Text 'The configuration unit was not installed.'
			return 'The configuration unit was not installed.'
		}
		-1978285822 {
			Job_WriteLog -Text 'The configuration unit could not be found.'
			return 'The configuration unit could not be found.'
		}
		-1978285821 {
			Job_WriteLog -Text 'Multiple matches were found for the configuration unit specify the module to select the correct one.'
			return 'Multiple matches were found for the configuration unit specify the module to select the correct one.'
		}
		-1978285820 {
			Job_WriteLog -Text 'The configuration unit failed while attempting to get the current system state.'
			return 'The configuration unit failed while attempting to get the current system state.'
		}
		-1978285819 {
			Job_WriteLog -Text 'The configuration unit failed while attempting to test the current system state.'
			return 'The configuration unit failed while attempting to test the current system state.'
		}
		-1978285818 {
			Job_WriteLog -Text 'The configuration unit failed while attempting to apply the desired state.'
			return 'The configuration unit failed while attempting to apply the desired state.'
		}
		-1978285817 {
			Job_WriteLog -Text 'The module for the configuration unit is available in multiple locations with the same version.'
			return 'The module for the configuration unit is available in multiple locations with the same version.'
		}
		-1978285816 {
			Job_WriteLog -Text 'Loading the module for the configuration unit failed.'
			return 'Loading the module for the configuration unit failed.'
		}
		-1978285815 {
			Job_WriteLog -Text 'The configuration unit returned an unexpected result during execution.'
			return 'The configuration unit returned an unexpected result during execution.'
		}
		-1978285814 {
			Job_WriteLog -Text 'A unit contains a setting that requires the config root.'
			return 'A unit contains a setting that requires the config root.'
		}
		-1978285813 {
			Job_WriteLog -Text 'Loading the module for the configuration unit failed because it requires administrator privileges to run.'
			return 'Loading the module for the configuration unit failed because it requires administrator privileges to run.'
		}
		default {
			Job_WriteLog -Text "Exiting with status: $Result"
			return "Unknown error code: $Result"
		}
	}
}