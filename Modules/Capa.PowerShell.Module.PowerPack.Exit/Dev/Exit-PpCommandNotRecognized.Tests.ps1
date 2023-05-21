BeforeAll {
    # Import file 
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
    $RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

    #pwsh.exe -File "$PSScriptRoot\Tests_Helper_Scripts\Exit-PpCommandNotRecognized.Tests.Script.ps1" $RootPath
}
Describe 'Exit-PpCommandNotRecognized' {
    It 'Should set the error code to 3307' {
        pwsh.exe -File "$PSScriptRoot\Tests_Helper_Scripts\Exit-PpCommandNotRecognized.Tests.Script.ps1" $RootPath 1

        'C:\Temp\Exit-PpCommandNotRecognized.log' | Should -FileContentMatch 'SCRIPT.ENDED.WITH.EXITCODE..3307'
    }
    It 'Should set a ExitMessage' {
        pwsh.exe -File "$PSScriptRoot\Tests_Helper_Scripts\Exit-PpCommandNotRecognized.Tests.Script.ps1" $RootPath 2

        'C:\Temp\Exit-PpCommandNotRecognized.log' | Should -FileContentMatch 'Test where I set ExitMessage'
        'C:\Temp\Exit-PpCommandNotRecognized.log' | Should -FileContentMatch 'SCRIPT.ENDED.WITH.EXITCODE..3307'
    }
}
