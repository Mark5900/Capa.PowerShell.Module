# TODO: Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247510/Get+unit+linked+user

	.DESCRIPTION
		A detailed description of the Get-CapaUnitLinkedUser function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER ComputerName
		A description of the ComputerName  parameter.

	.EXAMPLE
				PS C:\> Get-CapaUnitLinkedUser -CapaSDK $value1 -ComputerName  'Value2'

	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitLinkedUser {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$ComputerName
	)

	$oaUnits = @()

	$aUnits = $CapaSDK.GetUnitLinkedUser($ComputerName)

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name         = $aItem[0];
			Created      = $aItem[1];
			LastExecuted = $aItem[2];
			Status       = $aItem[3];
			Description  = $aItem[4];
			GUID         = $aItem[5];
			ID           = $aItem[7];
			TypeName     = $aItem[8]
		}
	}

	Return $oaUnits
}
