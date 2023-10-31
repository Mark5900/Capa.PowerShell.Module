# TODO: Update and add tests

<#
    .SYNOPSIS
        Delete a file.

    .Parameter FilePath
        The file to delete.

    .Parameter Recursive
        Delete files from sub directories, relative to FilePath. Default is false.

    .EXAMPLE
        File_DelFile -FilePath "C:\Temp\test.txt"

    .NOTES
        For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455479/cs.File+DelFile
#>
function File_DelFile {
    param (
        [Parameter(Mandatory = $true)]
        [string]$FilePath,
        [bool]$Recursive = $false
    )

    $Global:Cs.File_DelFile($FilePath, $Recursive)
}
