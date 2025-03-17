BeforeAll {
    # Import file
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}
Describe 'Add-PpDll' {
    It 'Should load the CapaOne.ScriptingLibrary.dll' {
        $Cs = Add-PpDll
        $Cs | Should -BeOfType 'CapaOne.ScriptingLibrary'
    }
    It 'Should throw an error when the dll is not found' {
        { Add-PpDll -DllPath 'C:\Temp\NotExisting.dll' } | Should -Throw
    }
}