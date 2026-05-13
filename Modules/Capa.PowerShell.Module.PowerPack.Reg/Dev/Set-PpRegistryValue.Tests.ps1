BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Set-PpRegistryValue' {
    BeforeEach {
        $script:captured = $null
        $global:cs = [pscustomobject]@{}
        $global:cs | Add-Member ScriptMethod Job_WriteLog {
            param($Text)
        }
        $global:cs | Add-Member ScriptMethod Reg_SetString {
            param($RegRoot, $RegKey, $RegValue, $RegData)
            $script:captured = [pscustomobject]@{
                RegRoot = $RegRoot
                RegKey = $RegKey
                RegValue = $RegValue
                RegData = $RegData
            }
        }
        $global:cs | Add-Member ScriptMethod Reg_SetDword {
            param($RegRoot, $RegKey, $RegValue, $RegData)
        }
        $global:cs | Add-Member ScriptMethod Reg_SetExpandString {
            param($RegRoot, $RegKey, $RegValue, $RegData)
        }
    }

    It 'Uses RegRoot directly for non-HKCU roots' {
        Set-PpRegistryValue -RegRoot HKLM -Datatype 'String' -RegKey 'SOFTWARE\\CapaSystems' -RegValue 'Test' -RegData 'Value1'

        $script:captured.RegRoot | Should -Be 'HKLM'
        $script:captured.RegKey | Should -Be 'SOFTWARE\\CapaSystems'
        $script:captured.RegValue | Should -Be 'Test'
        $script:captured.RegData | Should -Be 'Value1'
    }

    It 'Has CmdletBinding attribute' {
        $command = Get-Command -Name 'Set-PpRegistryValue' -CommandType Function -ErrorAction Stop

        ($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
    }
}
