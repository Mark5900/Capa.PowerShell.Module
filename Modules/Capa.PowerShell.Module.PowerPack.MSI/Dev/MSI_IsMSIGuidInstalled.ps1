# TODO: #87 Update and add tests

<#
	.SYNOPSIS
		Checks if an GUID is installed.

	.DESCRIPTION
		This function checks if the specified GUID is installed on the system.

	.PARAMETER MsiGuid
		TMSI Productcode to check installation status of.

	.EXAMPLE
		PS C:\> MSI_IsMSIGuidInstalled -MsiGuid "{AC76BA86-1033-FF00-7760-BC15014EA700}"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455785/cs.MSI+IsMSIGuidInstalled
#>
function MSI_IsMSIGuidInstalled {
	param (
		[Parameter(Mandatory = $true)]
		[string]$MsiGuid
	)

	$Value = $Global:Cs.MSI_IsMSIGuidInstalled($MsiGuid)

	return $Value
}
