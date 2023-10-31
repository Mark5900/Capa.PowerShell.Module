# TODO: Update and add tests

<#
	.SYNOPSIS
		Writes an entry to an INI file.

	.Parameter FilePath
		The path to the INI file.

	.Parameter Section
		The section of the INI file to write to.

	.Parameter Variable
		The variable to write to the INI file.

	.Parameter Value
		The value to write to the INI file.

	.EXAMPLE
		PS C:\> Ini_WriteEntry -FilePath "C:\Temp\test.ini" -Section "Section1" -Variable "Variable1" -Value "Value1"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455666/cs.Ini+WriteEntry
#>
function Ini_WriteEntry {
	param(
		[Parameter(Mandatory = $true)]
		[string]$FilePath,
		[Parameter(Mandatory = $true)]
		[string]$Section,
		[Parameter(Mandatory = $true)]
		[string]$Variable,
		[Parameter(Mandatory = $true)]
		[string]$Value
	)

	$Global:Cs.Ini_WriteEntry($FilePath, $Section, $Variable, $Value)
}
