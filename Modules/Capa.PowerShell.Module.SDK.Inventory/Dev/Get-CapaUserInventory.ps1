<#
	.SYNOPSIS
		Get user inventory (standard inventory of type User) for a user.

	.DESCRIPTION
		Get user inventory (standard inventory of type User) for a user.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UserName
		The username of the user.

	.EXAMPLE
				PS C:\> Get-CapaUserInventory -CapaSDK $CapaSDK -UserName 'Klient'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246418/Get+User+Inventory
#>
function Get-CapaUserInventory {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UserName
	)

	$oaUnits = @()

	$aUnits = $CapaSDK.GetUserInventory($UserName)

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$DataType = Convert-CapaDataType -Datatype $aItem[3]
		$oaUnits += [pscustomobject]@{
			Category = $aItem[0];
			Entry    = $aItem[1];
			Value    = $aItem[2];
			Datatype = $DataType;
			GUID     = $aItem[4];
			ID       = $aItem[5]
		}
	}

	return $oaUnits
}
