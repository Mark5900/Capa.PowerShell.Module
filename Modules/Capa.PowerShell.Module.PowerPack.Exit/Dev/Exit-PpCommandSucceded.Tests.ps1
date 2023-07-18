BeforeAll {
    # Import file 
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
    $RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
}
Describe 'Exit-PpCommandSucceded' {
    It 'Should set the error code to 3300' {
        pwsh.exe -File "$PSScriptRoot\Tests_Helper_Scripts\Exit-PpCommandSucceded.Tests.Script.ps1" $RootPath 1

        'C:\Temp\Exit-PpCommandSucceded.log' | Should -FileContentMatch 'SCRIPT.ENDED.WITH.EXITCODE..3300'
    }
    It 'Should set a ExitMessage' {
        pwsh.exe -File "$PSScriptRoot\Tests_Helper_Scripts\Exit-PpCommandSucceded.Tests.Script.ps1" $RootPath 2

        'C:\Temp\Exit-PpCommandSucceded.log' | Should -FileContentMatch 'Test where I set ExitMessage'
        'C:\Temp\Exit-PpCommandSucceded.log' | Should -FileContentMatch 'SCRIPT.ENDED.WITH.EXITCODE..3300'
    }
}
