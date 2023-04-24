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
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$ServerName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$PackageType
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetOSDiskConfiguration($ServerName, $PackageType)
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name               = $aItem[0];
			Version            = $aItem[1];
			Type               = $aItem[2];
			DisplayName        = $aItem[3];
			IsMandatory        = $aItem[4];
			ScheduleId         = $aItem[5];
			Description        = $aItem[7];
			GUID               = $aItem[8];
			ID                 = $aItem[9];
			IsInteractive      = $aItem[10];
			DependendPackageID = $aItem[11];
			IsInventoryPackage = $aItem[12];
			CollectMode        = $aItem[13];
			Priority           = $aItem[14];
			ServerDeploy       = $aItem[15]
		}
	}
	
	Return $oaUnits
}
