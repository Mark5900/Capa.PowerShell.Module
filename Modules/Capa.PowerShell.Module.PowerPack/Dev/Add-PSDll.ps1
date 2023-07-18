<#
    .SYNOPSIS
        Adds the CapaOne.ScriptingLibrary.dll to the current session.

    .DESCRIPTION
        Adds the CapaOne.ScriptingLibrary.dll to the current session.

    .PARAMETER DllPath
        The path to the CapaOne.ScriptingLibrary.dll.

    .EXAMPLE
        Add-PSDll -DllPath $DllPath

    .NOTES
        Command from PSlib.psm1
#>
function Add-PSDll {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [string]$DllPath
    )
    try {
        Add-Type -Path $DllPath
        $Cs = New-Object -TypeName 'CapaOne.ScriptingLibrary'
        return $Cs
    } catch {
        $ErrorMessage = '[Line ' + $_.InvocationInfo.ScriptLineNumber + '] ' + $_.Exception.Message
        #$ErrorNumber = $_.Exception.HResult
        Write-Error "Failed to load ScriptingLibrary: $ErrorMessage"
        Exit-PpScript $_
    }

}