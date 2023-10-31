# TODO: Update and add tests

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
    [Aliases('Invoke-Job_RebootWS')]
    Param(
        [Parameter(Mandatory = $false)]
        [string]$Text
    )
    try {
        Write-Host $Text
        if ($cs) {
            Job_WriteLog -Text "Call Invoke-Job_RebootWS with text: '$Text'"
        }
        if ($InputObject) { $InputObject.RebootRequested = $true }
    } catch {
        Write-Error 'Error Line: ' $_.InvocationInfo.Line
        if ($cs) {
            Job_WriteLog -Text "Invoke-Job_RebootWS: Error Line: $($_.InvocationInfo.Line)"
        }

        Write-Error 'Error Item: '$_.Exception.ItemName
        if ($cs) {
            Job_WriteLog -Text "Invoke-Job_RebootWS: Error Item: $($_.Exception.ItemName)"
        }

        if ($cs) {
            Job_WriteLog -Text "Invoke-Job_RebootWS: '$($_.Exception.HResult)'"
        }
        $_.Exception.HResult
    }
}