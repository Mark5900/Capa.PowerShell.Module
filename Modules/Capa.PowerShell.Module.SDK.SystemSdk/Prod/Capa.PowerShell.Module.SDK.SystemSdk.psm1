
<#
	.SYNOPSIS
		Counts the number of conscom actions.

	.DESCRIPTION
		Counts the number of conscom actions.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER ManagementServerID
		The management server ID to check for. If omitted, conscom actions for all servers are counted.

	.EXAMPLE
		PS C:\> Count-CapaConscomActions -CapaSDK $CapaSDK -ManagementServerID 1

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247078/Count+conscom+actions
#>
function Count-CapaConscomActions {
	[CmdletBinding()]
	[OutputType([int])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		$CapaSDK,
		[Parameter(Mandatory = $false)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$ManagementServerID
	)

	$value = $CapaSDK.CountConscomActions($ManagementServerID)
	return $value
}


<#
	.SYNOPSIS
		Get a list of all business units.

	.DESCRIPTION
		Get a list of all business units.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.EXAMPLE
		PS C:\> Get-CapaBusinessUnits -CapaSDK $CapaSDK

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247086/Get+Business+Units
#>
function Get-CapaBusinessUnits {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		$CapaSDK
	)

	$oaUnits = @()

	$aUnits = $CapaSDK.GetBusinessUnits()

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name = $aItem[0];
			GUID = $aItem[1];
			Id   = $aItem[2]
		}
	}

	return $oaUnits
}


<#
	.SYNOPSIS
		Get a list of all external tools.

	.DESCRIPTION
		Get a list of all external tools.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.EXAMPLE
		PS C:\> Get-CapaExternalTools -CapaSDK $CapaSDK

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247096/Get+external+tools
#>
function Get-CapaExternalTools {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		$CapaSDK
	)

	$oaUnits = @()

	$aUnits = $CapaSDK.GetExternalTools()

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID        = $aItem[0];
			Name      = $aItem[1];
			Path      = $aItem[2];
			Arguments = $aItem[3]
		}
	}

	return $oaUnits
}


<#
	.SYNOPSIS
		Get management points or a specific management point.

	.DESCRIPTION
		If CmpId is not specified, all management points are returned.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER CmpId
		The ID of the management point to return. If omitted, all management points are returned.

	.EXAMPLE
				PS C:\> Get-CapaManagementPoint -CapaSDK $value1 -CmpId $value2

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247106/Get+management+point
		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247116/Get+management+points
#>
function Get-CapaManagementPoint {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		$CapaSDK,
		[int]$CmpId
	)

	$oaUnits = @()

	if (-not $PSBoundParameters.ContainsKey('CmpId')) {
		$aUnits = $CapaSDK.GetManagementPoints()
	} else {
		$aUnits = $CapaSDK.GetManagementPoint($CmpId)
	}

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Id          = $aItem[0];
			Name        = $aItem[1];
			Description = $aItem[2];
			Drive       = $aItem[3];
			GUID        = $aItem[4];
			LocalFolder = $aItem[5];
			Server      = $aItem[6];
			Share       = $aItem[7];
			ParentGUID  = $aItem[8]
		}
	}

	return $oaUnits
}


<#
	.SYNOPSIS
		Get a list of all management servers.

	.DESCRIPTION
		Get a list of all management servers.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.EXAMPLE
		PS C:\> Get-CapaManagementServers -CapaSDK $CapaSDK

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247126/Get+management+servers
#>
function Get-CapaManagementServers {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		$CapaSDK
	)

	$oaUnits = @()

	$aUnits = $CapaSDK.GetManagementServers()

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name          = $aItem[0];
			Path          = $aItem[1];
			Version       = $aItem[2];
			Drive         = $aItem[3];
			Server        = $aItem[4];
			Share         = $aItem[5];
			IsParentShare = $aItem[7];
			GUID          = $aItem[8];
			ID            = $aItem[9]
		}
	}

	return $oaUnits
}


<#
	.SYNOPSIS
		Rebuilds CapaInstaller.kit file on Management Server.

	.DESCRIPTION
		Rebuilds CapaInstaller.kit file on Management Server. The function sets an action for the assigned Replicator to perform.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The version of the package.

	.PARAMETER PackageType
		The type of the package.

	.PARAMETER ServerName
		The management server to which the package is to be added to.

	.EXAMPLE
		PS C:\> Rebuild-CapaKitFileOnManagementServer -CapaSDK $CapaSDK -PackageName 'WinRaR' -PackageVersion '5.50' -PackageType 'Computer' -ServerName 'MS1'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247144/Rebuild+kit+on+Management+Server
#>
function Rebuild-CapaKitFileOnManagementServer {
	[CmdletBinding(SupportsShouldProcess = $true)]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[String]$PackageType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$ServerName
	)

	if ($PackageType -eq 'Computer') {
		$PackageType = '1'
	} elseif ($PackageType -eq 'User') {
		$PackageType = '2'
	}

	if ($PSCmdlet.ShouldProcess("$PackageName $PackageVersion", "Rebuild kit on management server '$ServerName'")) {
		$value = $CapaSDK.RebuildKitFileOnServer($PackageName, $PackageVersion, $PackageType, $ServerName)
		return $value
	}
}


<#
	.SYNOPSIS
		Rebuilds CapaInstaller.kit file on all Management Servers in the given Management Point.

	.DESCRIPTION
		Rebuilds CapaInstaller.kit file on all Management Servers in the given Management Point.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The version of the package.

	.PARAMETER PackageType
		The type of the package.

	.PARAMETER PointID
		The ID of the management point.

	.EXAMPLE
		PS C:\> Rebuild-CapaKitFileOnPoint -CapaSDK $CapaSDK -PackageName 'WinRaR' -PackageVersion '5.50' -PackageType 'Computer' -PointID 1

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247136/Rebuild+kit+on+Management+Point
#>
function Rebuild-CapaKitFileOnPoint {
	[CmdletBinding(SupportsShouldProcess = $true)]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[String]$PackageType,
		[Parameter(Mandatory = $true)]
		[ValidateRange(1, [int]::MaxValue)]
		[int]$PointID
	)

	if ($PackageType -eq 'Computer') {
		$PackageType = '1'
	} elseif ($PackageType -eq 'User') {
		$PackageType = '2'
	}

	if ($PSCmdlet.ShouldProcess("$PackageName $PackageVersion", "Rebuild kit on management point '$PointID'")) {
		$value = $CapaSDK.RebuildKitFileOnPoint($PackageName, $PackageVersion, $PackageType, $PointID)
		return $value
	}
}


<#
	.SYNOPSIS
		Resets the last run date on a global task.

	.DESCRIPTION
		Returns the last run date on a global task.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER TaskDisplayName
		The display name of the task. Can be one of the following:
			Auto Archive Changelog
			Cleanup Performance Index Data
			Clear Changeset
			Clear Deleted Units
			Group Health Check
			Inventory Cleanup
			Process Metering History
			Process SQL groups
			System Health
			Update Active Directory Groups
			Update Application Groups
			Update OS Version
			Update Unit Commands
			Update Unlicensed Software Queries

	.EXAMPLE
		PS C:\> Reset-CapaLastRunDateOnGlobalTask -CapaSDK $CapaSDK -TaskDisplayName 'Auto Archive Changelog'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247152/Reset+LastRun+Date+On+Global+Task
#>
function Reset-CapaLastRunDateOnGlobalTask {
	[CmdletBinding(SupportsShouldProcess = $true)]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Auto Archive Changelog', 'Cleanup Performance Index Data', 'Clear Changeset', 'Clear Deleted Units', 'Group Health Check', 'Inventory Cleanup', 'Process Metering History', 'Process SQL groups', 'System Health', 'Update Active Directory Groups', 'Update Application Groups', 'Update OS Version', 'Update Unit Commands', 'Update Unlicensed Software Queries')]
		[string]$TaskDisplayName
	)

	if ($PSCmdlet.ShouldProcess($TaskDisplayName, 'Reset last run date on global task')) {
		$value = $CapaSDK.ResetLastRunOnGlobalTask($TaskDisplayName)
		return $value
	}
}


