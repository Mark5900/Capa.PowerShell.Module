# TODO: Update and add tests

<#
    .SYNOPSIS
        Copy a folder.

    .Parameter Source
        The source folder.

    .Parameter Destination
        The destination folder and creates destination folder if it does not exist.

    .Parameter CopySubDirs
        Copy sub directories, default is true.

    .Parameter Overwrite
        Overwrite the destination files if they already exists, default is true.

    .EXAMPLE
        File_CopyTree -Source "C:\Temp\test" -Destination "C:\Temp\test2"

    .NOTES
        For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455411/cs.File+CopyTree
#>
Function File_CopyTree {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Source,
        [Parameter(Mandatory = $true)]
        [string]$Destination,
        [bool]$CopySubDirs = $true,
        [bool]$Overwrite = $true
    )

    $Global:Cs.File_CopyTree($Source, $Destination, $CopySubDirs, $Overwrite)
}
