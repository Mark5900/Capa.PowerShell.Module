<#
	.SYNOPSIS
		Creates a section header in the logfile.

	.PARAMETER Name
		The name of the section.

	.PARAMETER FrameCharacter
		The character to use for the frame, default is 'o'.

	.EXAMPLE
		PS C:\> Log_SectionHeader -Name "Install"

	.EXAMPLE
		PS C:\> Log_SectionHeader -Name "Install" -FrameCharacter "="

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455700/cs.Log+SectionHeader
#>
function Log_SectionHeader {
	param(
		[Parameter(Mandatory = $true)]
		[string]$Name,
		[string]$FrameCharacter = 'o'
	)
	
	$Global:Cs.Log_SectionHeader($Name, $FrameCharacter)
}