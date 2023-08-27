BeforeAll {
    # Import file and parameters
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
    
    $RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
    $DllPath = 'C:\Temp\CapaOne.ScriptingLibrary.dll'
    $LogFilePath = 'C:\Temp\Initialize-PpVariables.log'
    
    # Import modules
    Import-Module "$RootPath\Capa.PowerShell.Module.PowerPack.Job\Dev\Job_DisableLog.ps1" -Force
    Import-Module "$RootPath\Capa.PowerShell.Module.PowerPack.Job\Dev\Job_WriteLog.ps1" -Force
    Import-Module "$RootPath\Capa.PowerShell.Module.PowerPack.Job\Dev\Job_EnableLog.ps1" -Force
    Import-Module "$RootPath\Capa.PowerShell.Module.PowerPack.Job\Dev\Job_Start.ps1" -Force
    Import-Module "$RootPath\Capa.PowerShell.Module.PowerPack\Dev\Add-PsDll.ps1" -Force
    Import-Module "$RootPath\Capa.PowerShell.Module.PowerPack.Exit\Dev\Exit-PSScript.ps1" -Force

    # Startup Code
    $Global:Cs = Add-PsDll -DllPath $DllPath
    Job_Start -JobType 'WS' -PackageName 'PesterTest' -PackageVersion 'v1.0' -LogPath $LogFilePath -Action 'INSTALL'
    Initialize-PpVariables -DllPath $DllPath

    # Parameters to make tests work
    $UUID = (Get-ItemProperty -Path HKLM:\SOFTWARE\CapaSystems\CapaInstaller\Client -Name UUID).UUID
    $Model = (Get-CimInstance -ClassName Win32_ComputerSystem).Model
    $Manufacturer = (Get-CimInstance -ClassName Win32_ComputerSystem).Manufacturer
    $UnitName = (Get-CimInstance -ClassName Win32_ComputerSystem).Name
    $WindowsType = (Get-CimInstance -ClassName Win32_OperatingSystem).Caption
    $WindowsVersion = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\' -Name CurrentVersion).CurrentVersion
    $DisplayVersion = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\' -Name DisplayVersion).DisplayVersion
    $EditionId = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\' -Name CompositionEditionID).CompositionEditionID
    $CurrentBuild = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\' -Name CurrentBuild).CurrentBuild
    $OsSystem = (Get-CimInstance -ClassName Win32_OperatingSystem).Caption
}
Describe '$global:gsProgramFiles' {
    It 'Should be "C:\Program Files"' {
        $global:gsProgramFiles | Should -Be 'C:\Program Files'
    }
    It 'Should be a string' {
        $global:gsProgramFiles | Should -BeOfType [string]
    }
    It 'Should be a valid path' {
        Test-Path $global:gsProgramFiles | Should -Be $true
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsProgramFiles | Should -Be $Global:Cs.gsProgramFiles
    }
}
Describe '$global:gsProgramFilesx86' {
    It 'Should be "C:\Program Files (x86)"' {
        $global:gsProgramFilesx86 | Should -Be 'C:\Program Files (x86)'
    }
    It 'Should be a string' {
        $global:gsProgramFilesx86 | Should -BeOfType [string]
    }
    It 'Should be a valid path' {
        Test-Path $global:gsProgramFilesx86 | Should -Be $true
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsProgramFilesx86 | Should -Be $Global:Cs.gsProgramFilesx86
    }
}
Describe '$global:gsWindir' {
    It 'Should be "C:\Windows"' {
        $global:gsWindir | Should -Be 'C:\Windows'
    }
    It 'Should be a string' {
        $global:gsWindir | Should -BeOfType [string]
    }
    It 'Should be a valid path' {
        Test-Path $global:gsWindir | Should -Be $true
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsWindir | Should -Be $Global:Cs.gsWindowsDir
    }
}
Describe '$global:gsWindowsDir' {
    It 'Should be "C:\Windows"' {
        $global:gsWindowsDir | Should -Be 'C:\Windows'
    }
    It 'Should be a string' {
        $global:gsWindowsDir | Should -BeOfType [string]
    }
    It 'Should be a valid path' {
        Test-Path $global:gsWindowsDir | Should -Be $true
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsWindowsDir | Should -Be $Global:Cs.gsWindowsDir
    }
}
Describe '$global:gsWorkstationPath' {
    It 'Should be "C:\Program Files\CapaInstaller\Client\"' {
        $global:gsWorkstationPath | Should -Be 'C:\Program Files\CapaInstaller\Client\'
    }
    It 'Should be a string' {
        $global:gsWorkstationPath | Should -BeOfType [string]
    }
    It 'Should be a valid path' {
        Test-Path $global:gsWorkstationPath | Should -Be $true
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsWorkstationPath | Should -Be $Global:Cs.gsWorkstationPath
    }
}
Describe '$global:gsSystemRoot' {
    It 'Should be "C:\Windows"' {
        $global:gsSystemRoot | Should -Be 'C:\Windows'
    }
    It 'Should be a string' {
        $global:gsSystemRoot | Should -BeOfType [string]
    }
    It 'Should be a valid path' {
        Test-Path $global:gsSystemRoot | Should -Be $true
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsSystemRoot | Should -Be $Global:Cs.gsSystemRoot
    }
}
Describe '$global:gsSystemDir' {
    It 'Should be "C:\Windows\System32"' {
        $global:gsSystemDir | Should -Be 'C:\Windows\System32'
    }
    It 'Should be a string' {
        $global:gsSystemDir | Should -BeOfType [string]
    }
    It 'Should be a valid path' {
        Test-Path $global:gsSystemDir | Should -Be $true
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsSystemDir | Should -Be $Global:Cs.gsSystemDir
    }
}
Describe '$global:gsSystemDirx86' {
    It 'Should be "C:\Windows\SysWOW64"' {
        $global:gsSystemDirx86 | Should -Be 'C:\Windows\SysWOW64'
    }
    It 'Should be a string' {
        $global:gsSystemDirx86 | Should -BeOfType [string]
    }
    It 'Should be a valid path' {
        Test-Path $global:gsSystemDirx86 | Should -Be $true
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsSystemDirx86 | Should -Be $Global:Cs.gsSystemDirx86
    }
}
Describe '$global:gsLogDir' {
    It 'Should be "C:\Program Files\CapaInstaller\Client\Logs"' {
        $global:gsLogDir | Should -Be 'C:\Program Files\CapaInstaller\Client\Logs'
    }
    It 'Should be a string' {
        $global:gsLogDir | Should -BeOfType [string]
    }
    It 'Should be a valid path' {
        Test-Path $global:gsLogDir | Should -Be $true
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsLogDir | Should -Be $Global:Cs.gsLogDir
    }
}
Describe '$global:gsTempDir' {
    It 'Should be "C:\Program Files\CapaInstaller\Client\Logs\Temp"' {
        $global:gsTempDir | Should -Be 'C:\Program Files\CapaInstaller\Client\Logs\Temp'
    }
    It 'Should be a string' {
        $global:gsTempDir | Should -BeOfType [string]
    }
    It 'Should be a valid path' {
        Test-Path $global:gsTempDir | Should -Be $true
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsTempDir | Should -Be $Global:Cs.gsTempDir
    }
}
Describe '$global:gsOsSystem' {
    It "Should be $OsSystem" {
        $global:gsOsSystem | Should -Be $OsSystem
    }
    It 'Should be a string' {
        $global:gsOsSystem | Should -BeOfType [string]
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsOsSystem | Should -Be $Global:Cs.gsOsSystem
    }
}
Describe '$global:gsOsVersion' {
    It 'Should be "10.0.20348.0"' {
        $global:gsOsVersion | Should -Be '10.0.20348.0'
    }
    It 'Should be a string' {
        $global:gsOsVersion | Should -BeOfType [string]
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsOsVersion | Should -Be $Global:Cs.gsOsVersion
    }
}
Describe '$global:gsLog' {
    It 'Should be "C:\Temp\Initialize-PpVariables.log"' {
        $global:gsLog | Should -Be 'C:\Temp\Initialize-PpVariables.log'
    }
    It 'Should be a string' {
        $global:gsLog | Should -BeOfType [string]
    }
    It 'Should be a valid path' {
        Test-Path $global:gsLog | Should -Be $true
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsLog | Should -Be $Global:Cs.gsLog
    }
}
Describe '$global:gsLogName' {
    It 'Should be "Initialize-PpVariables.log"' {
        $global:gsLogName | Should -Be 'Initialize-PpVariables.log'
    }
    It 'Should be a string' {
        $global:gsLogName | Should -BeOfType [string]
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsLogName | Should -Be $Global:Cs.gsLogName
    }
}
Describe '$global:gsTask' {
    It 'Should be "INSTALL"' {
        $global:gsTask | Should -Be 'INSTALL'
    }
    It 'Should be a string' {
        $global:gsTask | Should -BeOfType [string]
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsTask | Should -Be $Global:Cs.gsTask
    }
}
Describe '$global:gbDisablelog' {
    It 'Should be $false' {
        $global:gbDisablelog | Should -Be $false
    }
    It 'Should be a boolean' {
        $global:gbDisablelog | Should -BeOfType [bool]
    }
    It 'Should be the same as $Global:Cs' {
        $global:gbDisablelog | Should -Be $Global:Cs.gbDisablelog
    }
}
Describe '$global:gbSuficientDiskSpace' {
    It 'Should be $true' {
        $global:gbSuficientDiskSpace | Should -Be $true
    }
    It 'Should be a boolean' {
        $global:gbSuficientDiskSpace | Should -BeOfType [bool]
    }
    It 'Should be the same as $Global:Cs' {
        $global:gbSuficientDiskSpace | Should -Be $Global:Cs.gbSuficientDiskSpace
    }
}
Describe '$global:gsJobName' {
    It 'Should be "PesterTest"' {
        $global:gsJobName | Should -Be 'PesterTest'
    }
    It 'Should be a string' {
        $global:gsJobName | Should -BeOfType [string]
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsJobName | Should -Be $Global:Cs.gsJobName
    }
}
Describe '$global:gsLibrary' {
    It 'Should be "C:\Program Files\CapaInstaller\Client\Lib"' {
        $global:gsLibrary | Should -Be 'C:\Program Files\CapaInstaller\Client\Lib'
    }
    It 'Should be a string' {
        $global:gsLibrary | Should -BeOfType [string]
    }
    It 'Should be a valid path' {
        Test-Path $global:gsLibrary | Should -Be $true
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsLibrary | Should -Be $Global:Cs.gsLibrary
    }
}
Describe '$global:gbx64' {
    It 'Should be $true' {
        $global:gbx64 | Should -Be $true
    }
    It 'Should be a boolean' {
        $global:gbx64 | Should -BeOfType [bool]
    }
    It 'Should be the same as $Global:Cs' {
        $global:gbx64 | Should -Be $Global:Cs.gbx64
    }
}
Describe '$global:gsCommonPrograms' {
    It 'Should be "C:\ProgramData\Microsoft\Windows\Start Menu\Programs"' {
        $global:gsCommonPrograms | Should -Be 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs'
    }
    It 'Should be a string' {
        $global:gsCommonPrograms | Should -BeOfType [string]
    }
    It 'Should be a valid path' {
        Test-Path $global:gsCommonPrograms | Should -Be $true
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsCommonPrograms | Should -Be $Global:Cs.gsCommonPrograms
    }
}
Describe '$global:gsSysDrive' {
    It 'Should be "C:"' {
        $global:gsSysDrive | Should -Be 'C:'
    }
    It 'Should be a string' {
        $global:gsSysDrive | Should -BeOfType [string]
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsSysDrive | Should -Be $Global:Cs.gsSysDrive
    }
}
Describe '$global:gsCommonDesktop' {
    It 'Should be "C:\Users\Public\Desktop"' {
        $global:gsCommonDesktop | Should -Be 'C:\Users\Public\Desktop'
    }
    It 'Should be a string' {
        $global:gsCommonDesktop | Should -BeOfType [string]
    }
    It 'Should be a valid path' {
        Test-Path $global:gsCommonDesktop | Should -Be $true
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsCommonDesktop | Should -Be $Global:Cs.gsCommonDesktop
    }
}
Describe '$global:gsCommonStartMenu' {
    It 'Should be "C:\ProgramData\Microsoft\Windows\Start Menu"' {
        $global:gsCommonStartMenu | Should -Be 'C:\ProgramData\Microsoft\Windows\Start Menu'
    }
    It 'Should be a string' {
        $global:gsCommonStartMenu | Should -BeOfType [string]
    }
    It 'Should be a valid path' {
        Test-Path $global:gsCommonStartMenu | Should -Be $true
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsCommonStartMenu | Should -Be $Global:Cs.gsCommonStartMenu
    }
}
Describe '$global:gsCommonStartup' {
    It 'Should be "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"' {
        $global:gsCommonStartup | Should -Be 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup'
    }
    It 'Should be a string' {
        $global:gsCommonStartup | Should -BeOfType [string]
    }
    It 'Should be a valid path' {
        Test-Path $global:gsCommonStartup | Should -Be $true
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsCommonStartup | Should -Be $Global:Cs.gsCommonStartup
    }
}
Describe '$global:gsCommonFilesDir' {
    It 'Should be "C:\Program Files\Common Files"' {
        $global:gsCommonFilesDir | Should -Be 'C:\Program Files\Common Files'
    }
    It 'Should be a string' {
        $global:gsCommonFilesDir | Should -BeOfType [string]
    }
    It 'Should be a valid path' {
        Test-Path $global:gsCommonFilesDir | Should -Be $true
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsCommonFilesDir | Should -Be $Global:Cs.gsCommonFilesDir
    }
}
Describe '$global:gsCommonFiles' {
    It 'Should be "C:\Program Files\Common Files"' {
        $global:gsCommonFiles | Should -Be 'C:\Program Files\Common Files'
    }
    It 'Should be a string' {
        $global:gsCommonFiles | Should -BeOfType [string]
    }
    It 'Should be a valid path' {
        Test-Path $global:gsCommonFiles | Should -Be $true
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsCommonFiles | Should -Be $Global:Cs.gsCommonFilesDir
    }
}
Describe '$global:gsCommonFilesDirx86' {
    It 'Should be "C:\Program Files (x86)\Common Files"' {
        $global:gsCommonFilesDirx86 | Should -Be 'C:\Program Files (x86)\Common Files'
    }
    It 'Should be a string' {
        $global:gsCommonFilesDirx86 | Should -BeOfType [string]
    }
    It 'Should be a valid path' {
        Test-Path $global:gsCommonFilesDirx86 | Should -Be $true
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsCommonFilesDirx86 | Should -Be $Global:Cs.gsCommonFilesDirx86
    }
}
Describe '$global:gsCommonFilesx86' {
    It 'Should be "C:\Program Files (x86)\Common Files"' {
        $global:gsCommonFilesx86 | Should -Be 'C:\Program Files (x86)\Common Files'
    }
    It 'Should be a string' {
        $global:gsCommonFilesx86 | Should -BeOfType [string]
    }
    It 'Should be a valid path' {
        Test-Path $global:gsCommonFilesx86 | Should -Be $true
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsCommonFilesx86 | Should -Be $Global:Cs.gsCommonFilesDirx86
    }
}
Describe '$global:gsCommonAppData' {
    It 'Should be "C:\ProgramData"' {
        $global:gsCommonAppData | Should -Be 'C:\ProgramData'
    }
    It 'Should be a string' {
        $global:gsCommonAppData | Should -BeOfType [string]
    }
    It 'Should be a valid path' {
        Test-Path $global:gsCommonAppData | Should -Be $true
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsCommonAppData | Should -Be $Global:Cs.gsCommonAppData
    }
}
Describe '$global:gsProgramData' {
    It 'Should be "C:\ProgramData"' {
        $global:gsProgramData | Should -Be 'C:\ProgramData'
    }
    It 'Should be a string' {
        $global:gsProgramData | Should -BeOfType [string]
    }
    It 'Should be a valid path' {
        Test-Path $global:gsProgramData | Should -Be $true
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsProgramData | Should -Be $Global:Cs.gsProgramData
    }
}
Describe '$global:gsProductid' {
    It 'Should be "PesterTest"' {
        $global:gsProductid | Should -Be 'PesterTest'
    }
    It 'Should be a string' {
        $global:gsProductid | Should -BeOfType [string]
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsProductid | Should -Be $Global:Cs.gsProductid
    }
}
Describe '$global:gsAllusers' {
    It 'Should be "C:\ProgramData"' {
        $global:gsAllusers | Should -Be 'C:\ProgramData'
    }
    It 'Should be a string' {
        $global:gsAllusers | Should -BeOfType [string]
    }
    It 'Should be a valid path' {
        Test-Path $global:gsAllusers | Should -Be $true
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsAllusers | Should -Be $Global:Cs.gsAllusers
    }
}
Describe '$global:gsWorkstationName' {
    It "Should be $env:COMPUTERNAME" {
        $global:gsWorkstationName | Should -Be $env:COMPUTERNAME
    }
    It 'Should be a string' {
        $global:gsWorkstationName | Should -BeOfType [string]
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsWorkstationName | Should -Be $Global:Cs.gsWorkstationName
    }
}
Describe '$global:gsOsBuild' {
    It "Should be $CurrentBuild" {
        $global:gsOsBuild | Should -Be $CurrentBuild
    }
    It 'Should be a string' {
        $global:gsOsBuild | Should -BeOfType [string]
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsOsBuild | Should -Be $Global:Cs.gsOsBuild
    }
}
Describe '$global:gsEditionId' {
    It "Should be $EditionId" {
        $global:gsEditionId | Should -Be $EditionId
    }
    It 'Should be a string' {
        $global:gsEditionId | Should -BeOfType [string]
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsEditionId | Should -Be $Global:Cs.gsEditionId
    }
}
Describe '$global:gsDisplayVersion' {
    It "Should be '$DisplayVersion'" {
        $global:gsDisplayVersion | Should -Be $DisplayVersion
    }
    It 'Should be a string' {
        $global:gsDisplayVersion | Should -BeOfType [string]
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsDisplayVersion | Should -Be $Global:Cs.gsDisplayVersion
    }
}
Describe '$global:gsWindowsType' {
    It 'Should be "LanmanNT"' {
        $global:gsWindowsType | Should -Be 'LanmanNT'
    }
    It 'Should be a string' {
        $global:gsWindowsType | Should -BeOfType [string]
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsWindowsType | Should -Be $Global:Cs.gsWindowsType
    }
}
Describe '$global:gsOsArchitechture' {
    It 'Should be "X64"' {
        $global:gsOsArchitechture | Should -Be 'X64'
    }
    It 'Should be a string' {
        $global:gsOsArchitechture | Should -BeOfType [string]
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsOsArchitechture | Should -Be $Global:Cs.gsOsArchitechture
    }
}
Describe '$global:gsWindowsVersion' {
    It 'Should be same as $WindowsVersion' {
        $global:gsWindowsVersion | Should -Be $WindowsVersion
    }
    It 'Should be a string' {
        $global:gsWindowsVersion | Should -BeOfType [string]
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsWindowsVersion | Should -Be $Global:Cs.gsWindowsVersion
    }
}
Describe '$global:gsUnitName' {
    It 'Should be same as $UnitName or $UUID' {
        $global:gsUnitName | Should -Match "$UnitName|$UUID"
    }
    It 'Should be a string' {
        $global:gsUnitName | Should -BeOfType [string]
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsUnitName | Should -Be $Global:Cs.gsUnitName
    }
}
Describe '$global:gsComputerManufacturer' {
    It 'Should be same as $Manufacturer' {
        $global:gsComputerManufacturer | Should -Be $Manufacturer
    }
    It 'Should be a string' {
        $global:gsComputerManufacturer | Should -BeOfType [string]
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsComputerManufacturer | Should -Be $Global:Cs.gsComputerManufacturer
    }
}
Describe '$global:gsComputerModel' {
    It 'Should be same as $Model' {
        $global:gsComputerModel | Should -Be $Model
    }
    It 'Should be a string' {
        $global:gsComputerModel | Should -BeOfType [string]
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsComputerModel | Should -Be $Global:Cs.gsComputerModel
    }
}
Describe '$global:gsUUID' {
    It 'UUID Should be same as $UUID' {
        $global:gsUUID | Should -Be $UUID
    }
    It 'Should be a string' {
        $global:gsUUID | Should -BeOfType [string]
    }
    It 'Should be the same as $Global:Cs' {
        $global:gsUUID | Should -Be $Global:Cs.gsUUID
    }
}