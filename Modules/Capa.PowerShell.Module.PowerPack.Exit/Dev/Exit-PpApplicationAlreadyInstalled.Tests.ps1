BeforeAll {
    # Import file 
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
    $RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

    #pwsh.exe -File "$PSScriptRoot\Tests_Helper_Scripts\Exit-PpApplicationAlreadyInstalled.Tests.Script.ps1" $RootPath
}
Describe 'Exit-PpApplicationAlreadyInstalled' {
    It 'Should set the error code to 3330' {
        pwsh.exe -File "$PSScriptRoot\Tests_Helper_Scripts\Exit-PpApplicationAlreadyInstalled.Tests.Script.ps1" $RootPath 1

        'C:\Temp\Exit-PpApplicationAlreadyInstalled.log' | Should -FileContentMatch 'SCRIPT.ENDED.WITH.EXITCODE..3330'
    }
    It 'Should set a ExitMessage' {
        pwsh.exe -File "$PSScriptRoot\Tests_Helper_Scripts\Exit-PpApplicationAlreadyInstalled.Tests.Script.ps1" $RootPath 2

        'C:\Temp\Exit-PpApplicationAlreadyInstalled.log' | Should -FileContentMatch 'Test where I set ExitMessage'
        'C:\Temp\Exit-PpApplicationAlreadyInstalled.log' | Should -FileContentMatch 'SCRIPT.ENDED.WITH.EXITCODE..3330'
    }
}
