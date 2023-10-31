# TODO: Update and add tests

<#
    .SYNOPSIS
        Register a Powerpack in the registry

    .DESCRIPTION
        Register a Powerpack in the registry

    .PARAMETER Application
        The application

    .PARAMETER AppName
        The application name

    .PARAMETER Arch
        The architecture

    .PARAMETER Language
        The language

    .PARAMETER AppCode
        The application code

    .PARAMETER Version
        The version

    .Parameter Vendor
        The vendor

    .EXAMPLE
        Register-Powerpack -Application 'CapaOne.ScriptingLibrary' -AppName 'CapaOne Scripting Library' -Arch 'x64' -Language 'en-us' -AppCode 'COSL' -Version '1.0' -Vendor 'CapaSystems'

    .NOTES
        Command from PSlib.psm1
#>
function Register-Powerpack {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [string]$Application,
        [Parameter(Mandatory = $true)]
        [string]$AppName,
        [Parameter(Mandatory = $true)]
        [string]$Arch,
        [Parameter(Mandatory = $false)]
        [string]$Language = 'en-us',
        [Parameter(Mandatory = $false)]
        [string]$AppCode,
        [Parameter(Mandatory = $true)]
        [string]$Version,
        [Parameter(Mandatory = $false)]
        [string]$Vendor
    )
    try {
        Job_DisableLog
        Reg_SetString -RegRoot HKLM -RegKey "Software\Capasystems\Powerpacks\$Application" -RegValue 'Name' -RegData $AppName
        Reg_SetString -RegRoot HKLM -RegKey "Software\Capasystems\Powerpacks\$Application" -RegValue 'Platform' -RegData $Arch
        Reg_SetString -RegRoot HKLM -RegKey "Software\Capasystems\Powerpacks\$Application" -RegValue 'Language' -RegData $Language
        Reg_SetString -RegRoot HKLM -RegKey "Software\Capasystems\Powerpacks\$Application" -RegValue 'Version' -RegData $Version
        Reg_SetString -RegRoot HKLM -RegKey "Software\Capasystems\Powerpacks\$Application" -RegValue 'InstallDate' -RegData $(Get-Date -UFormat '%F %T')
        Reg_SetString -RegRoot HKLM -RegKey "Software\Capasystems\Powerpacks\$Application" -RegValue 'Publisher' -RegData $Vendor
        if ($AppCode) {
            Reg_SetString -RegRoot HKLM -RegKey "Software\Capasystems\Powerpacks\$Application" -RegValue 'AppCode' -RegData $AppCode
        }
    } catch {
        Write-Error 'Error Line: ' $_.InvocationInfo.Line
        if ($cs) {
            Job_WriteLog "Register-Powerpack: Error Line: $($_.InvocationInfo.Line)"
        }

        Write-Error 'Error Item: '$_.Exception.ItemName
        if ($cs) {
            Job_WriteLog -Text "Register-Powerpack: Error Item: $_.Exception.ItemName"
        }

        if ($cs) {
            Job_WriteLog -Text "Register-Powerpack: '$_.Exception.HResult'"
        }
        $_.Exception.HResult
    } Finally {
        Job_EnableLog
    }
}