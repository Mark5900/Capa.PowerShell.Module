<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246240/Delete+group
	
	.DESCRIPTION
		A detailed description of the Remove-CapaUnitByUUID function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UUID
		A description of the UUID parameter.
	
	.EXAMPLE
				PS C:\> Remove-CapaUnitByUUID -CapaSDK $value1 -UUID 'Value2'
	
	.NOTES
		Additional information about the function.
#>
function Remove-CapaUnitByUUID
{
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UUID
	)
	
	$bool = $CapaSDK.DeleteUnitByUUID($UUID)
	
	Return $bool
}
