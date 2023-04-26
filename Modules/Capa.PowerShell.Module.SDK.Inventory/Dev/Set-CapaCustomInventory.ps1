<#
	.SYNOPSIS
		Set custom inventory for a unit.
	
	.DESCRIPTION
		Set custom inventory for a unit, either by name and type or by UUID.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER UnitName
		The name of the unit.
	
	.PARAMETER UnitType
		The type of the unit, can be Computer or User.
	
	.PARAMETER Uuid
		The UUID of the unit.
	
	.PARAMETER Section
		The inventory section.
	
	.PARAMETER Name
		The name of the value.
	
	.PARAMETER Value
		The value.
	
	.PARAMETER DataType
		The data type of the value, can be String, Integer, Text or Time.
	
	.EXAMPLE
				PS C:\> Set-CapaCustomInventory -CapaSDK $CapaSDK -UnitName 'Klient' -UnitType Computer -Section 'Antivirus' -Name 'Version' -Value '4' -DataType Integer
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246438/Set+custom+inventory
#>
function Set-CapaCustomInventory {
	[CmdletBinding(DefaultParameterSetName = 'NameType')]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[String]$UnitName,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[String]$UnitType,
		[Parameter(ParameterSetName = 'Uuid',
			Mandatory = $true)]
		[String]$Uuid,
		[Parameter(Mandatory = $true)]
		[String]$Section,
		[Parameter(Mandatory = $true)]
		[String]$Name,
		[Parameter(Mandatory = $true)]
		[String]$Value,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Integer', 'Time', 'String', 'Text', 'I', 'T', 'S', 'N')]
		[String]$DataType
	)
	
	switch ($UnitType) {
		'Computer' {
			$UnitType = '1'
		}
		'User' {
			$UnitType = '2'
		}
		default { }
	}
	
	switch ($DataType) {
		'Integer' {
			$DataType = 'I'
		}
		'Time' {
			$DataType = 'T'
		}
		'String' {
			$DataType = 'S'
		}
		'Text' {
			$DataType = 'N'
		}
		default { }
	}
	
	if ($PSCmdlet.ParameterSetName -eq 'NameType') {
		$value = $CapaSDK.SetCustomInventory($UnitName, $UnitType, $Section, $Name, $Value, $DataType)
	} Else {
		$value = $CapaSDK.SetCustomInventoryUUID($Uuid, $Section, $Name, $Value, $DataType)
	}
	
	return $value
}
