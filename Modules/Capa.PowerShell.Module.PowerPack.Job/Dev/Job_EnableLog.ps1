
<#
    .SYNOPSIS
        Enable logging

    .DESCRIPTION
        Enable logging

    .EXAMPLE
        Job_EnableLog

    .NOTES
        Custom command
#>
function Job_EnableLog {
    [CmdletBinding()]
	param ()
    $global:cs.Job_EnableLog()
}



