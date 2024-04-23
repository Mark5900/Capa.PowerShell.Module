# TODO: Add help for Show-PpMessageBox
function Show-PpMessageBox {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Title,
		[Parameter(Mandatory = $true)]
		[string]$Message,
		[Parameter(Mandatory = $false)]
		[ValidateSet('OK', 'OKCancel', 'YesNo', 'YesNoCancel')]
		[string]$Buttons = 'OK',
		[Parameter(Mandatory = $true)]
		[string]$DefaultButton,
		[Parameter(Mandatory = $false)]
		[ValidateSet('Information', 'Warning', 'Error', 'Question')]
		[string]$Icon = 'Information',
		[Parameter(Mandatory = $false)]
		[int]$TimeoutSeconds = 30,
		[Parameter(Mandatory = $false)]
		[bool]$Async = $false
	)
	return $Global:InputObject.ShowMessageBox($Title, $Message, $Buttons, $DefaultButton, $Icon, $TimeoutSeconds, $Async)
}