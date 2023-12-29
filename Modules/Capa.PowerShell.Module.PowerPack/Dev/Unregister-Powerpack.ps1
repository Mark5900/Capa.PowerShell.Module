# TODO: #59 Update and add tests

<#
    .SYNOPSIS
        Unregister a Powerpack

    .DESCRIPTION
        Unregister a Powerpack

    .PARAMETER Application
        The application

    .EXAMPLE
        Unregister-Powerpack -Application 'CapaOne.ScriptingLibrary'

    .NOTES
        Command from PSlib.psm1
#>
function Unregister-Powerpack {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [string]$Application
    )
    try {
        Job_DisableLog
        Reg_DelTree -RegRoot HKLM -RegPath "Software\Capasystems\Powerpacks\$Application"
    } catch {
        Write-Error 'Error Line: ' $_.InvocationInfo.Line
        if ($cs) {
            Job_WriteLog -Text "Unregister-Powerpack: Error Line: $($_.InvocationInfo.Line)"
        }

        Write-Error 'Error Item: '$_.Exception.ItemName
        if ($cs) {
            Job_WriteLog -Text "Unregister-Powerpack: Error Item: $($_.Exception.ItemName)"
        }

        if ($cs) {
            Job_WriteLog -Text "Unregister-Powerpack: '$($_.Exception.HResult)'"
        }
        $_.Exception.HResult
    } Finally {
        Job_EnableLog
    }
}