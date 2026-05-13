<#
	.SYNOPSIS
		Remove a unit from reinstall.

	.DESCRIPTION
		Remove an existing computer from reinstall in CapaInstaller.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER ComputerName
		The name of the computer.

	.EXAMPLE
		PS C:\> Remove-CapaUnitFromReinstall -CapaSDK $CapaSDK -ComputerName 'PC001'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247680/Remove+unit+from+reinstall
#>
function Remove-CapaUnitFromReinstall {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$ComputerName
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'RemoveUnitFromReinstall')) {
		throw 'CapaSDK does not contain method RemoveUnitFromReinstall.'
	}

	if ($PSCmdlet.ShouldProcess($ComputerName, 'Remove unit from reinstall')) {
		$value = $CapaSDK.RemoveUnitFromReinstall($ComputerName)
		return $value
	}
}
