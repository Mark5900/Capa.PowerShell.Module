# TODO: #403 Create tests for Shell_ExecuteWithTimeout

<#
	.SYNOPSIS
		Executes a command line application with a timeout.

	.DESCRIPTION
		This function executes a command line application with the specified arguments and options.
		It will wait for the specified timeout before returning.

	.PARAMETER Command
		The command to execute.

	.PARAMETER Arguments
		The arguments to pass to the command.

	.PARAMETER MustExist
		Indicates if the command must exist, default is $false.
		If set to $true you need to specify the full path to the command.

	.PARAMETER Timeout
		The timeout in seconds.

	.EXAMPLE
		Shell_ExecuteWithTimeout -Command "msiexec" -Arguments "/i C:\Temp\MyInstaller.msi" -Timeout 60
#>
function Shell_ExecuteWithTimeout {
	param (
		[Parameter(Mandatory = $true)]
		[string]$Command,
		[Parameter(Mandatory = $false)]
		[string]$Arguments,
		[Parameter(Mandatory = $false)]
		[bool]$MustExist = $false,
		[Parameter(Mandatory = $false)]
		[int]$Timeout = 30
	)

	return $Global:cs.Shell_ExecuteWithTimeout($Command, $Arguments, $MustExist, $Timeout)
}