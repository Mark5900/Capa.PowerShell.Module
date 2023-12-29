# TODO: #117 Update and add tests

<#
.SYNOPSIS
Returns printers linked to a group.

.DESCRIPTION
Returns array of printers linked to a group.

.PARAMETER CapaSDK
The CapaSDK object.

.PARAMETER GroupName
The name of the group.

.PARAMETER GroupType
The type of the group, either Dynamic_ADSI, Calendar, Department, Dynamic_SQL, Reinstall, Security or Static.

.EXAMPLE
Get-Process C:\> Get-CapaGroupPrinters -CapaSDK $value1 -GroupName 'Value2' -GroupType Dynamic_ADSI

.NOTES
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247436/Get+group+Printers
#>
function Get-CapaGroupPrinters {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Static')]
		[String]$GroupType
	)

	$oaUnits = @()

	$aUnits = $CapaSDK.GetGroupPrinters($GroupName, $GroupType)

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			DisplayName = $aItem[0];
			Created     = $aItem[1];
			Status      = $aItem[2];
			Description = $aItem[3];
			GUID        = $aItem[4];
			ID          = $aItem[5];
			TypeName    = $aItem[7];
			UUID        = $aItem[8]
		}
	}

	Return $oaUnits
}
