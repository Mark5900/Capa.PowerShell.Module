BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Sys_isUserLoggedOn' {
    BeforeEach {
        $global:cs = [pscustomobject]@{}
        $global:cs | Add-Member ScriptMethod Sys_isUserLoggedOn {
            $true
        }
    }

    It 'Returns the value from cs' {
        Sys_isUserLoggedOn | Should -Be $true
    }

    It 'Has CmdletBinding attribute' {
        $command = Get-Command -Name 'Sys_isUserLoggedOn' -CommandType Function -ErrorAction Stop

        ($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
    }
}
BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Sys_isUserLoggedOn' {
    It 'Has CmdletBinding attribute' {
        $command = Get-Command -Name 'Sys_isUserLoggedOn' -CommandType Function -ErrorAction Stop

        ($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
    }
}
