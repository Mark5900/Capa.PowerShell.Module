<#
	.SYNOPSIS
		Deletes a registry value.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKCU or HKU.

	.PARAMETER RegPath
		The path of the registry key.

	.PARAMETER RegValue
		The name of the registry value.

	.EXAMPLE
		PS C:\> Reg_DeleteVariable -RegRoot "HKLM" -RegPath "SOFTWARE\CapaSystems" -RegValue "Test"

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

	$Global:cs.Reg_DeleteVariable($RegRoot, $RegPath, $RegValue)
}

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

<#
	.SYNOPSIS
		Deletes a registry tree.

	.PARAMETER RegRoot
		The root of the registry key, can be HKLM, HKCU or HKU.

	.PARAMETER RegPath
		The path of the registry key.

	.PARAMETER RegKey
		The name of the registry key.

	.EXAMPLE
		PS C:\> Reg_DelTree -RegRoot "HKLM" -RegPath "SOFTWARE\CapaSystems" -RegKey "Test"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455836/cs.Reg+DelTree
#>
function Reg_DelTree {
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[string]$RegPath,
		[Parameter(Mandatory = $true)]
		[string]$RegKey
	)

	$Global:cs.Reg_DelTree($RegRoot, $RegPath, $RegKey)
}

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