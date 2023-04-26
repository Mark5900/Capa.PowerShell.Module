<#
	.SYNOPSIS
		Reads an entry from an INI file.

	.Parameter FilePath
		The path to the INI file.

	.Parameter Section
		The section of the INI file to read from.

	.Parameter Variable
		The variable to read from the INI file.

	.EXAMPLE
		PS C:\> Ini_ReadEntry -FilePath "C:\Temp\test.ini" -Section "Section1" -Variable "Variable1"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455649/cs.Ini+ReadEntry
#>
function Ini_ReadEntry {
	param(
		[Parameter(Mandatory = $true)]
		[string]$FilePath,
		[Parameter(Mandatory = $true)]
		[string]$Section,
		[Parameter(Mandatory = $true)]
		[string]$Variable
	)

	$Value = $Global:Cs.Ini_ReadEntry($FilePath, $Section, $Variable)

	return $Value
}
