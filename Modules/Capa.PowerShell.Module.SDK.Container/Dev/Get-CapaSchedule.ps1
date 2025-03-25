# TODO: #111 Update and add tests

<#
	.SYNOPSIS
		Returns a schedule object by id.

	.DESCRIPTION
		Will return something like this: 5|06-01-2011 12:00:00||0|00:00:00|1.00:00:00|Periodical|RecurEvery[1] weeks on [Monday-Tuesday-Wednesday-Thursday-Friday-Saturday-Sunday]|Weekly||True||842b2894-cdab-4a2c-905c-17ee052179db

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER Id
		Id of the requested unit.

	.EXAMPLE
		PS C:\> Get-CapaSchedule -CapaSDK $CapaSDK -Id '5'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI67DOC/pages/20342580716/Get+schedule
#>
function Get-CapaSchedule {
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

    foreach ($sItem in $aUnits) {
        $aItem = $sItem.Split(';')
        $oaUnits += [pscustomobject]@{
            Id                = $aItem[0];
            ScheduleStart     = $aItem[1];
            ScheduleEnd       = $aItem[2];
            Occurrences       = $aItem[3];
            IntervalStart     = $aItem[4];
            IntervalEnd       = $aItem[5];
            Recurrence        = $aItem[6];
            RecurrencePattern = $aItem[7];
            Run               = $aItem[8];
            LastRun           = $aItem[9];
            Active            = $aItem[10];
            WOL               = $aItem[11];
            Guid              = $aItem[12]
        }
    }

    Return $oaUnits
}
