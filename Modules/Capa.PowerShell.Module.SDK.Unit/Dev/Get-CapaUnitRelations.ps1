# TODO: #220 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247554/Get+Unit+Relations

	.DESCRIPTION
		A detailed description of the Get-CapaUnitRelations function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.EXAMPLE
		PS C:\> Get-CapaUnitRelations -CapaSDK $value1 -UnitName $value2 -UnitType $value3

	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitRelations {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
		$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		$UnitType
	)

	process {
		# Retrieve unit relations using the Capa SDK
		$CapaSDK.GetUnitRelations($UnitName, $UnitType) | ForEach-Object {
			# Split the relation string into its components
			$aItem = $_.Split(';')
			# Create and return a custom object with the relation details
			[pscustomobject]@{
				RelationType = $aItem[0];
				Name         = $aItem[1];
				Created      = $aItem[2];
				LastExecuted = $aItem[3];
				Status       = $aItem[4];
				Description  = $aItem[5];
				GUID         = $aItem[7];
				ID           = $aItem[8];
				TypeName     = $aItem[9];
				UUID         = $aItem[10];
				IsMobile     = $aItem[11];
				Location     = $aItem[12];
				CmpId        = $aItem[13];
				BuId         = $aItem[14]
			}
		}
	}
}