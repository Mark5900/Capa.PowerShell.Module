# TODO: #286 Add help for Show-PpMessageBox
<#
	.SYNOPSIS
		Show a message box.

	.DESCRIPTION
		Show a message box.

	.PARAMETER Title
		The title of the message box.

	.PARAMETER Message
		The message to display in the message box.

	.PARAMETER Buttons
		The buttons to display in the message box. Can be 'OK', 'OKCancel', 'YesNo', or 'YesNoCancel'.

	.PARAMETER DefaultButton
		The default button to select. Can be 'OK', 'Cancel', 'Yes', or 'No'.

	.PARAMETER Icon
		The icon to display in the message box. Can be 'Information', 'Warning', 'Error', or 'Question'.

	.PARAMETER TimeoutSeconds
		The timeout in seconds before the message box closes automatically. Default is 30 seconds.

	.PARAMETER Async
		Indicates if the message box should be shown asynchronously. Default is $false.

	.EXAMPLE
		Show-PpMessageBox -Title "Test" -Message "This is a test message." -Buttons "OK" -DefaultButton "OK" -Icon "Information" -TimeoutSeconds 30 -Async $false
#>
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