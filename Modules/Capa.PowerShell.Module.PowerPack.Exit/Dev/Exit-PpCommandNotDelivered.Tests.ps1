BeforeAll {
    # Import file 
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
    $RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

    #pwsh.exe -File "$PSScriptRoot\Tests_Helper_Scripts\Exit-PpCommandNotDelivered.Tests.Script.ps1" $RootPath
}
Describe 'Exit-PpCommandNotDelivered' {
    It 'Should set the error code to 3302' {
        pwsh.exe -File "$PSScriptRoot\Tests_Helper_Scripts\Exit-PpCommandNotDelivered.Tests.Script.ps1" $RootPath 1

        'C:\Temp\Exit-PpCommandNotDelivered.log' | Should -FileContentMatch 'SCRIPT.ENDED.WITH.EXITCODE..3302'
    }
    It 'Should set a ExitMessage' {
        pwsh.exe -File "$PSScriptRoot\Tests_Helper_Scripts\Exit-PpCommandNotDelivered.Tests.Script.ps1" $RootPath 2

        'C:\Temp\Exit-PpCommandNotDelivered.log' | Should -FileContentMatch 'Test where I set ExitMessage'
        'C:\Temp\Exit-PpCommandNotDelivered.log' | Should -FileContentMatch 'SCRIPT.ENDED.WITH.EXITCODE..3302'
    }
}
