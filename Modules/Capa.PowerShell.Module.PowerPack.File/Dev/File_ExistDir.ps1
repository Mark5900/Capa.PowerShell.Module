# TODO: #68 Update and add tests

<#
    .SYNOPSIS
        Check if a folder exists.

		.DESCRIPTION
				This function checks if the specified folder exists.

    .Parameter Path
        The folder to check.

    .EXAMPLE
        File_ExistDir -Path "C:\Temp\test"

    .NOTES
        For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455530/cs.File+ExistDir
#>
function File_ExistDir {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    $Value = $Global:Cs.File_ExistDir($Path)

    return $Value
}
