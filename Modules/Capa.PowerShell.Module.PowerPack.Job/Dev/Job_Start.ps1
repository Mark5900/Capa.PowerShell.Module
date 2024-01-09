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

