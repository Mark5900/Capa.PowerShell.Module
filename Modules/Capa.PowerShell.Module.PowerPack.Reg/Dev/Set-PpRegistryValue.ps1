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