
# TODO: #77 Update and add tests

<#
    .SYNOPSIS
        Disable logging

    .DESCRIPTION
        Disable logging

    .EXAMPLE
        Job_DisableLog

    .NOTES
        Custom command
#>
function Job_DisableLog {
    $global:cs.Job_DisableLog()
}


# TODO: #78 Update and add tests

<#
    .SYNOPSIS
        Enable logging

    .DESCRIPTION
        Enable logging

    .EXAMPLE
        Job_EnableLog

    .NOTES
        Custom command
#>
function Job_EnableLog {
    $global:cs.Job_EnableLog()
}


# TODO: #79 Update and add tests

<#
    .SYNOPSIS
        Job request reboot of the workstation

    .DESCRIPTION
        Job request reboot of the workstation

    .PARAMETER Text
        The text to write to the log

    .EXAMPLE
        Job_RebootWS -Text 'Reboot requested'

    .NOTES
        Command from PSlib.psm1
#>
function Job_RebootWS {
    [CmdletBinding()]
    [Alias('Invoke-Job_RebootWS')]
    Param(
        [Parameter(Mandatory = $false)]
        [string]$Text
    )
    try {
        Write-Host $Text
        if ($global:cs) {
            Job_WriteLog -Text "Call Invoke-Job_RebootWS with text: '$Text'"
        }
        if ($Global:InputObject) { $Global:InputObject.RebootRequested = $true }
    } catch {
        Write-Error 'Error Line: ' $_.InvocationInfo.Line
        if ($global:cs) {
            Job_WriteLog -Text "Invoke-Job_RebootWS: Error Line: $($_.InvocationInfo.Line)"
        }

        Write-Error 'Error Item: '$_.Exception.ItemName
        if ($global:cs) {
            Job_WriteLog -Text "Invoke-Job_RebootWS: Error Item: $($_.Exception.ItemName)"
        }

        if ($global:cs) {
            Job_WriteLog -Text "Invoke-Job_RebootWS: '$($_.Exception.HResult)'"
        }
        $_.Exception.HResult
    }
}


# TODO: #80 Update and add tests

<#
    .SYNOPSIS
        This function will initialize the Powershell Scripting Library and set logpath and other variables.

    .PARAMETER JobType
        The type of the job.

    .PARAMETER PackageName
        The name of the package.

    .PARAMETER PackageVersion
        The version of the package.

    .PARAMETER LogPath
        The path to the log file.

    .PARAMETER Action
        The action to perform.

    .EXAMPLE
        PS C:\> Job_Start -JobType "WS" -PackageName $Appname -PackageVersion $AppRelease -LogPath $LogFile -Action "Install"

    .NOTES
        For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455360/cs.Job+Start
#>
function Job_Start {
    param (
        [Parameter(Mandatory = $true)]
        [string]$JobType,
        [Parameter(Mandatory = $true)]
        [string]$PackageName,
        [Parameter(Mandatory = $true)]
        [string]$PackageVersion,
        [Parameter(Mandatory = $true)]
        [string]$LogPath,
        [Parameter(Mandatory = $true)]
        [string]$Action
    )

    $Global:Cs.Job_Start($JobType, $PackageName, $PackageVersion, $LogPath, $Action)
}



# TODO: #81 Update and add tests

<#
    .SYNOPSIS
        This function will write a log entry.

    .PARAMETER FunctionName
        Name of function to associate with log entry (default blank, Log_Sectionheader will override).

    .PARAMETER Text
        The text to write to the log.

    .EXAMPLE
        PS C:\> Job_WriteLog -FunctionName "Install" -Text "Installing application"

    .EXAMPLE
        PS C:\> Log_SectionHeader -Name "Install"
        PS C:\> Job_WriteLog -Text "Installing application"

    .NOTES
        For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455683/cs.Job+WriteLog
#>
function Job_WriteLog {
	param (
		[Parameter(Mandatory = $true)]
		[string]$Text,
		[Parameter(Mandatory = $false)]
		[string]$FunctionName = ''
	)

	if ($FunctionName -ne '') {
		$Global:Cs.Job_WriteLog($FunctionName, $Text)
	} else {
		$Global:Cs.Job_WriteLog($Text)
	}
}


