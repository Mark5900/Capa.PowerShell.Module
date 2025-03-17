
# TODO: #88 Update and add tests

<#
	.SYNOPSIS
		Creates a registry key.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKCU or HKU.

	.PARAMETER RegPath
		The path of the registry key.

	.EXAMPLE
		PS C:\> Reg_CreateKey -RegRoot "HKLM" -RegPath "SOFTWARE\CapaSystems"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455819/cs.Reg+CreateKey
#>
function Reg_CreateKey {
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKEY_LOCAL_MACHINE', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[string]$RegPath
	)

	$Global:cs.Reg_CreateKey($RegRoot, $RegPath)
}


# TODO: #89 Update and add tests

<#
	.SYNOPSIS
		Deletes a registry tree.

	.DESCRIPTION
		Deletes a registry tree in the registry, if RegRoot is HKCU, the function will delete the tree for all users that have logged on to the unit and future users.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKCU or HKU.

	.PARAMETER RegPath
		The path of the registry key.

	.PARAMETER RegKey
		The name of the registry key.

	.EXAMPLE
		PS C:\> Reg_DeleteTree -RegRoot "HKLM" -RegPath "SOFTWARE\CapaSystems" -RegKey "Test"

	.EXAMPLE
		PS C:\> Reg_DeleteTree -RegRoot "HKCU" -RegPath "SOFTWARE\CapaSystems" -RegKey "Test"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455836/cs.Reg+DelTree
#>
function Reg_DeleteTree {
	[CmdletBinding()]
	[Alias('Reg_DelTree')]
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[string]$RegPath
	)

	$LogPreTag = 'Reg_DeleteTree:'
	$Global:cs.Job_WriteLog("$LogPreTag Calling function with: RegRoot: $RegRoot | Registry_Key: $RegPath")

	switch ($RegRoot) {
		'HKCU' {
			$Global:cs.Job_WriteLog("$LogPreTag Building Array With All Users That Have Logged On To This Unit....")
			$RegKeys = $Global:cs.Reg_EnumKey('HKLM', 'SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList', $true)

			# Convert from array to list and add DEFAULT user
			$UsersRegKey = @()
			$UsersRegKey += $RegKeys
			$UsersRegKey += 'DEFAULT'

			try {
				foreach ($User in $UsersRegKey) {
					$Global:cs.Job_WriteLog("$LogPreTag Running for $User")

					# Skip if the user is not a user or the default user
					$split = $User -split '-'
					if ($split[3] -ne '21' -and $User -ne 'DEFAULT' -and $split[3] -ne '1') {
						$Global:cs.Job_WriteLog("$LogPreTag Skipping $User")
						continue
					}

					# Sets user specific variables
					switch ($User) {
						'DEFAULT' {
							$ProfileImagePath = 'C:\Users\DEFAULT'
							$Temp_RegRoot = 'HKLM'
							$RegistryCoreKey = 'TempHive\'
							$HKUExists = $false
						}
						Default {
							$ProfileImagePath = $Global:cs.Reg_GetExpandString('HKLM', "SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\$User", 'ProfileImagePath')
							if ($ProfileImagePath) {
								if ($Global:cs.Reg_ExistKey('HKU', $User)) {
									$Temp_RegRoot = 'HKU'
									$RegistryCoreKey = "$User\"
									$HKUExists = $true
								} else {
									$Temp_RegRoot = 'HKLM'
									$RegistryCoreKey = 'TempHive\'
									$HKUExists = $false
								}
							} else {
								$Global:cs.Job_WriteLog("$LogPreTag ProfileImagePath is empty for $User. Skipping...")
								continue
							}
						}
					}

					# Load the NTUSER.DAT file if it exists
					$NTUserDatFile = Join-Path $ProfileImagePath 'NTUSER.DAT'
					if ($RegistryCoreKey -eq 'TempHive\' -and ($Global:cs.File_ExistFile($NTUserDatFile))) {
						$RetValue = $Global:cs.Shell_Execute('cmd.exe', "/c reg load HKLM\TempHive `"$ProfileImagePath\NTUSER.DAT`"")
						if ($RetValue -ne 0) {
							$Global:cs.Job_WriteLog("$LogPreTag Error: The registry hive for $User could not be mounted. Skipping...")
							continue
						}
					} elseif ($HKUExists) {
						# Do nothing
					}	else {
						$Global:cs.Job_WriteLog("$LogPreTag NTUSER.DAT does not exist for $User. Skipping...")
						continue
					}

					# Set the registry value
					$RegKeyPathTemp = "$RegistryCoreKey$RegPath"
					$Global:cs.Reg_DeleteTree($Temp_RegRoot, $RegKeyPathTemp)

					# Unload the NTUSER.DAT file if it was loaded
					if ($RegistryCoreKey -eq 'TempHive\') {
						[gc]::collect()
						[gc]::WaitForPendingFinalizers()
						Start-Sleep -Seconds 2
						$RetValue = $Global:cs.Shell_Execute('cmd.exe', '/c reg unload HKLM\TempHive')
						if ($RetValue -ne 0) {
							$Global:cs.Job_WriteLog("$LogPreTag Error: The registry hive for $User could not be unmounted")
						}
					}
				}
			} finally {
				if ($Global:cs.Reg_ExistKey('HKLM', 'TempHive')) {
					[gc]::collect()
					[gc]::WaitForPendingFinalizers()
					Start-Sleep -Seconds 2
					$RetValue = $Global:cs.Shell_Execute('cmd.exe', '/c reg unload HKLM\TempHive')
					if ($RetValue -ne 0) {
						$Global:cs.Job_WriteLog("$LogPreTag Error: The registry hive could not be unmounted")
					}
				}
			}
		}
		Default {
			$Global:cs.Reg_DeleteTree($RegRoot, $RegPath)
		}
	}
}


# TODO: #90 Update and add tests

<#
	.SYNOPSIS
		Deletes a registry value.

	.DESCRIPTION
		Deletes a registry value in the registry, if RegRoot is HKCU, the function will delete the value for all users that have logged on to the unit and future users.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKCU or HKU.

	.PARAMETER RegPath
		The path of the registry key.

	.PARAMETER RegValue
		The name of the registry value.

	.EXAMPLE
		PS C:\> Reg_DeleteVariable -RegRoot "HKLM" -RegPath "SOFTWARE\CapaSystems" -RegValue "Test"

	.EXAMPLE
		PS C:\> Reg_DeleteVariable -RegRoot "HKCU" -RegPath "SOFTWARE\CapaSystems" -RegValue "Test"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455802/cs.Reg+DeleteVariable
#>
function Reg_DeleteVariable {
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[string]$RegPath,
		[Parameter(Mandatory = $true)]
		[string]$RegValue
	)

	$LogPreTag = 'Reg_DeleteVariable:'
	$Global:cs.Job_WriteLog("$LogPreTag Calling function with: RegRoot: $RegRoot | RegPath: $RegPath | RegValue: $RegValue")

	switch ($RegRoot) {
		'HKCU' {
			$Global:cs.Job_WriteLog("$LogPreTag Building Array With All Users That Have Logged On To This Unit....")
			$RegKeys = $Global:cs.Reg_EnumKey('HKLM', 'SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList', $true)

			# Convert from array to list and add DEFAULT user
			$UsersRegKey = @()
			$UsersRegKey += $RegKeys
			$UsersRegKey += 'DEFAULT'

			try {
				foreach ($User in $UsersRegKey) {
					$Global:cs.Job_WriteLog("$LogPreTag Running for $User")

					# Skip if the user is not a user or the default user
					$split = $User -split '-'
					if ($split[3] -ne '21' -and $User -ne 'DEFAULT' -and $split[3] -ne '1') {
						$Global:cs.Job_WriteLog("$LogPreTag Skipping $User")
						continue
					}

					# Sets user specific variables
					switch ($User) {
						'DEFAULT' {
							$ProfileImagePath = 'C:\Users\DEFAULT'
							$Temp_RegRoot = 'HKLM'
							$RegistryCoreKey = 'TempHive\'
							$HKUExists = $false
						}
						Default {
							$ProfileImagePath = $Global:cs.Reg_GetExpandString('HKLM', "SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\$User", 'ProfileImagePath')
							if ($ProfileImagePath) {
								if ($Global:cs.Reg_ExistKey('HKU', $User)) {
									$Temp_RegRoot = 'HKU'
									$RegistryCoreKey = "$User\"
									$HKUExists = $true
								} else {
									$Temp_RegRoot = 'HKLM'
									$RegistryCoreKey = 'TempHive\'
									$HKUExists = $false
								}
							} else {
								$Global:cs.Job_WriteLog("$LogPreTag ProfileImagePath is empty for $User. Skipping...")
								continue
							}
						}
					}

					# Load the NTUSER.DAT file if it exists
					$NTUserDatFile = Join-Path $ProfileImagePath 'NTUSER.DAT'
					if ($RegistryCoreKey -eq 'TempHive\' -and ($Global:cs.File_ExistFile($NTUserDatFile))) {
						$RetValue = $Global:cs.Shell_Execute('cmd.exe', "/c reg load HKLM\TempHive `"$ProfileImagePath\NTUSER.DAT`"")
						if ($RetValue -ne 0) {
							$Global:cs.Job_WriteLog("$LogPreTag Error: The registry hive for $User could not be mounted. Skipping...")
							continue
						}
					} elseif ($HKUExists) {
						# Do nothing
					}	else {
						$Global:cs.Job_WriteLog("$LogPreTag NTUSER.DAT does not exist for $User. Skipping...")
						continue
					}

					# Set the registry value
					$RegKeyPathTemp = "$RegistryCoreKey$RegPath"
					$Global:cs.Reg_DeleteVariable($Temp_RegRoot, $RegKeyPathTemp, $RegValue)

					# Unload the NTUSER.DAT file if it was loaded
					if ($RegistryCoreKey -eq 'TempHive\') {
						[gc]::collect()
						[gc]::WaitForPendingFinalizers()
						Start-Sleep -Seconds 2
						$RetValue = $Global:cs.Shell_Execute('cmd.exe', '/c reg unload HKLM\TempHive')
						if ($RetValue -ne 0) {
							$Global:cs.Job_WriteLog("$LogPreTag Error: The registry hive for $User could not be unmounted")
						}
					}
				}
			} finally {
				if ($Global:cs.Reg_ExistKey('HKLM', 'TempHive')) {
					[gc]::collect()
					[gc]::WaitForPendingFinalizers()
					Start-Sleep -Seconds 2
					$RetValue = $Global:cs.Shell_Execute('cmd.exe', '/c reg unload HKLM\TempHive')
					if ($RetValue -ne 0) {
						$Global:cs.Job_WriteLog("$LogPreTag Error: The registry hive could not be unmounted")
					}
				}
			}
		}
		Default {
			$Global:cs.Reg_DeleteVariable($RegRoot, $RegPath, $RegValue)
		}
	}
}


# TODO: #91 Update and add tests

<#
	.SYNOPSIS
		Enumerates all registry keys.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKCU or HKU.

	.PARAMETER RegPath
		The path of the registry key.

	.PARAMETER MustExist
		Indicates if the registry key must exist, default is $true.

	.EXAMPLE
		PS C:\> Reg_EnumKey -RegRoot "HKLM" -RegPath "SOFTWARE\CapaSystems"

	.EXAMPLE
		PS C:\> Reg_EnumKey -RegRoot "HKLM" -RegPath "SOFTWARE\CapaSystems" -MustExist $false

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455853/cs.Reg+EnumKey
#>
function Reg_EnumKey {
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[string]$RegPath,
		[bool]$MustExist = $true
	)

	$Global:cs.Reg_EnumKey($RegRoot, $RegPath, $MustExist)
}


# TODO: #92 Update and add tests

<#
	.SYNOPSIS
		Exists a registry key.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKEY_LOCAL_MACHINE, HKCU or HKU.

	.PARAMETER RegKey
		The path of the registry key.

	.EXAMPLE
		PS C:\> Reg_ExistKey -RegRoot "HKLM" -RegKey "SOFTWARE\CapaSystems"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455870/cs.Reg+ExistKey
#>
function Reg_ExistKey {
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKEY_LOCAL_MACHINE', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[string]$RegKey
	)

	$Value = $Global:cs.Reg_ExistKey($RegRoot, $RegKey)

	return $Value
}


# TODO: #93 Update and add tests

<#
	.SYNOPSIS
		Exists a registry variable.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKEY_LOCAL_MACHINE, HKCU or HKU.

	.PARAMETER RegKey
		The path of the registry key.

	.PARAMETER RegVariable
		The name of the registry variable.

	.EXAMPLE
		PS C:\> Reg_ExistVariable -RegRoot "HKLM" -RegKey "SOFTWARE\CapaSystems" -RegVariable "Test"

	.EXAMPLE
		PS C:\> if (Reg_ExistVariable -RegRoot "HKLM" -RegKey "SOFTWARE\CapaSystems" -RegVariable "Test") {
			Write-Host "The registry variable exists"
		} else {
			Write-Host "The registry variable does not exist"
		}

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455887/cs.Reg+ExistVariable
#>
function Reg_ExistVariable {
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKEY_LOCAL_MACHINE', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[string]$RegKey,
		[Parameter(Mandatory = $true)]
		[string]$RegVariable
	)

	$Value = $Global:cs.Reg_ExistVariable($RegRoot, $RegKey, $RegVariable)

	return $Value
}


# TODO: #399 Add tests for Reg_GetExpandString

<#
	.SYNOPSIS
		Gets a registry expand string.

	.DESCRIPTION
		Gets a registry expand string.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKEY_LOCAL_MACHINE, HKCU or HKU.

	.PARAMETER RegKey
		The path of the registry key.

	.PARAMETER RegValue
		The name of the registry value.

	.EXAMPLE
		PS C:\> Reg_GetExpandString -RegRoot "HKLM" -RegKey "SOFTWARE\CapaSystems" -RegValue "Test"
#>
function Reg_GetExpandString {
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKEY_LOCAL_MACHINE', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[string]$RegKey,
		[Parameter(Mandatory = $true)]
		[string]$RegValue
	)

	return $Global:cs.Reg_GetExpandString($RegRoot, $RegKey, $RegValue)
}


# TODO: #400 Add tests for Reg_GetInteger

<#
	.SYNOPSIS
		Gets a registry integer.

	.DESCRIPTION
		Gets a registry integer.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKEY_LOCAL_MACHINE, HKCU or HKU.

	.PARAMETER RegKey
		The path of the registry key.

	.PARAMETER RegValue
		The name of the registry value.

	.EXAMPLE
		PS C:\> Reg_GetInteger -RegRoot "HKLM" -RegKey "SOFTWARE\CapaSystems" -RegValue "Test"
#>
function Reg_GetInteger {
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKEY_LOCAL_MACHINE', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[string]$RegKey,
		[Parameter(Mandatory = $true)]
		[string]$RegValue
	)

	return $Global:cs.Reg_GetInteger($RegRoot, $RegKey, $RegValue)
}


# TODO: #401 Add tests for Reg_GetMultiString

<#
	.SYNOPSIS
		Gets a registry multi string.

	.DESCRIPTION
		Gets a registry multi string.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKEY_LOCAL_MACHINE, HKCU or HKU.

	.PARAMETER RegKey
		The path of the registry key.

	.PARAMETER RegValue
		The name of the registry value.

	.EXAMPLE
		PS C:\> Reg_GetMultiString -RegRoot "HKLM" -RegKey "SOFTWARE\CapaSystems" -RegValue "Test"
#>
function Reg_GetMultiString {
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKEY_LOCAL_MACHINE', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[string]$RegKey,
		[Parameter(Mandatory = $true)]
		[string]$RegValue
	)

	return $Global:cs.Reg_GetMultiString($RegRoot, $RegKey, $RegValue)
}


# TODO: #94 Update and add tests

<#
	.SYNOPSIS
		Gets a registry string.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKEY_LOCAL_MACHINE, HKCU or HKU.

	.PARAMETER RegKey
		The path of the registry key.

	.PARAMETER RegValue
		The name of the registry value.

	.EXAMPLE
		PS C:\> Reg_GetString -RegRoot "HKLM" -RegKey "SOFTWARE\CapaSystems" -RegValue "Test"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455904/cs.Reg+GetString
#>
function Reg_GetString {
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKEY_LOCAL_MACHINE', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[string]$RegKey,
		[Parameter(Mandatory = $true)]
		[string]$RegValue
	)

	$Value = $Global:cs.Reg_GetString($RegRoot, $RegKey, $RegValue)

	return $Value
}


# TODO: #95 Update and add tests

<#
	.SYNOPSIS
		Sets a registry dword.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKEY_LOCAL_MACHINE, HKCU or HKU.

	.PARAMETER RegKey
		The path of the registry key.

	.PARAMETER RegValue
		The name of the registry value.

	.PARAMETER RegData
		The data of the registry value.

	.EXAMPLE
		PS C:\> Reg_SetDword -RegRoot "HKLM" -RegKey "SOFTWARE\CapaSystems" -RegValue "Test" -RegData 1

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455921/cs.Reg+SetDword
#>
function Reg_SetDword {
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKEY_LOCAL_MACHINE', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[string]$RegKey,
		[Parameter(Mandatory = $true)]
		[string]$RegValue,
		[Parameter(Mandatory = $true)]
		[int]$RegData
	)

	$Global:cs.Reg_SetDword($RegRoot, $RegKey, $RegValue, $RegData)
}


# TODO: #96 Update and add tests

<#
	.SYNOPSIS
		Sets a registry expand string.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKEY_LOCAL_MACHINE, HKCU or HKU.

	.PARAMETER RegKey
		The path of the registry key.

	.PARAMETER RegValue
		The name of the registry value.

	.PARAMETER RegData
		The data of the registry value.

	.EXAMPLE
		PS C:\> Reg_SetExpandString -RegRoot "HKLM" -RegKey "SOFTWARE\CapaSystems" -RegValue "Test" -RegData "%ProgramFiles%"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455938/cs.Reg+SetExpandString
#>
function Reg_SetExpandString {
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKEY_LOCAL_MACHINE', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[string]$RegKey,
		[Parameter(Mandatory = $true)]
		[string]$RegValue,
		[Parameter(Mandatory = $true)]
		[string]$RegData
	)

	$Global:cs.Reg_SetExpandString($RegRoot, $RegKey, $RegValue, $RegData)
}


# TODO: #97 Update and add tests

<#
	.SYNOPSIS
		Sets a registry integer.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKEY_LOCAL_MACHINE, HKCU or HKU.

	.PARAMETER RegKey
		The path of the registry key.

	.PARAMETER RegValue
		The name of the registry value.

	.PARAMETER RegData
		The data of the registry value.

	.EXAMPLE
		PS C:\> Reg_SetInteger -RegRoot "HKLM" -RegKey "SOFTWARE\CapaSystems" -RegValue "Test" -RegData 1

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455955/cs.Reg+SetInteger
#>
function Reg_SetInteger {
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKEY_LOCAL_MACHINE', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[string]$RegKey,
		[Parameter(Mandatory = $true)]
		[string]$RegValue,
		[Parameter(Mandatory = $true)]
		[int]$RegData
	)

	$Global:cs.Reg_SetInteger($RegRoot, $RegKey, $RegValue, $RegData)
}


# TODO: #402 Create tests for Reg_SetQword

<#
	.SYNOPSIS
		Sets a registry QWORD value.

	.DESCRIPTION
		Sets a registry QWORD value.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKEY_LOCAL_MACHINE, HKCU or HKU.

	.PARAMETER RegKey
		The path of the registry key.

	.PARAMETER RegValue
		The name of the registry value.

	.PARAMETER RegData
		The data to set.

	.EXAMPLE
		PS C:\> Reg_SetQword -RegRoot "HKLM" -RegKey "SOFTWARE\CapaSystems" -RegValue "Test" -RegData 123
#>
function Reg_SetQword {
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKEY_LOCAL_MACHINE', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[string]$RegKey,
		[Parameter(Mandatory = $true)]
		[string]$RegValue,
		[Parameter(Mandatory = $true)]
		[int]$RegData
	)

	return $Global:cs.Reg_SetQword($RegRoot, $RegKey, $RegValue, $RegData)
}


# TODO: #98 Update and add tests

<#
	.SYNOPSIS
		Sets a registry string.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKEY_LOCAL_MACHINE, HKCU or HKU.

	.PARAMETER RegKey
		The path of the registry key.

	.PARAMETER RegValue
		The name of the registry value.

	.PARAMETER RegData
		The data of the registry value.

	.EXAMPLE
		PS C:\> Reg_SetString -RegRoot "HKLM" -RegKey "SOFTWARE\CapaSystems" -RegValue "Test" -RegData "Test1"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455972/cs.Reg+SetString
#>
function Reg_SetString {
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKEY_LOCAL_MACHINE', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[string]$RegKey,
		[Parameter(Mandatory = $true)]
		[string]$RegValue,
		[Parameter(Mandatory = $true)]
		[string]$RegData
	)

	$Global:cs.Reg_SetString($RegRoot, $RegKey, $RegValue, $RegData)
}


<#
	.SYNOPSIS
		Sets a registry value.

	.DESCRIPTION
		Sets a registry value in the registry, if RegRoot is HKCU, the function will set the value for all users that have logged on to the unit and future users.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKCU or HKU.

	.PARAMETER Datatype
		The datatype of the registry value, can be String, DWORD (32-bit) or Expanded String.

	.PARAMETER RegKey
		The path of the registry key.

	.PARAMETER RegValue
		The name of the registry value.

	.PARAMETER RegData
		The data of the registry value.

	.EXAMPLE
		PS C:\> Set-PpRegistryValue -RegRoot "HKLM" -Datatype "String" -RegKey "SOFTWARE\CapaSystems" -RegValue "Test" -RegData "Test1"

	.EXAMPLE
		PS C:\> Set-PpRegistryValue -RegRoot "HKCU" -Datatype "String" -RegKey "SOFTWARE\CapaSystems" -RegValue "Test" -RegData "Test1"
#>
Function Set-PpRegistryValue {
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[ValidateSet('String', 'DWORD (32-bit)', 'Expanded String')]
		[string]$Datatype,
		[Parameter(Mandatory = $true)]
		[string]$RegKey,
		[Parameter(Mandatory = $true)]
		[string]$RegValue,
		[Parameter(Mandatory = $false)]
		[string]$RegData
	)
	$LogPreTag = 'Set-PpRegistryValue:'
	$Global:cs.Job_WriteLog("$LogPreTag Calling function with: RegRoot: $RegRoot | RegKey: $RegKey | RegValue: $RegValue | RegData: $RegData")

	switch ($RegRoot) {
		'HKCU' {
			$Global:cs.Job_WriteLog("$LogPreTag Building Array With All Users That Have Logged On To This Unit....")
			$RegKeys = $Global:cs.Reg_EnumKey('HKLM', 'SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList', $true)

			# Convert from array to list and add DEFAULT user
			$UsersRegKey = @()
			$UsersRegKey += $RegKeys
			$UsersRegKey += 'DEFAULT'

			try {
				foreach ($User in $UsersRegKey) {
					$Global:cs.Job_WriteLog("$LogPreTag Running for $User")

					# Skip if the user is not a user or the default user
					$split = $User -split '-'
					if ($split[3] -ne '21' -and $User -ne 'DEFAULT' -and $split[3] -ne '1') {
						$Global:cs.Job_WriteLog("$LogPreTag Skipping $User")
						continue
					}

					# Sets user specific variables
					switch ($User) {
						'DEFAULT' {
							$ProfileImagePath = 'C:\Users\DEFAULT'
							$Temp_RegRoot = 'HKLM'
							$RegistryCoreKey = 'TempHive\'
							$HKUExists = $false
						}
						Default {
							$ProfileImagePath = $Global:cs.Reg_GetExpandString('HKLM', "SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\$User", 'ProfileImagePath')
							if ($ProfileImagePath) {
								if ($Global:cs.Reg_ExistKey('HKU', $User)) {
									$Temp_RegRoot = 'HKU'
									$RegistryCoreKey = "$User\"
									$HKUExists = $true
								} else {
									$Temp_RegRoot = 'HKLM'
									$RegistryCoreKey = 'TempHive\'
									$HKUExists = $false
								}
							} else {
								$Global:cs.Job_WriteLog("$LogPreTag ProfileImagePath is empty for $User. Skipping...")
								continue
							}
						}
					}

					# Load the NTUSER.DAT file if it exists
					$NTUserDatFile = Join-Path $ProfileImagePath 'NTUSER.DAT'
					if ($RegistryCoreKey -eq 'TempHive\' -and ($Global:cs.File_ExistFile($NTUserDatFile))) {
						$RetValue = $Global:cs.Shell_Execute('cmd.exe', "/c reg load HKLM\TempHive `"$ProfileImagePath\NTUSER.DAT`"")
						if ($RetValue -ne 0) {
							$Global:cs.Job_WriteLog("$LogPreTag Error: The registry hive for $User could not be mounted. Skipping...")
							continue
						}
					} elseif ($HKUExists) {
						# Do nothing
					}	else {
						$Global:cs.Job_WriteLog("$LogPreTag NTUSER.DAT does not exist for $User. Skipping...")
						continue
					}

					# Set the registry value
					$RegKeyPathTemp = "$RegistryCoreKey$RegKey"
					switch -Exact ($Datatype) {
						'String' {
							$Global:cs.Reg_SetString($Temp_RegRoot, $RegKeyPathTemp, $RegValue, $RegData)
						}
						'DWORD (32-bit)' {
							$Global:cs.Reg_SetDword($Temp_RegRoot, $RegKeyPathTemp, $RegValue, [int]$RegData)
						}
						'Expanded String' {
							$Global:cs.Reg_SetExpandString($Temp_RegRoot, $RegKeyPathTemp, $RegValue, $RegData)
						}
					}

					# Unload the NTUSER.DAT file if it was loaded
					if ($RegistryCoreKey -eq 'TempHive\') {
						[gc]::collect()
						[gc]::WaitForPendingFinalizers()
						Start-Sleep -Seconds 2
						$RetValue = $Global:cs.Shell_Execute('cmd.exe', '/c reg unload HKLM\TempHive')
						if ($RetValue -ne 0) {
							$Global:cs.Job_WriteLog("$LogPreTag Error: The registry hive for $User could not be unmounted")
						}
					}
				}
			} finally {
				if ($Global:cs.Reg_ExistKey('HKLM', 'TempHive')) {
					[gc]::collect()
					[gc]::WaitForPendingFinalizers()
					Start-Sleep -Seconds 2
					$RetValue = $Global:cs.Shell_Execute('cmd.exe', '/c reg unload HKLM\TempHive')
					if ($RetValue -ne 0) {
						$Global:cs.Job_WriteLog("$LogPreTag Error: The registry hive could not be unmounted")
					}
				}
			}
		}
		Default {
			# TODO: Change this to use the $RegRoot instead of $Temp_RegRoot
			switch -Exact ($Datatype) {
				'String' {
					$Global:cs.Reg_SetString($Temp_RegRoot, $RegKey, $RegValue, $RegData)
				}
				'DWORD (32-bit)' {
					$Global:cs.Reg_SetDword($Temp_RegRoot, $RegKey, $RegValue, [int]$RegData)
				}
				'Expanded String' {
					$Global:cs.Reg_SetExpandString($Temp_RegRoot, $RegKey, $RegValue, $RegData)
				}
			}
		}
	}
}


