BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Sys_KillProcess' {
    It 'Has CmdletBinding attribute' {
        $command = Get-Command -Name 'Sys_KillProcess' -CommandType Function -ErrorAction Stop

        ($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
    }
}
