<#
    .SYNOPSIS
        Downloads a package.

    .DESCRIPTION
        Downloads a package.

    .NOTES
        Command from PSlib.psm1
#>
function Start-PSDownloadPackage {
    try {
        $Return = $InputObject.DownloadPackage()
        Job_WriteLog -Text "Downloading package: $AppName"
        Write-Host "Downloading package: $AppName"
        
        Do {
            Start-Sleep -Seconds 1
            $Progress = $InputObject.DownloadProgress

            if ($Progress -eq -1) {
                $Message = '[Line ' + $_.InvocationInfo.ScriptLineNumber + '] ' + $_.Exception.Message
                $HResult = $InputObject.ExceptionHResult
                Write-Error "Download failed: $HResult $Message"
                Job_WriteLog -Text "Download failed: $HResult $Message"
                Exit-PSScript 3322
            }

            Write-Host "Progress: $Progress"
            Job_WriteLog -Text "Progress: $Progress"

        } While ($Progress -ne 100)

        Write-Host 'Download completed'
        Job_WriteLog -Text 'Download completed'

    } catch {
        $ErrorMessage = '[Line ' + $_.InvocationInfo.ScriptLineNumber + '] ' + $_.Exception.Message
        Write-Error "Download failed: $ErrorMessage" 
        Write-Error 'Error Line: ' $_.InvocationInfo.Line
        Write-Error 'Error Item: '$_.Exception.ItemName       
        Exit-PSScript 3322
    }
}