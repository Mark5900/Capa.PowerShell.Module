# TODO: #293 Update the Get-Help for Get-PpCMSInventory
<#
	.SYNOPSIS
		Gets inventory values from the database.

	.DESCRIPTION
		Gets inventory values from the database, from either the Hardware, Custom, or Logon inventory tables.

	.PARAMETER Table
		This is the table toward which the request is made, and it can be either 'Hardware Inventory', 'Logon Inventory', or 'Custom Inventory'.

	.PARAMETER Category
		Category name

	.PARAMETER Entry
		Variable name

	.EXAMPLE
		$value = Get-PpCMSInventory -Table 'Hardware Inventory' -Category 'System' -Entry 'Name'
		Job_WriteLog -Text "Name: $value"

	.NOTES
		Please note, that this is an expensive call, seen from the Frontend/database perspective.
		Calling this function repeatedly from a package could result in overall slower performance. This function should be used with care.
#>
function Get-PpCMSInventory {
	param (
		[Parameter(Mandatory = $true)]
		[ValidationSet('Hardware Inventory', 'Logon Inventory', 'Custom Inventory')]
		[string]$Table,
		[Parameter(Mandatory = $true)]
		[string]$Category,
		[Parameter(Mandatory = $true)]
		[string]$Entry
	)
	$TableShort

	switch ($Table) {
		'Hardware Inventory' {
			$TableShort = 'HWI'
		}
		'Logon Inventory' {
			$TableShort = 'LGI'
		}
		'Custom Inventory' {
			$TableShort = 'CSI'
		}
		Default {
			throw "Invalid table: $Table"
		}
	}

	return CMS_GetInventory -table $TableShort -category $Category -entry $Entry
}