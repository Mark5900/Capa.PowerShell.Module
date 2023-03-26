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
        [string]$FunctionName = '',
        [Parameter(Mandatory = $true)]
        [string]$Text
    )

    if ($FunctionName -ne '') {
        $Global:Cs.Job_WriteLog($FunctionName, $Text)
    } else {
        $Global:Cs.Job_WriteLog($Text)
    }
}