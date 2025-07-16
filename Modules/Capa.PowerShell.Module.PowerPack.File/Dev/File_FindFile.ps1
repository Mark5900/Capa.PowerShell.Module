# TODO: #70 Update and add tests

<#
    .SYNOPSIS
        Find a file.

		.DESCRIPTION
				This function finds the specified file.

    .Parameter FileName
        The file to find.

    .Parameter SearchRoot
        The root folder to start the search.

    .Parameter Recursive
        Search in sub directories, relative to SearchRoot. Default is true.

    .EXAMPLE
        File_FindFile -FileName "test.txt" -SearchRoot "C:\Temp"

    .NOTES
        For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455547/cs.File+FindFile
#>
function File_FindFile {
    param (
        [Parameter(Mandatory = $true)]
        [string]$FileName,
        [Parameter(Mandatory = $true)]
        [string]$SearchRoot,
        [bool]$Recursive = $true
    )

    $Value = $Global:Cs.File_FindFile($FileName, $SearchRoot, $Recursive)

    return $Value
}
