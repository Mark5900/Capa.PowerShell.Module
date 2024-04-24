# TODO: #301 Update Get-Help for Add-PpCMSHardwareInventory
<#
	.SYNOPSIS
		Adds a HardwareInventory row to the database that is persistent.

	.DESCRIPTION
		Adds a HardwareInventory row to the database that is persistent, meaning that the data will not be flushed out the next time that the HardwareInventory package is run.

	.PARAMETER Category
		Category name

	.PARAMETER Entry
		Variable name

	.PARAMETER Value
		Value of the variable.
		If the ValueType is Time then the value should be epoch time, meaning the number of seconds since 1970-01-01 00:00:00 UTC.
		You can also set the Time at "" or "0" to set the current time.

	.PARAMETER ValueType
		Type of the value.
		Valid values are:
		- String
		- Int
		- Time

	.EXAMPLE
		$bStatus = Add-PpCMSHardwareInventory -Category "MyCategory" -Entry "MyEntry" -Value "MyValue" -ValueType "String"
		if ($bStatus) {
			Job_WriteLog -Text "Hardware inventory added successfully."
		} else {
			Job_WriteLog -Text "Failed to add hardware inventory."
		}
#>
function Add-PpCMSHardwareInventory {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Category,
		[Parameter(Mandatory = $true)]
		[string]$Entry,
		[Parameter(Mandatory = $true)]
		[string]$Value,
		[Parameter(Mandatory = $true)]
		[ValidateSet('String', 'Int', 'Time')]
		[string]$ValueType
	)
	switch ($x) {
		'String' {
			$ValueTypeShort = 'S'
		}
		'Int' {
			$ValueTypeShort = 'I'
		}
		'Time' {
			$ValueTypeShort = 'T'
		}
		Default {
			$ValueTypeShort = 'S'
		}
	}

	return CMS_AddHardwareInventory -category $Category -entry $Entry -value $Value -valuetype $ValueTypeShort
}