BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Invoke-BaseAgentDownloadFile' {
	It 'Downloads file when DestinationPath is a folder and polling completes' {
		Mock Get-ItemProperty { [pscustomobject]@{ LocalPort = 1337 } }
		Mock Test-Path { $true } -ParameterFilter { $Path -eq 'C:\Temp' -and $PathType -eq 'Container' }
		Mock Start-Sleep {}

		$script:GetCallCount = 0

		Mock Invoke-WebRequest {
			[pscustomobject]@{
				Headers = [pscustomobject]@{
					Keys = @('Location')
					Location = 'http://localhost:1337/file/abc123'
				}
			}
		} -ParameterFilter { $Method -eq 'Post' -and $Uri -eq 'http://localhost:1337/file' }

		Mock Invoke-WebRequest {
			$script:GetCallCount++
			if ($script:GetCallCount -eq 1) {
				return [pscustomobject]@{ Content = '{"status": "running"}' }
			}

			return [pscustomobject]@{ Content = '{"status": "completed"}' }
		} -ParameterFilter { $Method -eq 'Get' -and $Uri -eq 'http://localhost:1337/file/abc123' }

		Invoke-BaseAgentDownloadFile -RemotePath '\Resources\AgentInstaller\CapaInstaller agent.xml' -DestinationPath 'C:\Temp'

		Assert-MockCalled Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
			$Method -eq 'Post' -and
			$Uri -eq 'http://localhost:1337/file' -and
			$ContentType -eq 'application/json' -and
			$Body -like '*"remote-location": "/Resources/AgentInstaller/CapaInstaller agent.xml"*' -and
			$Body -like '*"local-location": "C:\\Temp\\CapaInstaller agent.xml"*'
		}

		Assert-MockCalled Invoke-WebRequest -Times 2 -Exactly -ParameterFilter {
			$Method -eq 'Get' -and $Uri -eq 'http://localhost:1337/file/abc123'
		}

		Assert-MockCalled Start-Sleep -Times 3 -Exactly
	}

	It 'Supports LocalPath as a backward-compatible alias' {
		Mock Get-ItemProperty { [pscustomobject]@{ LocalPort = 1337 } }
		Mock Test-Path { $false }
		Mock Start-Sleep {}

		Mock Invoke-WebRequest {
			[pscustomobject]@{
				Headers = [pscustomobject]@{
					Keys = @('Location')
					Location = 'http://localhost:1337/file/alias123'
				}
			}
		} -ParameterFilter { $Method -eq 'Post' }

		Mock Invoke-WebRequest {
			[pscustomobject]@{ Content = '{"status": "completed"}' }
		} -ParameterFilter { $Method -eq 'Get' -and $Uri -eq 'http://localhost:1337/file/alias123' }

		Invoke-BaseAgentDownloadFile -RemotePath '\Resources\x.txt' -LocalPath 'C:\Temp\x.txt'

		Assert-MockCalled Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
			$Method -eq 'Post' -and $Body -like '*"local-location": "C:\\Temp\\x.txt"*'
		}
	}

	It 'Throws if POST response has no Location header' {
		Mock Get-ItemProperty { [pscustomobject]@{ LocalPort = 1337 } }
		Mock Test-Path { $false }
		Mock Start-Sleep {}

		Mock Invoke-WebRequest {
			[pscustomobject]@{
				Headers = [pscustomobject]@{
					Keys = @()
				}
			}
		} -ParameterFilter { $Method -eq 'Post' }

		Mock Invoke-WebRequest { [pscustomobject]@{ Content = '{"status": "completed"}' } } -ParameterFilter { $Method -eq 'Get' }

		{ Invoke-BaseAgentDownloadFile -RemotePath '\Resources\x.txt' -DestinationPath 'C:\Temp\x.txt' } | Should -Throw 'Failed to download package'
		Assert-MockCalled Invoke-WebRequest -Times 0 -Exactly -ParameterFilter { $Method -eq 'Get' }
	}

	It 'Throws if polling returns failed status' {
		Mock Get-ItemProperty { [pscustomobject]@{ LocalPort = 1337 } }
		Mock Test-Path { $false }
		Mock Start-Sleep {}

		Mock Invoke-WebRequest {
			[pscustomobject]@{
				Headers = [pscustomobject]@{
					Keys = @('Location')
					Location = 'http://localhost:1337/file/def456'
				}
			}
		} -ParameterFilter { $Method -eq 'Post' }

		Mock Invoke-WebRequest {
			[pscustomobject]@{ Content = '{"status": "failed"}' }
		} -ParameterFilter { $Method -eq 'Get' -and $Uri -eq 'http://localhost:1337/file/def456' }

		{ Invoke-BaseAgentDownloadFile -RemotePath '\Resources\x.txt' -DestinationPath 'C:\Temp\x.txt' } | Should -Throw 'Failed to download package'
	}
}