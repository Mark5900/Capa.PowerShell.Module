
<#
    .SYNOPSIS
        Disable logging

    .DESCRIPTION
        Disable logging

    .EXAMPLE
        Job_DisableLog

    .NOTES
        Custom command
#>
function Job_DisableLog {
    [CmdletBinding()]
    param ()
    $global:cs.Job_DisableLog()
}




