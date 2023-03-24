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

function Reg_EnumKey {
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('HKLM', 'HKCU', 'HKU')]
		[string]$RegRoot,
		[Parameter(Mandatory = $true)]
		[string]$RegPath,
		[Parameter(Mandatory = $true)]
		[bool]$MustExist
	)

	$Global:cs.Reg_EnumKey($RegRoot, $RegPath, $MustExist)
}

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