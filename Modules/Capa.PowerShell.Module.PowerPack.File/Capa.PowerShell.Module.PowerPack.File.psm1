function File_AppendToFile {
    param (
        [Parameter(Mandatory = $true)]
        [string]$File,
        [Parameter(Mandatory = $true)]
        [string]$Text
    )

    $Global:Cs.File_AppendToFile($File, $Text)
}

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

function File_CreateDir {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    $Global:Cs.File_CreateDir($Path)
} 

function File_DelEmptyFolder {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    $Global:Cs.File_DelEmptyFolder($Path)
}

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

function File_DelFile {
    param (
        [Parameter(Mandatory = $true)]
        [string]$FilePath,
        [bool]$Recursive = $false
    )

    $Global:Cs.File_DelFile($FilePath, $Recursive)
}

function File_DelTree {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    $Global:Cs.File_DelTree($Path)
}

function File_ExistFile {
    param (
        [Parameter(Mandatory = $true)]
        [string]$FilePath
    )

    $Value = $Global:Cs.File_ExistFile($FilePath)

    return $Value
}

function File_ExistDir {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    $Value = $Global:Cs.File_ExistDir($Path)

    return $Value
}

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

function File_GetFileVersion {
    param (
        [Parameter(Mandatory = $true)]
        [string]$FilePath
    )

    $Value = $Global:Cs.File_GetFileVersion($FilePath)

    return $Value
}

function File_GetProductVersion {
    param (
        [Parameter(Mandatory = $true)]
        [string]$FilePath
    )

    $Value = $Global:Cs.File_GetProductVersion($FilePath)

    return $Value
}

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