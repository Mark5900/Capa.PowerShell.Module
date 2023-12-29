# TODO: #73 Update and add tests

<#
    .SYNOPSIS
        Rename a folder.

    .Parameter Source
        The folder to rename.

    .Parameter Destination
        The new name of the folder.

    .Parameter Overwrite
        Overwrite the destination folder if it already exists, default is true (equals copytree and delete source).

    .EXAMPLE
        File_RenameDir -Source "C:\Temp\test" -Destination "C:\Temp\test2"

    .NOTES
        For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455598/cs.File+RenameDir
#>
function File_RenameDir {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Source,
        [Parameter(Mandatory = $true)]
        [string]$Destination,
        [bool]$Overwrite = $true
    )

    $Global:Cs.File_RenameDir($Source, $Destination, $Overwrite)
}
