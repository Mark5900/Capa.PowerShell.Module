<#
.SYNOPSIS
Copy a folder.

.DESCRIPTION
This function copies a folder from the source to the destination.

.PARAMETER Source
The source folder.

.PARAMETER Destination
The destination folder. Creates destination folder if it does not exist.

.PARAMETER CopySubDirs
Copy sub directories. Default is $true.

.PARAMETER Overwrite
Overwrite the destination files if they already exist. Default is $true.

.EXAMPLE
File_CopyTree -Source "C:\Temp\test" -Destination "C:\Temp\test2"

.NOTES
For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455411/cs.File+CopyTree
#>
function File_CopyTree {
[CmdletBinding()]
param (
[Parameter(Mandatory = $true)]
[string]$Source,
[Parameter(Mandatory = $true)]
[string]$Destination,
[bool]$CopySubDirs = $true,
[bool]$Overwrite = $true
)

$Global:Cs.File_CopyTree($Source, $Destination, $CopySubDirs, $Overwrite)
}
