BeforeAll {
    $FunctionPath = $PSCommandPath -replace '\.Tests\.ps1$', '.ps1'
    . $FunctionPath
    $ValidPlain = 'Admin1234'
    $ValidSecure = ConvertTo-SecureString $ValidPlain -AsPlainText -Force
    $ExpectedEncrypted = 'mOQXCLuC/rSkIrAQU3Ttbg=='
}

Describe 'Get-CCSEncryptedPassword - Advanced Function' {
    Context 'Parameter Validation' {
        It 'Throws if SecureString is missing' {
            { Get-CCSEncryptedPassword } | Should -Throw
        }
        It 'Throws if SecureString is empty or whitespace' {
            # PowerShell throws if you try to create a SecureString from an empty string, so test whitespace instead
            $white = ConvertTo-SecureString '   ' -AsPlainText -Force
            { Get-CCSEncryptedPassword -SecureString $white } | Should -Throw
        }
    }
    Context 'Pipeline Support' {
        It 'Accepts input from pipeline' {
            $result = $ValidSecure | Get-CCSEncryptedPassword
            $result | Should -Be $ExpectedEncrypted
        }
    }
    Context 'Encryption Logic' {
        It 'Returns expected encrypted string for known input' {
            $result = Get-CCSEncryptedPassword -SecureString $ValidSecure
            $result | Should -Be $ExpectedEncrypted
        }
    }
    Context 'Error Handling' {
        It 'Throws if InstallationScreen.exe is missing' {
            $oldPath = $env:TEMP
            $script:origExe = (Join-Path (Split-Path $FunctionPath -Parent) 'Dependencies' 'InstallationScreen.exe')
            if (Test-Path $script:origExe) {
                Rename-Item $script:origExe ($script:origExe + '.bak')
            }
            try {
                { Get-CCSEncryptedPassword -SecureString $ValidSecure } | Should -Throw
            } finally {
                if (Test-Path ($script:origExe + '.bak')) {
                    Rename-Item ($script:origExe + '.bak') $script:origExe
                }
            }
        }
    }
    Context 'Output Type' {
        It 'Returns a string' {
            $result = Get-CCSEncryptedPassword -SecureString $ValidSecure
            $result | Should -BeOfType 'System.String'
        }
    }
}
