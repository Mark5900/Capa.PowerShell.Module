<#
	.SYNOPSIS
		Remove a unit by UUID.

	.DESCRIPTION
		Delete an existing unit by UUID in CapaInstaller.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UUID
		The UUID of the unit to delete.

	.EXAMPLE
		PS C:\> Remove-CapaUnitByUUID -CapaSDK $CapaSDK -UUID '12345678-1234-1234-1234-123456789012'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247372/Delete+unit
#>
function Remove-CapaUnitByUUID {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[ValidatePattern('^[{(]?[0-9a-fA-F]{8}[-]?[0-9a-fA-F]{4}[-]?[0-9a-fA-F]{4}[-]?[0-9a-fA-F]{4}[-]?[0-9a-fA-F]{12}[)}]?$')]
		[string]$UUID
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'DeleteUnitByUUID')) {
		throw 'CapaSDK does not contain method DeleteUnitByUUID.'
	}

	if ($PSCmdlet.ShouldProcess($UUID, 'Delete unit by UUID')) {
		$bool = $CapaSDK.DeleteUnitByUUID($UUID)
		return $bool
	}
}
