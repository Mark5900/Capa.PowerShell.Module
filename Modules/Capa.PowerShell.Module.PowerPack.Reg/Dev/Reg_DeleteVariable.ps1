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
