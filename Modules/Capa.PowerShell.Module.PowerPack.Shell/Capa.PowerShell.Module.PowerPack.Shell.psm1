function Shell_Execute {
	param(
		[Parameter(Mandatory = $true)]
		[string]$Command,
		[String]$Arguments = '',
		[Bool]$Wait = $true,
		[ValidateSet('Hidden', 'Normal', 'Minimized', 'Maximized')]
		$WindowStyle = 'Hidden',
		[Bool]$MustExist = $false,
		[string]$WorkingDirectory = ''
	)

	$Value = $Global:cs.Shell_Execute($Command, $Arguments, $Wait, $WindowStyle, $MustExist, $WorkingDirectory)

	return $Value
}