function Get-CCSEncryptedPassword {
	<#
	.SYNOPSIS
		Encrypts a SecureString using the InstallationScreen.exe utility for CCS Webservice use.

	.DESCRIPTION
		Takes a SecureString and uses the InstallationScreen.exe utility to encrypt it. Returns the encrypted string, suitable for use with CCS Webservice operations. Includes robust error handling, parameter validation, and advanced function features.

	.PARAMETER SecureString
		The SecureString to encrypt. Must not be empty.

	.EXAMPLE
		$secure = ConvertTo-SecureString "Admin1234" -AsPlainText -Force
		Get-CCSEncryptedPassword -SecureString $secure

	.OUTPUTS
		System.String. The encrypted string.

	.NOTES
		Advanced function with CmdletBinding, error handling, and pipeline support.
	#>
	[CmdletBinding(SupportsShouldProcess = $false, ConfirmImpact = 'None')]
	[OutputType([string])]
	param (
		[Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Enter the SecureString to encrypt')]
		[ValidateNotNull()]
		[Alias('Password','Secret')]
		[System.Security.SecureString]$SecureString
	)

	begin {
		$FunctionName = $PSCmdlet.MyInvocation.MyCommand.Name
		$ExePath = Join-Path $PSScriptRoot 'Dependencies' 'InstallationScreen.exe'
		$OutputPath = Join-Path $env:TEMP 'InstallationScreen.log'
		Write-Verbose "[$FunctionName] Using InstallationScreen.exe at: $ExePath"
	}

	process {
		# Convert SecureString to plain text
		try {
			$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureString)
			$Plain = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($BSTR)
		} catch {
			$msg = "[$FunctionName] Failed to convert SecureString to plain text: $_"
			Write-Error $msg
			throw $msg
		} finally {
			if ($BSTR) { [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR) }
		}
		Write-Verbose "[$FunctionName] Encrypting string (length: $($Plain.Length))"
		if ([string]::IsNullOrWhiteSpace($Plain)) {
			$msg = "Input SecureString is empty or whitespace."
			Write-Error $msg
			throw $msg
		}
		if (-not (Test-Path $ExePath)) {
			$msg = "InstallationScreen.exe not found at $ExePath"
			Write-Error $msg
			throw $msg
		}
		if (Test-Path $OutputPath) {
			Remove-Item $OutputPath -Force -ErrorAction SilentlyContinue
		}
		$Arguments = "power $Plain"
		try {
			Write-Debug "[$FunctionName] Running: $ExePath $Arguments"
			$proc = Start-Process -FilePath $ExePath -ArgumentList $Arguments -Wait -RedirectStandardOutput $OutputPath -NoNewWindow -PassThru
			if ($proc.ExitCode -ne 0) {
				$msg = "InstallationScreen.exe exited with code $($proc.ExitCode)"
				Write-Error $msg
				throw $msg
			}
			if (-not (Test-Path $OutputPath)) {
				$msg = "Output file not created: $OutputPath"
				Write-Error $msg
				throw $msg
			}
			$Output = Get-Content $OutputPath -Raw
			$Encrypted = $Output.Trim() -replace '\r?\n', ''
			if ([string]::IsNullOrWhiteSpace($Encrypted)) {
				$msg = "No encrypted output returned from InstallationScreen.exe."
				Write-Error $msg
				throw $msg
			}
			Write-Verbose "[$FunctionName] Encrypted string: $Encrypted"
			Write-Output $Encrypted
		} catch {
			$msg = "[$FunctionName] Failed to encrypt string: $_"
			Write-Error $msg
			throw $msg
		} finally {
			if (Test-Path $OutputPath) {
				Remove-Item $OutputPath -Force -ErrorAction SilentlyContinue
			}
		}
	}
}