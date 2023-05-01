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