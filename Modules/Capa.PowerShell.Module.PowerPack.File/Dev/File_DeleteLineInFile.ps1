# TODO: #67 Update and add tests

<#
    .SYNOPSIS
        Delete a line in a file.

		.DESCRIPTION
				This function deletes a line in a file that contains the specified text.

    .Parameter File
        The file to delete the line from.

    .Parameter Text
        The text to delete from the file.

    .Parameter OnlyFirstMatch
        Delete only the first match, default is false.

    .Parameter IgnoreCase
        Ignore case, default is false.

    .EXAMPLE
        File_DeleteLineInFile -File "C:\Temp\test.txt" -Text "Hello World"

    .NOTES
        For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455462/cs.File+DeleteLineInFile
#>
function File_DeleteLineInFile {
    param (
        [Parameter(Mandatory = $true)]
        [string]$File,
        [Parameter(Mandatory = $true)]
        [string]$Text,
        [bool]$OnlyFirstMatch = $false,
        [bool]$IgnoreCase = $false
    )

    $Global:Cs.File_DeleteLineInFile($File, $Text, $OnlyFirstMatch, $IgnoreCase)
}
