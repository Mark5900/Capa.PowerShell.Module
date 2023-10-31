# TODO: Update and add tests

<#
    .SYNOPSIS
        Delete path if it is empty.

    .Parameter Path
        The path to delete.

    .EXAMPLE
        File_DelEmptyFolder -Path "C:\Temp\test"

    .NOTES
        https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455445/cs.File+DelEmptyFolder
#>
function File_DelEmptyFolder {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    $Global:Cs.File_DelEmptyFolder($Path)
}
