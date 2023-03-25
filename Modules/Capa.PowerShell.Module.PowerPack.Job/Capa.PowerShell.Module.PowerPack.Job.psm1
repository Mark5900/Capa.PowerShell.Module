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