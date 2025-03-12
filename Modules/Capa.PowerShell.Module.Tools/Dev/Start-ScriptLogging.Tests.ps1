BeforeAll {
	# Import functions
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')

	$StopLoggingPath = Join-Path $PSScriptRoot 'Stop-ScriptLogging.ps1'
	Import-Module $StopLoggingPath -Force

	# Create test folder
	$TempFolderPath = Join-Path $PSScriptRoot 'Temp'
	$TestFolderName = 'Start-ScriptLogging'
	$TestLogFolder = Join-Path $TempFolderPath "Logs_$TestFolderName"

	Write-Host $TempFolderPath
	if (!(Test-Path $TempFolderPath)) {
		New-Item -Path $TempFolderPath -ItemType Directory | Out-Null
	}
}
Describe 'Does Temp folder exist and are empty' {
	It 'Temp folder exists' {
		Test-Path $TempFolderPath | Should -Be $true
	}
	It 'Temp folder is empty' {
		$TempFolder = Get-ChildItem $TempFolderPath
		$TempFolder.Count | Should -Be 0
	}
}
Describe 'Different log names combinations' {
	It 'Default log name should contain date and time' {
		Start-ScriptLogging -Path $TempFolderPath -LogName $TestFolderName

		$FileDate = $Global:SDKScriptLogfile.Substring($Global:SDKScriptLogfile.Length - 22) -split '-' -split '_'
		$FileDate = Get-Date -Year $FileDate[0] -Month $FileDate[1] -Day $FileDate[2] -Hour $FileDate[3] -Minute $FileDate[4]

		Test-Path $TestLogFolder | Should -Be $true
		Test-Path $Global:SDKScriptLogfile | Should -Be $true
		$FileDate.GetType().Name | Should -Be 'DateTime'
	}
	It 'Log name if $UseTimeInFileName is $false' {
		Start-ScriptLogging -Path $TempFolderPath -LogName $TestFolderName -UseTimeInFileName $false

		$FileDate = ($Global:SDKScriptLogfile.Substring($Global:SDKScriptLogfile.Length - 14) -split '-').split('.')
		$FileDate = Get-Date -Year $FileDate[0] -Month $FileDate[1] -Day $FileDate[2]

		Test-Path $TestLogFolder | Should -Be $true
		Test-Path $Global:SDKScriptLogfile | Should -Be $true
		$FileDate.GetType().Name | Should -Be 'DateTime'
	}
	It 'Log name if $UseDateInFileName is $false' {
		Start-ScriptLogging -Path $TempFolderPath -LogName $TestFolderName -UseDateInFileName $false

		$FileName = ($Global:SDKScriptLogfile -split '\\')[-1].Split('.')
		$FileName[0] | Should -Be $TestFolderName

		Stop-ScriptLogging
		Start-Sleep -Seconds 1

		Start-ScriptLogging -Path $TempFolderPath -LogName $TestFolderName -UseDateInFileName $false -UseTimeInFileName $true
		$FileName = ($Global:SDKScriptLogfile -split '\\')[-1].Split('.')
		$FileName[0] | Should -Be $TestFolderName
	}
}
Describe 'Does $Global:TranscriptSesions work' {
	It 'There should be 1 transcript session' {
		$Global:TranscriptSesions | Should -Be 1
	}
	It 'There should be 2 transcript sessions' {
		Start-ScriptLogging -Path $TempFolderPath -LogName $TestFolderName
		$Global:TranscriptSesions | Should -Be 2
	}
}
Describe 'Does stopwatch work' {
	It 'Stopwatch should be started' {
		$Global:SDKScriptStopwatch | Should -Not -Be $null
	}
	It 'Stopwatch should be stopped' {
		Stop-ScriptLogging
		$Global:SDKScriptStopwatch | Should -Be $null
	}
	It "Log file should contain 'Elapsed time:'" {
		$String = 'Elapsed time: . day.s. . hour.s.'
		$Content = Get-Content -Path $Global:SDKScriptLogfile -Raw

		$Global:SDKScriptLogfile | Should -FileContentMatch $String
	}
}
Describe 'Does $AppendToLog work' {
	It 'Log file should Append to log file' {
		# Test whiteout date in file name
		Start-ScriptLogging -Path $TempFolderPath -LogName $TestFolderName -UseDateInFileName $false
		Stop-ScriptLogging
		Start-ScriptLogging -Path $TempFolderPath -LogName $TestFolderName -UseDateInFileName $false

		$PathNoDate = "$($Global:SDKScriptLogfile.Split('.')[0])_1.log"

		Test-Path $Global:SDKScriptLogfile | Should -Be $true
		Test-Path $PathNoDate | Should -Be $false

		# Test whiteout time in file name
		Start-ScriptLogging -Path $TempFolderPath -LogName $TestFolderName -UseTimeInFileName $false
		Stop-ScriptLogging
		Start-ScriptLogging -Path $TempFolderPath -LogName $TestFolderName -UseTimeInFileName $false

		$PathNoTime = "$($Global:SDKScriptLogfile.Split('.')[0])_1.log"

		Test-Path $Global:SDKScriptLogfile | Should -Be $true
		Test-Path $PathNoTime | Should -Be $false
	}
	It 'Log file should not Append to log file' {
		# Test whiteout date in file name
		Start-ScriptLogging -Path $TempFolderPath -LogName $TestFolderName -UseDateInFileName $false -AppendToLog $false
		Stop-ScriptLogging

		$TestLogFolder
		$PathNoDate = $Global:SDKScriptLogfile.Split('.')[-2].Split('\')[-1].Split('_')[0]
		$PathNoDate = "$TestLogFolder\$($PathNoDate)_1.log"

		Test-Path $Global:SDKScriptLogfile | Should -Be $true
		Test-Path $PathNoDate | Should -Be $true

		# Test whiteout time in file name
		Start-ScriptLogging -Path $TempFolderPath -LogName $TestFolderName -UseTimeInFileName $false -AppendToLog $false
		Stop-ScriptLogging
		Start-ScriptLogging -Path $TempFolderPath -LogName $TestFolderName -UseTimeInFileName $false -AppendToLog $false

		$PathNoTime = $Global:SDKScriptLogfile.Split('.')[-2].Split('\')[-1].Split('_')[0]
		$PathNoTime = "$TestLogFolder\$($PathNoTime)_1.log"

		Test-Path $Global:SDKScriptLogfile | Should -Be $true
		Test-Path $PathNoTime | Should -Be $true
	}
}
Describe 'Does $DeleteDaysOldLogs work' {
	It 'Only one file should exist' {
		Stop-ScriptLogging
		Start-ScriptLogging -Path $TempFolderPath -LogName $TestFolderName -DeleteDaysOldLogs -1

		$Files = Get-ChildItem $TestLogFolder
		$Files.Count | Should -Be 1
	}
}
Describe 'Does $DeleteAllLogs work' {
	It 'Only one file should exist' {
		Stop-ScriptLogging
		Start-ScriptLogging -Path $TempFolderPath -LogName $TestFolderName -DeleteAllLogs $true

		Start-Sleep -Seconds 2

		$Files = Get-ChildItem $TestLogFolder
		$Files.Count | Should -Be 1
	}
}
AfterAll {
	Stop-ScriptLogging
	Start-Sleep -Seconds 3
	Remove-Item $TempFolderPath -Force -Recurse
}
