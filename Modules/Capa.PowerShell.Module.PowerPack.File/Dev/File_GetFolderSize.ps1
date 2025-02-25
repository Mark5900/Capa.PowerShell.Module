# TODO: #398 Add tests for File_GetFolderSize

<#
	.SYNOPSIS
		Get the size of a folder.

	.DESCRIPTION
		Get the size of a folder and return the size in bytes.

	.Parameter FilePath
		The folder to get the size from.

	.EXAMPLE
		File_GetFolderSize -FilePath "C:\Temp"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI66DOC/pages/20251410491/cs.File_GetFolderSize
#>
function File_GetFolderSize {
	param (
		[Parameter(Mandatory = $true)]
		[string]$FilePath
	)

	return $Global:Cs.File_GetFolderSize($FilePath)
}