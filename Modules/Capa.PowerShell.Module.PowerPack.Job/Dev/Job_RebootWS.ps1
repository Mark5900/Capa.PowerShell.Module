# TODO: #79 Update and add tests

<#
    .SYNOPSIS
        Job request reboot of the workstation

    .DESCRIPTION
        Job request reboot of the workstation

    .PARAMETER Text
        The text to write to the log

    .EXAMPLE
        Job_RebootWS -Text 'Reboot requested'

    .NOTES
        Command from PSlib.psm1
#>
function Job_RebootWS {
    [CmdletBinding()]
    [Alias('Invoke-Job_RebootWS')]
    Param(
        [Parameter(Mandatory = $false)]
        [string]$Text
    )
    $cs.Job_RebootWS($Text)
}