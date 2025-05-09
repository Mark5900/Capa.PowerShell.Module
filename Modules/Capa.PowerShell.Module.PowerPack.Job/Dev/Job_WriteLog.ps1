# TODO: #81 Update and add tests

<#
    .SYNOPSIS
        This function will write a log entry.

		.DESCRIPTION
				This function will write a log entry.

    .PARAMETER FunctionName
        Name of function to associate with log entry (default blank, Log_Sectionheader will override).

    .PARAMETER Text
        The text to write to the log.

    .EXAMPLE
        PS C:\> Job_WriteLog -FunctionName "Install" -Text "Installing application"

    .EXAMPLE
        PS C:\> Log_SectionHeader -Name "Install"
        PS C:\> Job_WriteLog -Text "Installing application"

    .NOTES
        For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455683/cs.Job+WriteLog
#>
function Job_WriteLog {
	param (
		[Parameter(Mandatory = $true)]
		[string]$Text,
		[Parameter(Mandatory = $false)]
		[string]$FunctionName = ''
	)

	if ($FunctionName -ne '') {
		$Global:Cs.Job_WriteLog($FunctionName, $Text)
	} else {
		$Global:Cs.Job_WriteLog($Text)
	}
}
