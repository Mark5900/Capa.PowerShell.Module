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