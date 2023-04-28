<#
    .SYNOPSIS
        Initialize global variables

    .DESCRIPTION
        Initialize global variables

    .PARAMETER DllPath
        The path to the CapaOne.ScriptingLibrary.dll.

    .EXAMPLE
        Initialize-Variables -DllPath 'C:\Program Files (x86)\CapaOne\Scripting Library\CapaOne.ScriptingLibrary.dll'

    .NOTES
        Command from PSlib.psm1
#>
function Initialize-Variables {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$DllPath
    )
    try {
        Job_DisableLog
        
        if ($Cs.file_getfileversion($DllPath) -ge '0.2.0.0') {
            [string]$global:gsProgramFiles = $Cs.gsProgramFiles
            [string]$global:gsProgramFilesx86 = $Cs.gsProgramFilesx86
            [string]$global:gsWindir = $Cs.gsWindowsDir
            [string]$global:gsWindowsDir = $Cs.gsWindowsDir
            [string]$global:gsWorkstationPath = $Cs.gsWorkstationPath
            [string]$global:gsSystemRoot = $Cs.gsSystemRoot
            [string]$global:gsSystemDir = $Cs.gsSystemDir
            [string]$global:gsSystemDirx86 = $Cs.gsSystemDirx86
            [string]$global:gsLogDir = $Cs.gsLogDir
            [string]$global:gsTempDir = $Cs.gsTempDir
            [string]$global:gsOsSystem = $Cs.gsOsSystem
            [string]$global:gsOsVersion = $Cs.gsOsVersion
            [string]$global:gsLog = $Cs.gsLog
            [string]$global:gsLogName = $Cs.gsLogName
            [string]$global:gsTask = $Cs.gsTask
            [bool]$global:gbDisablelog = $Cs.gbDisablelog
            [bool]$global:gbSuficientDiskSpace = $Cs.gbSuficientDiskSpace
            [string]$global:gsJobName = $Cs.gsJobName
            [string]$global:gsLibrary = $Cs.gsLibrary
            [bool]$global:gbx64 = $Cs.gbx64
            [string]$global:gsCommonPrograms = $Cs.gsCommonPrograms
            [string]$global:gsSysDrive = $Cs.gsSysDrive
            [string]$global:gsCommonDesktop = $Cs.gsCommonDesktop
            [string]$global:gsCommonStartMenu = $Cs.gsCommonStartMenu
            [string]$global:gsCommonStartup = $Cs.gsCommonStartup
            [string]$global:gsCommonFilesDir = $Cs.gsCommonFilesDir
            [string]$global:gsCommonFiles = $Cs.gsCommonFilesDir
            [string]$global:gsCommonFilesDirx86 = $Cs.gsCommonFilesDirx86
            [string]$global:gsCommonFilesx86 = $Cs.gsCommonFilesDirx86
            [string]$global:gsCommonAppData = $Cs.gsCommonAppData
            [string]$global:gsProgramData = $Cs.gsProgramData
            [string]$global:gsProductid = $Cs.gsProductid
            [string]$global:gsAllusers = $Cs.gsAllusers
            [string]$global:gsWorkstationName = $Cs.gsWorkstationName
            [string]$global:gsOsBuild = $Cs.gsOsBuild
            [string]$global:gsEditionId = $Cs.gsEditionId
            [string]$global:gsDisplayVersion = $Cs.gsDisplayVersion
            [string]$global:gsWindowsType = $Cs.gsWindowsType
            [string]$global:gsOsArchitechture = $Cs.gsOsArchitechture
            [string]$global:gsWindowsVersion = $Cs.gsWindowsVersion
            [string]$global:gsUnitName = $Cs.gsUnitName
            [string]$global:gsComputerManufacturer = $Cs.gsComputerManufacturer
            [string]$global:gsComputerModel = $Cs.gsComputerModel
            [string]$global:gsUUID = $Cs.gsUUID
            $true
        } else {
            $false
        }

    } catch {
        Write-Error 'Error Line: ' $_.InvocationInfo.Line
        if ($Cs) {
            Job_WriteLog -Text "Initialize-Variables: Error Line: $($_.InvocationInfo.Line)" 
        }

        Write-Error 'Error Item: '$_.Exception.ItemName       
        if ($Cs) {
            Job_WriteLog -Text "Initialize-Variables: Error Item: $($_.Exception.ItemName)"
        }

        if ($Cs) {
            Job_WriteLog -Text "Initialize-Variables: '$($_.Exception.HResult)'"
        }
        $_.Exception.HResult
    } finally {
        Job_EnableLog
    }
}