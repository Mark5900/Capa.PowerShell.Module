<#
	.SYNOPSIS
		Get a list of packages on a management server.

	.DESCRIPTION
		Get a list of packages on a management server.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER ServerName
		The name of the management server.

	.PARAMETER PackageType
		The type of package, can be either Computer or User.

	.EXAMPLE
				PS C:\> Get-CapaPackagesOnManagementServer -CapaSDK $CapaSDK -ServerName 'TestServer' -PackageType 'Computer'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246974/Get+packages+on+management+server
#>
function Get-CapaPackagesOnManagementServer {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$ServerName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$PackageType
	)

	$oaUnits = @()

	$aUnits = $CapaSDK.GetPackagesOnManagementServer($ServerName, $PackageType)

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name               = $aItem[0];
			Version            = $aItem[1];
			Type               = $aItem[2];
			DisplayName        = $aItem[3];
			IsMandatory        = $aItem[4];
			ScheduleId         = $aItem[5];
			Description        = $aItem[6];
			GUID               = $aItem[7];
			ID                 = $aItem[8];
			IsInteractive      = $aItem[9];
			DependendPackageID = $aItem[10];
			IsInventoryPackage = $aItem[11];
			CollectMode        = $aItem[12];
			Priority           = $aItem[13];
			ServerDeploy       = $aItem[14]
		}
	}

	return $oaUnits
}
