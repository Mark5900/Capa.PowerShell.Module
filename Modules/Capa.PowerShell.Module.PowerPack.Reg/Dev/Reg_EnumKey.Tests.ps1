BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Reg_EnumKey' {
    It 'Has CmdletBinding attribute' {
        $command = Get-Command -Name 'Reg_EnumKey' -CommandType Function -ErrorAction Stop

        ($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
    }
}
