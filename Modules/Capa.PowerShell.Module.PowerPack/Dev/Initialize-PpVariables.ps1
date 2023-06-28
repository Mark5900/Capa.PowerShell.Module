<#
    .SYNOPSIS
        Initialize global variables

    .DESCRIPTION
        Initialize global variables

    .PARAMETER DllPath
        The path to the CapaOne.ScriptingLibrary.dll.

    .EXAMPLE
        Initialize-PpVariables -DllPath 'C:\Program Files (x86)\CapaOne\Scripting Library\CapaOne.ScriptingLibrary.dll'

    .NOTES
        Command from PSlib.psm1
#>
function Initialize-PpVariables {
    [CmdletBinding()]
    [Alias('Initialize-Variables')]
    param (
        [Parameter(Mandatory = $true)]
        [string]$DllPath
    )
    try {
        Job_DisableLog
        
        if ($Global:Cs.file_getfileversion($DllPath) -ge '0.2.0.0') {
            [string]$global:gsProgramFiles = $Global:Cs.gsProgramFiles
            [string]$global:gsProgramFilesx86 = $Global:Cs.gsProgramFilesx86
            [string]$global:gsWindir = $Global:Cs.gsWindowsDir
            [string]$global:gsWindowsDir = $Global:Cs.gsWindowsDir
            [string]$global:gsWorkstationPath = $Global:Cs.gsWorkstationPath
            [string]$global:gsSystemRoot = $Global:Cs.gsSystemRoot
            [string]$global:gsSystemDir = $Global:Cs.gsSystemDir
            [string]$global:gsSystemDirx86 = $Global:Cs.gsSystemDirx86
            [string]$global:gsLogDir = $Global:Cs.gsLogDir
            [string]$global:gsTempDir = $Global:Cs.gsTempDir
            [string]$global:gsOsSystem = $Global:Cs.gsOsSystem
            [string]$global:gsOsVersion = $Global:Cs.gsOsVersion
            [string]$global:gsLog = $Global:Cs.gsLog
            [string]$global:gsLogName = $Global:Cs.gsLogName
            [string]$global:gsTask = $Global:Cs.gsTask
            [bool]$global:gbDisablelog = $Global:Cs.gbDisablelog
            [bool]$global:gbSuficientDiskSpace = $Global:Cs.gbSuficientDiskSpace
            [string]$global:gsJobName = $Global:Cs.gsJobName
            [string]$global:gsLibrary = $Global:Cs.gsLibrary
            [bool]$global:gbx64 = $Global:Cs.gbx64
            [string]$global:gsCommonPrograms = $Global:Cs.gsCommonPrograms
            [string]$global:gsSysDrive = $Global:Cs.gsSysDrive
            [string]$global:gsCommonDesktop = $Global:Cs.gsCommonDesktop
            [string]$global:gsCommonStartMenu = $Global:Cs.gsCommonStartMenu
            [string]$global:gsCommonStartup = $Global:Cs.gsCommonStartup
            [string]$global:gsCommonFilesDir = $Global:Cs.gsCommonFilesDir
            [string]$global:gsCommonFiles = $Global:Cs.gsCommonFilesDir
            [string]$global:gsCommonFilesDirx86 = $Global:Cs.gsCommonFilesDirx86
            [string]$global:gsCommonFilesx86 = $Global:Cs.gsCommonFilesDirx86
            [string]$global:gsCommonAppData = $Global:Cs.gsCommonAppData
            [string]$global:gsProgramData = $Global:Cs.gsProgramData
            [string]$global:gsProductid = $Global:Cs.gsProductid
            [string]$global:gsAllusers = $Global:Cs.gsAllusers
            [string]$global:gsWorkstationName = $Global:Cs.gsWorkstationName
            [string]$global:gsOsBuild = $Global:Cs.gsOsBuild
            [string]$global:gsEditionId = $Global:Cs.gsEditionId
            [string]$global:gsDisplayVersion = $Global:Cs.gsDisplayVersion
            [string]$global:gsWindowsType = $Global:Cs.gsWindowsType
            [string]$global:gsOsArchitechture = $Global:Cs.gsOsArchitechture
            [string]$global:gsWindowsVersion = $Global:Cs.gsWindowsVersion
            [string]$global:gsUnitName = $Global:Cs.gsUnitName
            [string]$global:gsComputerManufacturer = $Global:Cs.gsComputerManufacturer
            [string]$global:gsComputerModel = $Global:Cs.gsComputerModel
            [string]$global:gsUUID = $Global:Cs.gsUUID
            $true
        } else {
            $false
        }

    } catch {
        Write-Error 'Error Line: ' $_.InvocationInfo.Line
        if ($Global:Cs) {
            Job_WriteLog -Text "Initialize-PpVariables: Error Line: $($_.InvocationInfo.Line)" 
        }

        Write-Error 'Error Item: '$_.Exception.ItemName       
        if ($Global:Cs) {
            Job_WriteLog -Text "Initialize-PpVariables: Error Item: $($_.Exception.ItemName)"
        }

        if ($Global:Cs) {
            Job_WriteLog -Text "Initialize-PpVariables: '$($_.Exception.HResult)'"
        }
        $_.Exception.HResult
    } finally {
        Job_EnableLog
    }
}