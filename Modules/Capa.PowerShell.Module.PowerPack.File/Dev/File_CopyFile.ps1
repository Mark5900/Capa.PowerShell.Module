<#
    .SYNOPSIS
        Copy a file.

    .Parameter Source
        The source file.

    .Parameter Destination
        The destination file.

    .Parameter Overwrite
        Overwrite the destination file if it already exists.

    .EXAMPLE
        File_CopyFile -Source "C:\Temp\test.txt" -Destination "C:\Temp\test2.txt"

    .NOTES
        For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455394/cs.File+CopyFile
#>
function File_CopyFile {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Source,
        [Parameter(Mandatory = $true)]
        [string]$Destination,
        [bool]$Overwrite = $true
    )

    $Global:Cs.File_CopyFile($Source, $Destination, $Overwrite)
}

