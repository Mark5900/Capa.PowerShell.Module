<#
    .SYNOPSIS
        Adds the CapaOne.ScriptingLibrary.dll to the current session.

    .DESCRIPTION
        Adds the CapaOne.ScriptingLibrary.dll to the current session.

    .PARAMETER DllPath
        The path to the CapaOne.ScriptingLibrary.dll.

    .EXAMPLE
        Add-PpDll -DllPath $DllPath

    .NOTES
        Command from PSlib.psm1
#>
function Add-PpDll {
    [CmdletBinding()]
    [Alias('Add-PsDll')]
    Param(
        [Parameter(Mandatory = $false)]
        [string]$DllPath
    )
    try {
		if ([string]::IsNullOrEmpty($DllPath)) {
			$CiBaseAgentPath = 'C:\Program Files (x86)\CapaInstaller\Services\CiBaseAgent'
			$Folders = Get-ChildItem -Path $CiBaseAgentPath -Directory

			# Find newest version folder
			$NewestVersion = $Folders | Sort-Object -Property Name -Descending | Select-Object -First 1

			# Get path to DLL
			$DllPath = Join-Path $CiBaseAgentPath $NewestVersion.Name 'CapaOne.ScriptingLibrary.dll'
			$Global:DllPath = $DllPath
		}

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