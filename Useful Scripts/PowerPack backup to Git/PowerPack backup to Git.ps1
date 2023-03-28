Import-Module SqlServer
<#
    .NOTES
    ===========================================================================
    Created with:	Visual Studio Code
    Created on:		28-03-2023
    Created by:		MARA
    Organization:	IT-Center Fyn
    Filename:		PowerPack backup to Git.ps1
    ===========================================================================
    .DESCRIPTION
        TODO: A description of the file.
#>
##################
### PARAMETERS ###
##################
# DO NOT CHANGE
# Change as needed
$DevCMPID = '2'
$SqlServer = 'CISRVKURSUS'
$Database = 'CapaInstaller'
$SQLCredential = $null # If null, Windows Authentication is used

$LocalFolder = 'D:\PowerPack Scripts'

#################
### FUNCTIONS ###
#################
function Get-Scripts {
    param (
        [Parameter(Mandatory = $true)]
        [string]$DevCMPID,
        [Parameter(Mandatory = $true)]
        [string]$SqlServer,
        [Parameter(Mandatory = $true)]
        [string]$Database,
        [System.Management.Automation.PSCredential]$SQLCredential = $Null
    )
    $Query = "SELECT NAME, VERSION, INSTALLSCRIPTCONTENT, UNINSTALLSCRIPTCONTENT
    FROM [CapaInstaller].[dbo].[JOB]
    Where POWERPACK = 1
    And CMPID = $DevCMPID"

    if ($null -eq $SQLCredential) {
        $Scripts = Invoke-Sqlcmd -ServerInstance $SqlServer -Database $Database -Query $Query
    } else {
        $Scripts = Invoke-Sqlcmd -ServerInstance $SqlServer -Database $Database -Query $Query -Credential $SQLCredential
    }
        
    return $Scripts
}

function Save-Scripts {
    param (
        [Parameter(Mandatory = $true)]
        $Scripts,
        [Parameter(Mandatory = $true)]
        [string]$LocalFolder
    )
    
    foreach ($Script in $Scripts) {
        $ScriptName = $Script.NAME
        $ScriptVersion = $Script.VERSION
        $ScriptInstall = $Script.INSTALLSCRIPTCONTENT
        $ScriptUninstall = $Script.UNINSTALLSCRIPTCONTENT

        $ScriptPath = "$LocalFolder\$ScriptName\$ScriptVersion"

        if (-not (Test-Path $ScriptPath)) {
            New-Item -ItemType Directory -Path $ScriptPath
        }

        $ScriptInstallPath = "$ScriptPath\$($ScriptName)_Install.ps1"
        $ScriptUninstallPath = "$ScriptPath\$($ScriptName)_Uninstall.ps1"

        [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($ScriptInstall)) | Out-File -FilePath $ScriptInstallPath
        [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($ScriptUninstall)) | Out-File -FilePath $ScriptUninstallPath
    }
}
##############
### SCRIPT ###
##############
try {
    $Scripts = Get-Scripts -DevCMPID $DevCMPID -SqlServer $SqlServer -Database $Database -SQLCredential $SQLCredential
    Save-Scripts -Scripts $Scripts -LocalFolder $LocalFolder
} catch {
    #TODO: Send a mail
}