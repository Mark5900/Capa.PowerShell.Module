BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Sys_ExistProcess' {
    BeforeEach {
        $script:capturedProcessName = $null
        $global:cs = [pscustomobject]@{}
        $global:cs | Add-Member ScriptMethod Sys_ExistProcess {
            param($ProcessName)
            $script:capturedProcessName = $ProcessName
            $true
        }
    }

    It 'Calls the cs method and returns the result' {
        $result = Sys_ExistProcess -ProcessName 'notepad.exe'

        $result | Should -Be $true
        $script:capturedProcessName | Should -Be 'notepad.exe'
    }

    It 'Has CmdletBinding attribute' {
        $command = Get-Command -Name 'Sys_ExistProcess' -CommandType Function -ErrorAction Stop

        ($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
    }
}
BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Sys_ExistProcess' {
    It 'Has CmdletBinding attribute' {
        $command = Get-Command -Name 'Sys_ExistProcess' -CommandType Function -ErrorAction Stop

        ($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
    }
}
