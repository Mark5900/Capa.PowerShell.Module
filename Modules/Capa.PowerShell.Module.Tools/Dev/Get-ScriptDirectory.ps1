<#
	.SYNOPSIS
		Get the directory of the current script.

	.DESCRIPTION
		Get the directory of the current script. It is better than $PSScriptRoot because it works also when running the script line by line in the console.
#>
Function Get-ScriptDirectory {
	# Necessary so different PowerShell editors and module contexts can be used
	if ($MyInvocation.ScriptName) {
		# If called from a script, use the script's path
		return Split-Path -Path $MyInvocation.ScriptName
	} elseif ($Host.Name -eq 'Visual Studio Code Host') {
		# If called from VS Code
		return Split-Path $psEditor.GetEditorContext().CurrentFile.Path
	} elseif ($Host.Name -eq 'Windows PowerShell ISE Host') {
		# If called from PowerShell ISE
		return Split-Path -Path $psISE.CurrentFile.FullPath
	} else {
		# Default to $PSScriptRoot (module or other contexts)
		return $PSScriptRoot
	}
}