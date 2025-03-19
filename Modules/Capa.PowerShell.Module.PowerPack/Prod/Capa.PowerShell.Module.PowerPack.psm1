
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


class InputObject {
	[bool]$RebootRequested
	[int]$ExitCode
	[string]$ExceptionHResult
	[int]$DownloadProgress

	[string] ShowMessageBox($sCaption, $sText, $sButtons, $sDefault, $sIconStyle, $iTimeOut, $bAsync) {
		$Return = New-MessageBox -Message $sText -Title $sCaption -Buttons $sButtons -Icon $sIconStyle -Time $iTimeOut -AsString

		return $Return
	}

	DownloadPackage() {
		$SplitPath = $Global:Packageroot.Split('\')
		if ($SplitPath[-1] -eq 'kit') {
			$DestinationFolder = $Global:Packageroot
		} else {
			$DestinationFolder = Join-Path $Global:Packageroot 'kit'
		}

		$Splat = @{
			PackageName       = $Global:AppName
			PackageVersion    = $Global:AppRelease
			DestinationFolder = $DestinationFolder
		}
		Invoke-DownloadCapaPackage @Splat

		$Global:InputObject.DownloadProgress = 100
	}

	[string] SendData ($jParams) {
		$LocalPort = Get-ItemProperty -Path 'HKLM:\SOFTWARE\CapaSystems\BaseAgent' -Name 'LocalPort' | Select-Object -ExpandProperty LocalPort
		$BaseURL = "http://localhost:$LocalPort/data?language=powershell"

		$Response = Invoke-WebRequest -Uri $BaseURL -Method Post -Body $jParams -ContentType 'application/json'

		$JResponse = $Response.Content | ConvertFrom-Json
		if ($JResponse.result -eq $false -and $JResponse.xexception -ne 'None') {
			$JResponse | Add-Member -MemberType NoteProperty -Name 'Exception' -Value $JResponse.body.error
		}

		return $JResponse | ConvertTo-Json
	}
}

<#
	.SYNOPSIS
		Initialize the InputObject object.

	.DESCRIPTION
		Used in PowerPacks to initialize the InputObject object, if it is not already initialized.
		If you run a PowerPack script locally, then InputObject is null and you can use this function create a obejct to test your script.

		The only thing that does not work is CMS functions, because they need a real InputObject object.
		The message box is also not the real one, but a simple example.
#>
function Initialize-PpInputObject {
	if ($null -eq $Global:InputObject) {
		$Global:InputObject = [InputObject]::new()
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
    [Alias('Initialize-Variables')]
    param (
        [Parameter(Mandatory = $false)]
        [string]$DllPath = $Global:DllPath
    )
    try {
        Job_DisableLog

        if ($Global:Cs.file_getfileversion($DllPath) -ge '0.2.0.0') {
            [string]$global:gsProgramFiles = $Global:Cs.gsProgramFiles
            [string]$global:gsProgramFilesx86 = $Global:Cs.gsProgramFilesx86
            [string]$global:gsWindir = $Global:Cs.gsWindowsDir
            [string]$global:gsWindowsDir = $Global:Cs.gsWindowsDir
            [string]$global:gsWorkstationPath = $Global:Cs.gsWorkstationPath
            [string]$global:gsSystemRoot = $Global:Cs.gsSystemRoot
            [string]$global:gsSystemDir = $Global:Cs.gsSystemDir
            [string]$global:gsSystemDirx86 = $Global:Cs.gsSystemDirx86
            [string]$global:gsLogDir = $Global:Cs.gsLogDir
            [string]$global:gsTempDir = $Global:Cs.gsTempDir
            [string]$global:gsOsSystem = $Global:Cs.gsOsSystem
            [string]$global:gsOsVersion = $Global:Cs.gsOsVersion
            [string]$global:gsLog = $Global:Cs.gsLog
            [string]$global:gsLogName = $Global:Cs.gsLogName
            [string]$global:gsTask = $Global:Cs.gsTask
            [bool]$global:gbDisablelog = $Global:Cs.gbDisablelog
            [bool]$global:gbSuficientDiskSpace = $Global:Cs.gbSuficientDiskSpace
            [string]$global:gsJobName = $Global:Cs.gsJobName
            [string]$global:gsLibrary = $Global:Cs.gsLibrary
            [bool]$global:gbx64 = $Global:Cs.gbx64
            [string]$global:gsCommonPrograms = $Global:Cs.gsCommonPrograms
            [string]$global:gsSysDrive = $Global:Cs.gsSysDrive
            [string]$global:gsCommonDesktop = $Global:Cs.gsCommonDesktop
            [string]$global:gsCommonStartMenu = $Global:Cs.gsCommonStartMenu
            [string]$global:gsCommonStartup = $Global:Cs.gsCommonStartup
            [string]$global:gsCommonFilesDir = $Global:Cs.gsCommonFilesDir
            [string]$global:gsCommonFiles = $Global:Cs.gsCommonFilesDir
            [string]$global:gsCommonFilesDirx86 = $Global:Cs.gsCommonFilesDirx86
            [string]$global:gsCommonFilesx86 = $Global:Cs.gsCommonFilesDirx86
            [string]$global:gsCommonAppData = $Global:Cs.gsCommonAppData
            [string]$global:gsProgramData = $Global:Cs.gsProgramData
            [string]$global:gsProductid = $Global:Cs.gsProductid
            [string]$global:gsAllusers = $Global:Cs.gsAllusers
            [string]$global:gsWorkstationName = $Global:Cs.gsWorkstationName
            [string]$global:gsOsBuild = $Global:Cs.gsOsBuild
            [string]$global:gsEditionId = $Global:Cs.gsEditionId
            [string]$global:gsDisplayVersion = $Global:Cs.gsDisplayVersion
            [string]$global:gsWindowsType = $Global:Cs.gsWindowsType
            [string]$global:gsOsArchitechture = $Global:Cs.gsOsArchitechture
            [string]$global:gsWindowsVersion = $Global:Cs.gsWindowsVersion
            [string]$global:gsUnitName = $Global:Cs.gsUnitName
            [string]$global:gsComputerManufacturer = $Global:Cs.gsComputerManufacturer
            [string]$global:gsComputerModel = $Global:Cs.gsComputerModel
						[string]$global:gsComputerName = $Global:Cs.gsComputerName
            [string]$global:gsUUID = $Global:Cs.gsUUID
            $true
        } else {
            $false
        }

    } catch {
        Write-Error 'Error Line: ' $_.InvocationInfo.Line
        if ($Global:Cs) {
            Job_WriteLog -Text "Initialize-PpVariables: Error Line: $($_.InvocationInfo.Line)"
        }

        Write-Error 'Error Item: '$_.Exception.ItemName
        if ($Global:Cs) {
            Job_WriteLog -Text "Initialize-PpVariables: Error Item: $($_.Exception.ItemName)"
        }

        if ($Global:Cs) {
            Job_WriteLog -Text "Initialize-PpVariables: '$($_.Exception.HResult)'"
        }
        $_.Exception.HResult
    } finally {
        Job_EnableLog
    }
}


# TODO: #56 Update and add tests

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


# TODO: #57 Update and add tests

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


# TODO: #58 Update and add tests

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
                Exit-PpScript 3322
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
        Exit-PpScript 3322
    }
}


# TODO: #59 Update and add tests

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


