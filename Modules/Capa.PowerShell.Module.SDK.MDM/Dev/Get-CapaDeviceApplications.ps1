# TODO: #145 Update and add tests

<#
	.SYNOPSIS
		Get all the Device Applications.

	.DESCRIPTION
		Get all the Device Applications from the Default Management Point.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.EXAMPLE
		PS C:\> Get-CapaDeviceApplications -CapaSDK $CapaSDK

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246614/Get+Device+Applications
#>
function Get-CapaDeviceApplications {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)

	$oaUnits = @()

	$aUnits = $CapaSDK.GetDeviceApplications()

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID          = $aItem[0];
			Name        = $aItem[1];
			Description = $aItem[2];
			Priority    = $aItem[3];
			Version     = $aItem[4];
			CMPID       = $aItem[5];
			GUID        = $aItem[6]
		}
	}

	Return $oaUnits
}
