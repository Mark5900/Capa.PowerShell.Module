<#
    .SYNOPSIS
        Exit the script with a given exit code and message.

    .DESCRIPTION
        Exit the script with a given exit code and message.

    .PARAMETER ExitCode
        The exit code to exit the script with.

    .PARAMETER ExitMessage
        The message to write to the log before exiting the script.

    .EXAMPLE
        Exit-PSScript -ExitCode 0 -ExitMessage "Script ended successfully"

    .EXAMPLE
        Exit-PSScript -ExitCode 3305

    .NOTES
        Command from PSlib.psm1
#>
function Exit-PSScript() {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        $ExitCode,
        [Parameter(Mandatory = $false)]
        [string]$ExitMessage
    )
    $cs.AutoSectionHeader = $false
    if ($ExitMessage) { 
        Job_WriteLog -Text $ExitMessage
    }
    
    $IgnoreAndContinueErrors = @(3010)

    if ($ExitCode.count -eq 0) { 
        $ExitNumber = 0
        [string]$ErrorMessage = "SCRIPT ENDED WITH EXITCODE: $($ExitNumber)" 
    } elseif ($ExitCode -is [System.Collections.ArrayList]) {
        $ExitNumber = $ExitCode[0].Exception.HResult
        if (!$IgnoreAndContinueErrors.Contains($ExitNumber)) { 
            Job_WriteLog -Text "$($ExitCode[0].Exception.Message)"
        }
        $ErrorMessage = "SCRIPT ENDED WITH EXITCODE: $($ExitNumber) - in line: $($ExitCode[0].InvocationInfo.ScriptLineNumber)"
    } else {
        # Must be integer - handle as such
        if ([string]::IsNullOrWhiteSpace($ExitCode)) { 
            $ExitCode = 0 
        }
        if ($IgnoreAndContinueErrors.Contains($ExitCode)) {
            $Ex = New-Object System.ApplicationException
            $Ex.hresult = $ExitCode
            Write-Error -Exception $Ex -ErrorAction SilentlyContinue
            return
        } else {
            $ExitNumber = $ExitCode
            [string]$ErrorMessage = "SCRIPT ENDED WITH EXITCODE: $($ExitNumber)"
        }
    }
    
    Job_WriteLog -Text $ErrorMessage
    if ($InputObject) {
        $InputObject.ExitCode = $ExitNumber 
    }
    exit $ExitNumber
}