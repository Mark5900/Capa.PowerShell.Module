function Log_SectionHeader {
	param(
		[Parameter(Mandatory = $true)]
		[string]$Name,
		[string]$FrameCharacter = 'o'
	)
	
	$Global:Cs.Log_SectionHeader($Name, $FrameCharacter)
}