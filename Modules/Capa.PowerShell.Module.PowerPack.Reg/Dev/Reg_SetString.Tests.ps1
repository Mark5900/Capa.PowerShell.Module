BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Reg_SetString' {
    It 'Has CmdletBinding attribute' {
        $command = Get-Command -Name 'Reg_SetString' -CommandType Function -ErrorAction Stop

        ($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
    }
}
