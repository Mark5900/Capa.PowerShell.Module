<#
	.SYNOPSIS
		Adds a unit to reinstall.

	.DESCRIPTION
		Adds the specified unit to reinstall by calling the CapaSDK method
		AddUnitToReinstall.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER ComputerName
		Computer unit name (or UUID alias) to add to reinstall.

	.PARAMETER OSpointID
		OS point ID.

	.PARAMETER OSserverID
		OS server ID.

	.PARAMETER OSImageID
		OS image ID.

	.PARAMETER DiskConfigID
		Disk configuration ID.

	.PARAMETER InstallTypeID
		Installation type ID.

	.PARAMETER NewUnitName
		Optional new unit name after reinstall.

	.PARAMETER ReinstallMode
		Reinstall mode.

	.PARAMETER Active
		Whether reinstall entry is active.

	.PARAMETER UnlinkAllPackagesAndGroups
		Whether to unlink all packages and groups.

	.PARAMETER UnlinkAllAdvPackages
		Whether to unlink all advanced packages.

	.PARAMETER ChangelogComment
		Optional changelog comment.

	.PARAMETER ReinstallStartDate
		Optional reinstall start date.

	.PARAMETER CustomField1
		Optional custom field 1.

	.PARAMETER CustomField2
		Optional custom field 2.

	.EXAMPLE
		PS C:\> Add-CapaUnitToReinstall -CapaSDK $CapaSDK -ComputerName 'PC-01' -OSpointID 1 -OSserverID 1 -OSImageID 1 -DiskConfigID 1 -InstallTypeID 1

		Adds PC-01 to reinstall.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247348/Add+unit+to+reinstall
#>
function Add-CapaUnitToReinstall {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[Alias('UUID')]
		[ValidateNotNullOrEmpty()]
		[String]$ComputerName,
		[Parameter(Mandatory = $true)]
		[ValidateRange(1, 2147483647)]
		[int]$OSpointID,
		[Parameter(Mandatory = $true)]
		[ValidateRange(1, 2147483647)]
		[int]$OSserverID,
		[Parameter(Mandatory = $true)]
		[ValidateRange(1, 2147483647)]
		[int]$OSImageID,
		[Parameter(Mandatory = $true)]
		[ValidateRange(1, 2147483647)]
		[int]$DiskConfigID,
		[Parameter(Mandatory = $true)]
		[ValidateRange(1, 2147483647)]
		[int]$InstallTypeID,
		[String]$NewUnitName = '',
		[Parameter(Mandatory = $false)]
		[ValidateSet('Silent', 'AlwaysConfirm', 'ConfirmOnlyIfUserLoggedOn')]
		[String]$ReinstallMode = 'Silent',
		[bool]$Active = $true,
		[bool]$UnlinkAllPackagesAndGroups = $false,
		[bool]$UnlinkAllAdvPackages = $false,
		[String]$ChangelogComment = '',
		[String]$ReinstallStartDate = '',
		[String]$CustomField1 = '',
		[String]$CustomField2 = ''
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'AddUnitToReinstall')) {
		throw 'CapaSDK does not contain method AddUnitToReinstall.'
	}

	$target = "Computer unit '$ComputerName'"
	$action = 'Add to reinstall'
	if (-not $PSCmdlet.ShouldProcess($target, $action)) {
		return
	}

	$value = $CapaSDK.AddUnitToReinstall($ComputerName, $OSpointID, $OSserverID, $OSImageID, $DiskConfigID, $InstallTypeID, $NewUnitName, $ReinstallMode, $Active, $UnlinkAllPackagesAndGroups, $UnlinkAllAdvPackages, $ChangelogComment, $ReinstallStartDate, $CustomField1, $CustomField2)
	return $value
}
