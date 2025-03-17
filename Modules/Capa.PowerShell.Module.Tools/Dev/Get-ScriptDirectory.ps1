<#
	.SYNOPSIS
		Get the directory of the current script.

	.DESCRIPTION
		Get the directory of the current script. It is better than $PSScriptRoot because it works also when running the script line by line in the console.
#>
Function Get-ScriptDirectory {
	#neccessary so different powershell editors can be used
	Switch ($Host.name) {
		'Visual Studio Code Host' { Split-Path $psEditor.GetEditorContext().CurrentFile.Path }
		'Windows PowerShell ISE Host' { Split-Path -Path $psISE.CurrentFile.FullPath }
		'ConsoleHost' { $PSScriptRoot }
	}
}