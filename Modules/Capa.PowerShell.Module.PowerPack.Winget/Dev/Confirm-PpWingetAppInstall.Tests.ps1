BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}
		$script:wingetStub = Join-Path $TestDrive 'winget-stub.cmd'
Describe 'Confirm-PpWingetAppInstall' {
	BeforeEach {
		$script:wingetStub = Join-Path $TestDrive 'winget-stub.ps1'
		$stubContent = "@echo off`r`necho Microsoft.VisualStudioCode"

Write-Output 'Microsoft.VisualStudioCode'
'@
		Set-Content -Path $script:wingetStub -Value $stubContent -Encoding UTF8

		Confirm-PpWingetAppInstall -AppId 'Microsoft.VisualStudioCode' -WingetPath $script:wingetStub | Should -Be $true
		$stubContent = "@echo off`r`necho SomeOtherApp"

Write-Output 'SomeOtherApp'
'@
		Set-Content -Path $script:wingetStub -Value $stubContent -Encoding UTF8

		Confirm-PpWingetAppInstall -AppId 'Microsoft.VisualStudioCode' -WingetPath $script:wingetStub | Should -Be $false
	}

	It 'Has CmdletBinding attribute' {
		$command = Get-Command -Name 'Confirm-PpWingetAppInstall' -CommandType Function -ErrorAction Stop

		($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
	}
}