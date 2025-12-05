BeforeAll {
	# Import the module
	$ModulePath = Split-Path -Parent $PSCommandPath
	$ModuleName = 'Capa.PowerShell.Module.CCS'

	# Import module if not already loaded
	if (-not (Get-Module -Name $ModuleName)) {
		Import-Module "$ModulePath\$ModuleName.psd1" -Force -ErrorAction Stop
	}
}

Describe 'Invoke-CCSErrorHandling' -Tag 'Unit' {

	Context 'Parameter Validation' {

		It 'Should have mandatory ErrorMessage parameter' {
			(Get-Command Invoke-CCSErrorHandling).Parameters['ErrorMessage'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have optional ErrorCategory parameter' {
			(Get-Command Invoke-CCSErrorHandling).Parameters['ErrorCategory'].Attributes.Mandatory | Should -Be $false
		}

		It 'Should have optional TargetObject parameter' {
			(Get-Command Invoke-CCSErrorHandling).Parameters['TargetObject'].Attributes.Mandatory | Should -Be $false
		}

		It 'Should have optional FunctionName parameter' {
			(Get-Command Invoke-CCSErrorHandling).Parameters['FunctionName'].Attributes.Mandatory | Should -Be $false
		}

		It 'Should have optional RecommendedAction parameter' {
			(Get-Command Invoke-CCSErrorHandling).Parameters['RecommendedAction'].Attributes.Mandatory | Should -Be $false
		}

		It 'Should validate ErrorCategory values' {
			$param = (Get-Command Invoke-CCSErrorHandling).Parameters['ErrorCategory']
			$validateSet = $param.Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }
			$validateSet.ValidValues | Should -Contain 'ConnectionError'
			$validateSet.ValidValues | Should -Contain 'AuthenticationError'
			$validateSet.ValidValues | Should -Contain 'ObjectNotFound'
		}
	}

	Context 'Error Throwing Behavior' {

		It 'Should throw a terminating error by default' {
			{ Invoke-CCSErrorHandling -ErrorMessage "Test error" } | Should -Throw
		}

		It 'Should throw with custom error category' {
			{ Invoke-CCSErrorHandling -ErrorMessage "Connection failed" -ErrorCategory ConnectionError } | Should -Throw -ErrorId "*ConnectionError*"
		}

		It 'Should write non-terminating error when Throw is false' {
			$ErrorActionPreference = 'SilentlyContinue'
			{ Invoke-CCSErrorHandling -ErrorMessage "Test warning" -Throw:$false -ErrorAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should include error message in exception' {
			try {
				Invoke-CCSErrorHandling -ErrorMessage "Custom error message"
			} catch {
				$_.Exception.Message | Should -BeLike "*Custom error message*"
			}
		}
	}

	Context 'Function Name Detection' {

		It 'Should auto-detect calling function name' {
			function Test-CallingFunction {
				Invoke-CCSErrorHandling -ErrorMessage "Auto-detect test"
			}

			try {
				Test-CallingFunction
			} catch {
				$_.Exception.Message | Should -BeLike "*Test-CallingFunction*"
			}
		}

		It 'Should use provided function name when specified' {
			try {
				Invoke-CCSErrorHandling -ErrorMessage "Custom function" -FunctionName "MyCustomFunction"
			} catch {
				$_.Exception.Message | Should -BeLike "*MyCustomFunction*"
			}
		}
	}

	Context 'Error Record Properties' {

		It 'Should set TargetObject correctly' {
			$testObject = "TestTarget"
			try {
				Invoke-CCSErrorHandling -ErrorMessage "Target test" -TargetObject $testObject
			} catch {
				$_.TargetObject | Should -Be $testObject
			}
		}

		It 'Should set ErrorCategory correctly' {
			try {
				Invoke-CCSErrorHandling -ErrorMessage "Category test" -ErrorCategory AuthenticationError
			} catch {
				$_.CategoryInfo.Category | Should -Be ([System.Management.Automation.ErrorCategory]::AuthenticationError)
			}
		}

		It 'Should include recommended action when provided' {
			try {
				Invoke-CCSErrorHandling -ErrorMessage "Action test" -RecommendedAction "Try again with valid credentials"
			} catch {
				$_.ErrorDetails.RecommendedAction | Should -BeLike "*Try again with valid credentials*"
			}
		}

		It 'Should create proper ErrorId format' {
			try {
				Invoke-CCSErrorHandling -ErrorMessage "ID test" -FunctionName "TestFunction" -ErrorCategory ObjectNotFound
			} catch {
				$_.FullyQualifiedErrorId | Should -BeLike "CCS.TestFunction.ObjectNotFound"
			}
		}
	}

	Context 'Global Cs Logging' {

		BeforeEach {
			# Mock global Cs object
			$Global:Cs = [PSCustomObject]@{
				LogMessages = @()
				Job_WriteLog = {
					param($message, $isError)
					$Global:Cs.LogMessages += @{ Message = $message; IsError = $isError }
				}.GetNewClosure()
			}
		}

		AfterEach {
			Remove-Variable -Name Cs -Scope Global -ErrorAction SilentlyContinue
		}

		It 'Should log to global Cs object when available' {
			try {
				Invoke-CCSErrorHandling -ErrorMessage "Cs logging test" -FunctionName "TestFunc"
			} catch {
				# Error was thrown, check if it was logged
			}
			$Global:Cs.LogMessages.Count | Should -BeGreaterThan 0
			$Global:Cs.LogMessages[0].Message | Should -BeLike "*Cs logging test*"
			$Global:Cs.LogMessages[0].IsError | Should -Be $true
		}

		It 'Should not log when LogToCs is false' {
			try {
				Invoke-CCSErrorHandling -ErrorMessage "No logging test" -LogToCs:$false
			} catch {
				# Error was thrown
			}
			$Global:Cs.LogMessages.Count | Should -Be 0
		}

		It 'Should not fail when Cs object is not available' {
			Remove-Variable -Name Cs -Scope Global -ErrorAction SilentlyContinue
			{
				try {
					Invoke-CCSErrorHandling -ErrorMessage "No Cs test"
				} catch {
					# Expected to throw, but not because of missing Cs
				}
			} | Should -Not -Throw
		}
	}

	Context 'Exception Wrapping' {

		It 'Should accept and wrap an existing exception' {
			$originalException = New-Object System.UnauthorizedAccessException("Access denied")

			try {
				Invoke-CCSErrorHandling -ErrorMessage "Wrapped error" -Exception $originalException
			} catch {
				$_.Exception | Should -BeOfType [System.UnauthorizedAccessException]
				$_.Exception.Message | Should -Be "Access denied"
			}
		}

		It 'Should create new exception when none provided' {
			try {
				Invoke-CCSErrorHandling -ErrorMessage "New exception"
			} catch {
				$_.Exception | Should -Not -BeNullOrEmpty
				$_.Exception.GetType().Name | Should -Be 'InvalidOperationException'
			}
		}
	}

	Context 'Different Error Categories' {

		It 'Should handle ConnectionError category' {
			{ Invoke-CCSErrorHandling -ErrorMessage "Connection failed" -ErrorCategory ConnectionError } | Should -Throw
		}

		It 'Should handle AuthenticationError category' {
			{ Invoke-CCSErrorHandling -ErrorMessage "Auth failed" -ErrorCategory AuthenticationError } | Should -Throw
		}

		It 'Should handle ObjectNotFound category' {
			{ Invoke-CCSErrorHandling -ErrorMessage "Not found" -ErrorCategory ObjectNotFound } | Should -Throw
		}

		It 'Should handle PermissionDenied category' {
			{ Invoke-CCSErrorHandling -ErrorMessage "Access denied" -ErrorCategory PermissionDenied } | Should -Throw
		}

		It 'Should handle InvalidArgument category' {
			{ Invoke-CCSErrorHandling -ErrorMessage "Invalid input" -ErrorCategory InvalidArgument } | Should -Throw
		}
	}
}

Describe 'Invoke-CCSErrorHandling - Integration with Other Functions' -Tag 'Integration' {

	Context 'Real-world Usage Scenarios' {

		It 'Should provide useful error information for debugging' {
			function Test-RealWorldScenario {
				param($ComputerName)

				if ($ComputerName -eq 'INVALID') {
					Invoke-CCSErrorHandling `
						-ErrorMessage "Computer '$ComputerName' not found in Active Directory" `
						-ErrorCategory ObjectNotFound `
						-TargetObject $ComputerName `
						-RecommendedAction "Verify that the computer exists in AD and the name is spelled correctly"
				}
			}

			try {
				Test-RealWorldScenario -ComputerName 'INVALID'
			} catch {
				$_.Exception.Message | Should -BeLike "*INVALID*"
				$_.CategoryInfo.Category | Should -Be ([System.Management.Automation.ErrorCategory]::ObjectNotFound)
				$_.TargetObject | Should -Be 'INVALID'
				$_.ErrorDetails.RecommendedAction | Should -BeLike "*Verify that the computer exists*"
			}
		}

		It 'Should work well with try-catch blocks' {
			$ErrorCaught = $false

			try {
				Invoke-CCSErrorHandling -ErrorMessage "Test try-catch" -ErrorCategory OperationStopped
			} catch {
				$ErrorCaught = $true
				$_.Exception.Message | Should -BeLike "*Test try-catch*"
			}

			$ErrorCaught | Should -Be $true
		}
	}
}
