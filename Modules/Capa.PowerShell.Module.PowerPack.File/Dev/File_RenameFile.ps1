<#
    .SYNOPSIS
        Rename a file.

    .Parameter Source
        The file to rename.

    .Parameter Destination
        The new name of the file.

    .Parameter Overwrite
        Overwrite the destination file if it already exists, default is true.

    .EXAMPLE
        File_RenameFile -Source "C:\Temp\test.txt" -Destination "C:\Temp\test2.txt"

    .NOTES
        For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455615/cs.File+RenameFile
#>
function File_RenameFile {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Source,
        [Parameter(Mandatory = $true)]
        [string]$Destination,
        [bool]$Overwrite = $true
    )

    $Global:Cs.File_RenameFile($Source, $Destination, $Overwrite)
}
