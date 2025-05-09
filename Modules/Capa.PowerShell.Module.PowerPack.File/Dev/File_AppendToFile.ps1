# TODO: #60 Update and add tests

<#
    .SYNOPSIS
        Append text to a file.

		.DESCRIPTION
				This function appends the specified text to the end of the specified file.

    .Parameter File
        The file to append to.

    .Parameter Text
        The text to append to the file.

    .EXAMPLE
        File_AppendToFile -File "C:\Temp\test.txt" -Text "Hello World"

    .NOTES
        For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455377/cs.File+AppendToFile
#>
function File_AppendToFile {
    param (
        [Parameter(Mandatory = $true)]
        [string]$File,
        [Parameter(Mandatory = $true)]
        [string]$Text
    )

    $Global:Cs.File_AppendToFile($File, $Text)
}
