# TODO: #66 Update and add tests

<#
    .SYNOPSIS
        Delete a folder.

		.DESCRIPTION
				This function deletes the specified folder.

    .Parameter Path
        The folder to delete.

    .EXAMPLE
        File_DelTree -Path "C:\Temp\test"

    .NOTES
        For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455496/cs.File+DelTree
#>
function File_DelTree {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    $Global:Cs.File_DelTree($Path)
}
