<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247348/Add+unit+to+reinstall
	
	.DESCRIPTION
		A detailed description of the Add-CapaUnitToReinstall function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER ComputerName
		A description of the ComputerName parameter.
	
	.PARAMETER OSpointID
		A description of the OSpointID parameter.
	
	.PARAMETER OSserverID
		A description of the OSserverID parameter.
	
	.PARAMETER OSImageID
		A description of the OSImageID parameter.
	
	.PARAMETER DiskConfigID
		A description of the DiskConfigID parameter.
	
	.PARAMETER InstallTypeID
		A description of the InstallTypeID parameter.
	
	.PARAMETER NewUnitName
		A description of the NewUnitName parameter.
	
	.PARAMETER ReinstallMode
		A description of the ReinstallMode parameter.
	
	.PARAMETER Active
		A description of the Active parameter.
	
	.PARAMETER UnlinkAllPackagesAndGroups
		A description of the UnlinkAllPackagesAndGroups parameter.
	
	.PARAMETER UnlinkAllAdvPackages
		A description of the UnlinkAllAdvPackages parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment parameter.
	
	.PARAMETER ReinstallStartDate
		A description of the ReinstallStartDate parameter.
	
	.PARAMETER CustomField1
		A description of the CustomField1 parameter.
	
	.PARAMETER CustomField2
		A description of the CustomField2 parameter.
	
	.EXAMPLE
				PS C:\> Add-CapaUnitToReinstall -CapaSDK $value1 -ComputerName 'Value2' -OSpointID $value3 -OSserverID $value4 -OSImageID $value5 -DiskConfigID $value6 -InstallTypeID $value7
	
	.NOTES
		Additional information about the function.
#>
function Add-CapaUnitToReinstall
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[Alias('UUID')]
		[String]$ComputerName,
		[Parameter(Mandatory = $true)]
		[int]$OSpointID,
		[Parameter(Mandatory = $true)]
		[int]$OSserverID,
		[Parameter(Mandatory = $true)]
		[int]$OSImageID,
		[Parameter(Mandatory = $true)]
		[int]$DiskConfigID,
		[Parameter(Mandatory = $true)]
		[int]$InstallTypeID,
		[String]$NewUnitName = '',
		[Parameter(Mandatory = $false)]
		[ValidateSet('Silent', 'AlwaysConfirm', 'ConfirmOnlyIfUserLoggedOn')]
		[String]$ReinstallMode = 'Silent',
		[ValidateSet('True', 'False')]
		[bool]$Active = $true,
		[ValidateSet('True', 'False')]
		[bool]$UnlinkAllPackagesAndGroups = $false,
		[ValidateSet('True', 'False')]
		[bool]$UnlinkAllAdvPackages = $false,
		[String]$ChangelogComment = '',
		[String]$ReinstallStartDate = '',
		[String]$CustomField1 = '',
		[String]$CustomField2 = ''
	)
	
	$value = $CapaSDK.AddUnitToReinstall($ComputerName, $OSpointID, $OSserverID, $OSImageID, $DiskConfigID, $InstallTypeID, $NewUnitName, $ReinstallMode, $Active, $UnlinkAllPackagesAndGroups, $ChangelogComment, $ReinstallStartDate, $CustomField1, $CustomField2)
	return $value
}
