# TODO: #71 Update and add tests

<#
    .SYNOPSIS
        Get the file version of a file.

		.DESCRIPTION
				This function retrieves the file version of the specified file.

    .Parameter FilePath
        The file to get the version from.

    .EXAMPLE
        File_GetFileVersion -FilePath "C:\Temp\test.txt"

    .NOTES
        For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455564/cs.File+GetFileVersion
#>
function File_GetFileVersion {
    param (
        [Parameter(Mandatory = $true)]
        [string]$FilePath
    )

    $Value = $Global:Cs.File_GetFileVersion($FilePath)

    return $Value
}
