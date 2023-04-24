
<#
    .SYNOPSIS
        Append text to a file.

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


<#
    .SYNOPSIS
        Copy a file.

    .Parameter Source
        The source file.

    .Parameter Destination
        The destination file.

    .Parameter Overwrite
        Overwrite the destination file if it already exists.

    .EXAMPLE
        File_CopyFile -Source "C:\Temp\test.txt" -Destination "C:\Temp\test2.txt"

    .NOTES
        For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455394/cs.File+CopyFile
#>
function File_CopyFile {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Source,
        [Parameter(Mandatory = $true)]
        [string]$Destination,
        [bool]$Overwrite = $true
    )

    $Global:Cs.File_CopyFile($Source, $Destination, $Overwrite)
}



<#
    .SYNOPSIS
        Copy a folder.

    .Parameter Source
        The source folder.

    .Parameter Destination
        The destination folder and creates destination folder if it does not exist.

    .Parameter CopySubDirs
        Copy sub directories, default is true.

    .Parameter Overwrite
        Overwrite the destination files if they already exists, default is true.

    .EXAMPLE
        File_CopyTree -Source "C:\Temp\test" -Destination "C:\Temp\test2"

    .NOTES
        For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455411/cs.File+CopyTree
#>
Function File_CopyTree {
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


<#
    .SYNOPSIS
        Create a directory.

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


<#
    .SYNOPSIS
        Delete path if it is empty.

    .Parameter Path
        The path to delete.

    .EXAMPLE
        File_DelEmptyFolder -Path "C:\Temp\test"

    .NOTES
        https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455445/cs.File+DelEmptyFolder
#>
function File_DelEmptyFolder {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    $Global:Cs.File_DelEmptyFolder($Path)
}


<#
    .SYNOPSIS
        Delete a line in a file.

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


<#
    .SYNOPSIS
        Delete a file.

    .Parameter FilePath
        The file to delete.

    .Parameter Recursive
        Delete files from sub directories, relative to FilePath. Default is false.

    .EXAMPLE
        File_DelFile -FilePath "C:\Temp\test.txt"

    .NOTES
        For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455479/cs.File+DelFile
#>
function File_DelFile {
    param (
        [Parameter(Mandatory = $true)]
        [string]$FilePath,
        [bool]$Recursive = $false
    )

    $Global:Cs.File_DelFile($FilePath, $Recursive)
}


<#
    .SYNOPSIS
        Delete a folder.

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


<#
    .SYNOPSIS
        Check if a folder exists.

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


<#
    .SYNOPSIS
        Check if a file exists.

    .Parameter FilePath
        The file to check.

    .EXAMPLE
        File_ExistFile -FilePath "C:\Temp\test.txt"

    .NOTES
        For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455513/cs.File+ExistFile
#>
function File_ExistFile {
    param (
        [Parameter(Mandatory = $true)]
        [string]$FilePath
    )

    $Value = $Global:Cs.File_ExistFile($FilePath)

    return $Value
}


<#
    .SYNOPSIS
        Find a file.

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


<#
    .SYNOPSIS
        Get the file version of a file.

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


<#
    .SYNOPSIS
        Get the product version of a file.

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


<#
    .SYNOPSIS
        Rename a folder.

    .Parameter Source
        The folder to rename.

    .Parameter Destination
        The new name of the folder.

    .Parameter Overwrite
        Overwrite the destination folder if it already exists, default is true (equals copytree and delete source).

    .EXAMPLE
        File_RenameDir -Source "C:\Temp\test" -Destination "C:\Temp\test2"

    .NOTES
        For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455598/cs.File+RenameDir
#>
function File_RenameDir {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Source,
        [Parameter(Mandatory = $true)]
        [string]$Destination,
        [bool]$Overwrite = $true
    )

    $Global:Cs.File_RenameDir($Source, $Destination, $Overwrite)
}


<#
    .SYNOPSIS
        Rename a file.

    .Parameter Source
        The file to rename.

    .Parameter Destination
        The new name of the file.

    .Parameter Overwrite
        Overwrite the destination file if it already exists, default is true.

    .EXAMPLE
        File_RenameFile -Source "C:\Temp\test.txt" -Destination "C:\Temp\test2.txt"

    .NOTES
        For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455615/cs.File+RenameFile
#>
function File_RenameFile {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Source,
        [Parameter(Mandatory = $true)]
        [string]$Destination,
        [bool]$Overwrite = $true
    )

    $Global:Cs.File_RenameFile($Source, $Destination, $Overwrite)
}


