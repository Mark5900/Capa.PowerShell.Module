<#
	.SYNOPSIS
		Use to write a line to the log file.

	.DESCRIPTION
		Used to write a  pretty line to the log file indstead of using Write-Host or Write-Output.

	.PARAMETER Text
		The text to write to the log file.

	.PARAMETER ScriptPart
		The part of the script that is writing to the log file.
		Default value is 'Main'.

	.PARAMETER ForegroundColor
		The color of the text.
		Only usable to see in the console.

	.EXAMPLE
		PS C:\> Write-LogLine -Text 'value1'

	.EXAMPLE
		PS C:\> Write-LogLine -Text 'value1' -ScriptPart 'Function1'

	.EXAMPLE
		PS C:\> Write-LogLine -Text 'value1' -ScriptPart 'Function1' -ForegroundColor 'Red'

	.NOTES
		This is a custom function created to have a standard way of starting logging in SDK scripts.
#>
function Write-LogLine {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		[string]$Text,
		[string]$ScriptPart = 'Main',
		[ValidateSet('Black', 'DarkBlue', 'DarkGreen', 'DarkCyan', 'DarkRed', 'DarkMagenta', 'DarkYellow', 'Gray', 'DarkGray', 'Blue', 'Green', 'Cyan', 'Red', 'Magenta', 'Yellow', 'White')]
		$ForegroundColor = (Get-Host).ui.rawui.ForegroundColor
	)

	Write-Host "$(Get-Date -Format HH:mm:ss) : $($ScriptPart) : $Text" -ForegroundColor $ForegroundColor
}
