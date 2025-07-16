# TODO: #72 Update and add tests

<#
    .SYNOPSIS
        Get the product version of a file.

		.DESCRIPTION
				This function retrieves the product version of the specified file.

    .Parameter FilePath
        The file to get the product version from.

    .EXAMPLE
        File_GetProductVersion -FilePath "C:\Temp\firefox.exe"

    .NOTES
        For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455581/cs.File+GetProductVersion
#>
function File_GetProductVersion {
    param (
        [Parameter(Mandatory = $true)]
        [string]$FilePath
    )

    $Value = $Global:Cs.File_GetProductVersion($FilePath)

    return $Value
}
