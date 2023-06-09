BeforeAll {
    # Import file 
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
    $RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
}
Describe 'Exit-PpPackageCancelled' {
    It 'Should set the error code to 3328' {
        pwsh.exe -File "$PSScriptRoot\Tests_Helper_Scripts\Exit-PpPackageCancelled.Tests.Script.ps1" $RootPath 1

        'C:\Temp\Exit-PpPackageCancelled.log' | Should -FileContentMatch 'SCRIPT.ENDED.WITH.EXITCODE..3328'
    }
    It 'Should set a ExitMessage' {
        pwsh.exe -File "$PSScriptRoot\Tests_Helper_Scripts\Exit-PpPackageCancelled.Tests.Script.ps1" $RootPath 2

        'C:\Temp\Exit-PpPackageCancelled.log' | Should -FileContentMatch 'Test where I set ExitMessage'
        'C:\Temp\Exit-PpPackageCancelled.log' | Should -FileContentMatch 'SCRIPT.ENDED.WITH.EXITCODE..3328'
    }
}