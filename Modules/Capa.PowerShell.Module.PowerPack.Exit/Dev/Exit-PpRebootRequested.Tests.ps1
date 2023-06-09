BeforeAll {
    # Import file 
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
    $RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
}
Describe 'Exit-PpRebootRequested' {
    It 'Should set the error code to 3010' {
        pwsh.exe -File "$PSScriptRoot\Tests_Helper_Scripts\Exit-PpRebootRequested.Tests.Script.ps1" $RootPath 1

        Test-Path 'C:\Temp\Exit-PpRebootRequested.log' | Should -Be $true
    }
    It 'Should set a ExitMessage' {
        pwsh.exe -File "$PSScriptRoot\Tests_Helper_Scripts\Exit-PpRebootRequested.Tests.Script.ps1" $RootPath 2

        'C:\Temp\Exit-PpRebootRequested.log' | Should -FileContentMatch 'Test where I set ExitMessage'
    }
}
