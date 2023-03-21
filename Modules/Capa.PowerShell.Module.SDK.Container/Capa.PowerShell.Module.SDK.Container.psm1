<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246124/Get+dll+version
	
	.DESCRIPTION
		A detailed description of the Get-CapaDllVersion function.
	
	.EXAMPLE
				PS C:\> Get-CapaDllVersion
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaDllVersion
{
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$value = $CapaSDK.GetDLLVersion()
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246132/Get+schedule
	
	.DESCRIPTION
		A detailed description of the Get-CapaSchedule function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER Id
		A description of the Id parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaSchedule -CapaSDK $value1 -Id 'Value2'
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaSchedule
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$Id
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetSchedule($Id)
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Id			      = $aItem[0];
			ScheduleStart	  = $aItem[1];
			ScheduleEnd	      = $aItem[2];
			Occurrences	      = $aItem[3];
			IntervalStart	  = $aItem[4];
			IntervalEnd	      = $aItem[5];
			Recurrence	      = $aItem[6];
			RecurrencePattern = $aItem[7];
			Run			      = $aItem[8];
			LastRun		      = $aItem[9];
			Active		      = $aItem[10];
			WOL			      = $aItem[11];
			Guid			  = $aItem[12]
		}
	}
	
	Return $oaUnits
}
