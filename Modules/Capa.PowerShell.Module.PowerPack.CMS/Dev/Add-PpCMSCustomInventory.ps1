# TODO: #295 Update Get-Help CMS_AddCustomInventory
<#
	.SYNOPSIS
		Adds a custom inventory entry to the database.

	.DESCRIPTION
		Adds a persistent CustomInventory row to the database, meaning that the data will not be flushed out the next time that the CustomInventory package is run.

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
		- Integer
		- Time

	.EXAMPLE
		$bStatus = Add-PpCMSCustomInventory -Category "MyCategory" -Entry "MyEntry" -Value "MyValue" -ValueType "String"
		if ($bStatus) {
			Job_WriteLog -Text "Custom inventory added successfully."
		} else {
			Job_WriteLog -Text "Failed to add custom inventory."
		}

	.NOTES
		Please note, that this is an expensive call, seen from the Frontend/database perspective. Calling this function repeatedly from a package could result in overall slower performance. This function should be used with care.
#>
function Add-PpCMSCustomInventory {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Category,
		[Parameter(Mandatory = $true)]
		[string]$Entry,
		[Parameter(Mandatory = $true)]
		[string]$Value,
		[Parameter(Mandatory = $true)]
		[ValidateSet('String', 'Integer', 'Time')]
		[string]$ValueType
	)
	switch ($x) {
		String {
			$ValueTypeShort = 'S'
		}
		Integer {
			$ValueTypeShort = 'I'
		}
		Time {
			$ValueTypeShort = 'T'
		}
		Default {
			$ValueTypeShort = 'S'
		}
	}

	return CMS_AddCustomInventory -category $Category -entry $Entry -value $Value -valuetype $ValueTypeShort
}