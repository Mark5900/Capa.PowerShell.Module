# TODO: #63 Update and add tests

<#
    .SYNOPSIS
        Create a directory.

		.DESCRIPTION
				This function creates a directory at the specified path.

    .Parameter Path
        The path to Create.

    .EXAMPLE
        File_CreateDir -Path "C:\Temp\test"

    .NOTES
        For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455428/cs.File+CreateDir
#>
function File_CreateDir {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    $Global:Cs.File_CreateDir($Path)
}
