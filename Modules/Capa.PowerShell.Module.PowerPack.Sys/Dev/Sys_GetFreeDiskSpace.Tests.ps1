BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Sys_GetFreeDiskSpace' {
    It 'Has CmdletBinding attribute' {
        $command = Get-Command -Name 'Sys_GetFreeDiskSpace' -CommandType Function -ErrorAction Stop

        ($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
    }
}
