
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
        Exit-PSScript $_
    }

}


<#
    .SYNOPSIS
        Initialize global variables

    .DESCRIPTION
        Initialize global variables

    .PARAMETER DllPath
        The path to the CapaOne.ScriptingLibrary.dll.

    .EXAMPLE
        Initialize-PpVariables -DllPath 'C:\Program Files (x86)\CapaOne\Scripting Library\CapaOne.ScriptingLibrary.dll'

    .NOTES
        Command from PSlib.psm1
#>
function Initialize-PpVariables {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$DllPath
    )
    try {
        Job_DisableLog
        
        if ($Cs.file_getfileversion($DllPath) -ge '0.2.0.0') {
            [string]$global:gsProgramFiles = $Cs.gsProgramFiles
            [string]$global:gsProgramFilesx86 = $Cs.gsProgramFilesx86
            [string]$global:gsWindir = $Cs.gsWindowsDir
            [string]$global:gsWindowsDir = $Cs.gsWindowsDir
            [string]$global:gsWorkstationPath = $Cs.gsWorkstationPath
            [string]$global:gsSystemRoot = $Cs.gsSystemRoot
            [string]$global:gsSystemDir = $Cs.gsSystemDir
            [string]$global:gsSystemDirx86 = $Cs.gsSystemDirx86
            [string]$global:gsLogDir = $Cs.gsLogDir
            [string]$global:gsTempDir = $Cs.gsTempDir
            [string]$global:gsOsSystem = $Cs.gsOsSystem
            [string]$global:gsOsVersion = $Cs.gsOsVersion
            [string]$global:gsLog = $Cs.gsLog
            [string]$global:gsLogName = $Cs.gsLogName
            [string]$global:gsTask = $Cs.gsTask
            [bool]$global:gbDisablelog = $Cs.gbDisablelog
            [bool]$global:gbSuficientDiskSpace = $Cs.gbSuficientDiskSpace
            [string]$global:gsJobName = $Cs.gsJobName
            [string]$global:gsLibrary = $Cs.gsLibrary
            [bool]$global:gbx64 = $Cs.gbx64
            [string]$global:gsCommonPrograms = $Cs.gsCommonPrograms
            [string]$global:gsSysDrive = $Cs.gsSysDrive
            [string]$global:gsCommonDesktop = $Cs.gsCommonDesktop
            [string]$global:gsCommonStartMenu = $Cs.gsCommonStartMenu
            [string]$global:gsCommonStartup = $Cs.gsCommonStartup
            [string]$global:gsCommonFilesDir = $Cs.gsCommonFilesDir
            [string]$global:gsCommonFiles = $Cs.gsCommonFilesDir
            [string]$global:gsCommonFilesDirx86 = $Cs.gsCommonFilesDirx86
            [string]$global:gsCommonFilesx86 = $Cs.gsCommonFilesDirx86
            [string]$global:gsCommonAppData = $Cs.gsCommonAppData
            [string]$global:gsProgramData = $Cs.gsProgramData
            [string]$global:gsProductid = $Cs.gsProductid
            [string]$global:gsAllusers = $Cs.gsAllusers
            [string]$global:gsWorkstationName = $Cs.gsWorkstationName
            [string]$global:gsOsBuild = $Cs.gsOsBuild
            [string]$global:gsEditionId = $Cs.gsEditionId
            [string]$global:gsDisplayVersion = $Cs.gsDisplayVersion
            [string]$global:gsWindowsType = $Cs.gsWindowsType
            [string]$global:gsOsArchitechture = $Cs.gsOsArchitechture
            [string]$global:gsWindowsVersion = $Cs.gsWindowsVersion
            [string]$global:gsUnitName = $Cs.gsUnitName
            [string]$global:gsComputerManufacturer = $Cs.gsComputerManufacturer
            [string]$global:gsComputerModel = $Cs.gsComputerModel
            [string]$global:gsUUID = $Cs.gsUUID
            $true
        } else {
            $false
        }

    } catch {
        Write-Error 'Error Line: ' $_.InvocationInfo.Line
        if ($Cs) {
            Job_WriteLog -Text "Initialize-PpVariables: Error Line: $($_.InvocationInfo.Line)" 
        }

        Write-Error 'Error Item: '$_.Exception.ItemName       
        if ($Cs) {
            Job_WriteLog -Text "Initialize-PpVariables: Error Item: $($_.Exception.ItemName)"
        }

        if ($Cs) {
            Job_WriteLog -Text "Initialize-PpVariables: '$($_.Exception.HResult)'"
        }
        $_.Exception.HResult
    } finally {
        Job_EnableLog
    }
}


<#
    .SYNOPSIS
        Runs a command as the logged on user.

    .DESCRIPTION
        Runs a command as the logged on user, by creating a scheduled task and starting it.

    .PARAMETER Command
        The command to run.

    .PARAMETER UserName
        The user name to run the command as.

    .PARAMETER Arguments
        The arguments to pass to the command.

    .EXAMPLE
        Invoke-RunAsLoggedOnUser -Command 'C:\Temp\MyApp.exe' -Arguments '/silent' -UserName 'MyDomain\MyUser'

    .NOTES
        Command from PSlib.psm1
#>
function Invoke-RunAsLoggedOnUser {
    [CmdletBinding()]
    [OutputType([int32])]
    Param(
        [Parameter(Mandatory = $true)]
        [string]$Command,
        [Parameter(Mandatory = $false)]
        [string]$UserName,
        [Parameter(Mandatory = $false)]
        [string]$Arguments
    )

    try {
        if ($Cs) { 
            Job_WriteLog -Text "Call Invoke-RunAsLoggedOnUser with Command: '$Command', Arguments: '$Arguments'"
        }

        Get-ScheduledTask | Where-Object { $_.Taskname -ilike 'PowerPackUserJob' } | Unregister-ScheduledTask -Confirm:$false
        $Action = New-ScheduledTaskAction -Execute $Command -Argument $Arguments
        $Trigger = New-ScheduledTaskTrigger -AtLogOn
        $Settings = New-ScheduledTaskSettingsSet -Hidden -Compatibility 'Win8' -ExecutionTimeLimit (New-TimeSpan -Minutes 30)

        if (!$UserName) { 
            $UserId = (Get-Process -Name explorer -IncludeUserName -ErrorAction SilentlyContinue).username 
        } else { 
            $UserId = $UserName 
        }

        if (!$UserId) {
            if ($Cs) {
                Job_WriteLog -Text 'Invoke-RunAsLoggedOnUser: No user found - User must be logged on physically.'
            }
            return 0
        }

        foreach ($User in $UserId) {
            if ($Cs) { 
                Job_WriteLog -Text "Invoke-RunAsLoggedOnUser: User detected using process owner: '$($User)'"
            }

            Register-ScheduledTask 'PowerPackUserJob' -Trigger $Trigger -Action $Action -User $User -Settings $Settings -RunLevel Highest | Out-Null
            $SchedTask = Get-ScheduledTask -TaskName 'PowerPackUserJob'
            
            if ($SchedTask) {
                Start-ScheduledTask -TaskName 'PowerPackUserJob'

                if ($Cs) { 
                    Job_WriteLog -Text "Invoke-RunAsLoggedOnUser: Scheduled Task 'PowerPackUserJob' has been started." 
                }

                $Count = 0
                $TaskState = (Get-ScheduledTask -TaskName 'PowerPackUserJob' -ErrorAction SilentlyContinue).State

                if ($Cs) {
                    Job_WriteLog -Text "Invoke-RunAsLoggedOnUser: Scheduled Task 'PowerPackUserJob' state: $TaskState"
                }

                if ($TaskState -eq 'Running') {
                    while ($TaskState -eq 'Running') {
                        Start-Sleep -Seconds 1
                        $Count++
                        $TaskState = (Get-ScheduledTask -TaskName 'PowerPackUserJob' -ErrorAction SilentlyContinue).State

                        if ($Cs -and $Count % 10 -eq 0) {
                            Job_WriteLog -Text "Invoke-RunAsLoggedOnUser: Scheduled Task 'PowerPackUserJob' current state: $TaskState"
                        }

                        if ($Count -ge 1800) { 
                            break 
                        }
                    }

                    $TaskState = (Get-ScheduledTask -TaskName 'PowerPackUserJob').State
                    if ($Cs) {
                        Job_WriteLog -Text "Invoke-RunAsLoggedOnUser: Scheduled Task 'PowerPackUserJob' ended with state: $TaskState"
                    }
                }
            }

            Get-ScheduledTask | Where-Object { $_.taskname -ilike 'PowerPackUserJob' } | Unregister-ScheduledTask -Confirm:$false
            if ($Cs) {
                Job_WriteLog -Text 'Invoke-RunAsLoggedOnUser: Completed with success.'
            }      
        }

        return 0
    } catch {
        Write-Error 'Error Line: ' $_.InvocationInfo.Line
        if ($Cs) {
            Job_WriteLog -Text "Invoke-RunAsLoggedOnUser: Error Line: $_.InvocationInfo.Line" 
        }

        Write-Error 'Error Item: '$_.Exception.ItemName       
        if ($Cs) {
            Job_WriteLog -Text "Invoke-RunAsLoggedOnUser: Error Item: $_.Exception.ItemName"
        }

        Unregister-ScheduledTask -TaskName 'PowerPackUserJob' -Confirm:$false -ErrorAction SilentlyContinue
        if ($Cs) {
            Job_WriteLog -Text "Invoke-RunAsLoggedOnUser: '$_.Exception.HResult'" 
        }

        $_.Exception.HResult
    }
    return 0
}


<#
    .SYNOPSIS
        Register a Powerpack in the registry

    .DESCRIPTION
        Register a Powerpack in the registry

    .PARAMETER Application
        The application

    .PARAMETER AppName
        The application name

    .PARAMETER Arch
        The architecture

    .PARAMETER Language
        The language

    .PARAMETER AppCode
        The application code

    .PARAMETER Version
        The version

    .Parameter Vendor
        The vendor

    .EXAMPLE
        Register-Powerpack -Application 'CapaOne.ScriptingLibrary' -AppName 'CapaOne Scripting Library' -Arch 'x64' -Language 'en-us' -AppCode 'COSL' -Version '1.0' -Vendor 'CapaSystems'

    .NOTES
        Command from PSlib.psm1
#>
function Register-Powerpack {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [string]$Application,
        [Parameter(Mandatory = $true)]
        [string]$AppName,
        [Parameter(Mandatory = $true)]
        [string]$Arch,
        [Parameter(Mandatory = $false)]
        [string]$Language = 'en-us',
        [Parameter(Mandatory = $false)]
        [string]$AppCode,
        [Parameter(Mandatory = $true)]
        [string]$Version,
        [Parameter(Mandatory = $false)]
        [string]$Vendor
    )
    try {
        Job_DisableLog
        Reg_SetString -RegRoot HKLM -RegKey "Software\Capasystems\Powerpacks\$Application" -RegValue 'Name' -RegData $AppName
        Reg_SetString -RegRoot HKLM -RegKey "Software\Capasystems\Powerpacks\$Application" -RegValue 'Platform' -RegData $Arch
        Reg_SetString -RegRoot HKLM -RegKey "Software\Capasystems\Powerpacks\$Application" -RegValue 'Language' -RegData $Language
        Reg_SetString -RegRoot HKLM -RegKey "Software\Capasystems\Powerpacks\$Application" -RegValue 'Version' -RegData $Version
        Reg_SetString -RegRoot HKLM -RegKey "Software\Capasystems\Powerpacks\$Application" -RegValue 'InstallDate' -RegData $(Get-Date -UFormat '%F %T')
        Reg_SetString -RegRoot HKLM -RegKey "Software\Capasystems\Powerpacks\$Application" -RegValue 'Publisher' -RegData $Vendor
        if ($AppCode) { 
            Reg_SetString -RegRoot HKLM -RegKey "Software\Capasystems\Powerpacks\$Application" -RegValue 'AppCode' -RegData $AppCode 
        }
    } catch {
        Write-Error 'Error Line: ' $_.InvocationInfo.Line
        if ($cs) {
            Job_WriteLog "Register-Powerpack: Error Line: $($_.InvocationInfo.Line)"
        }

        Write-Error 'Error Item: '$_.Exception.ItemName       
        if ($cs) {
            Job_WriteLog -Text "Register-Powerpack: Error Item: $_.Exception.ItemName" 
        }

        if ($cs) {
            Job_WriteLog -Text "Register-Powerpack: '$_.Exception.HResult'" 
        }
        $_.Exception.HResult
    } Finally {
        Job_EnableLog
    }
}


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


