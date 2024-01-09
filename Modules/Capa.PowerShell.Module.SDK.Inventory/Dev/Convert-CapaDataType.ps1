# TODO: #123 Update and add tests

<#
	.SYNOPSIS
		A function to convert Capa data types.

	.DESCRIPTION
		A function to convert Capa data types to a more readable format.

	.PARAMETER Datatype
		The data type to convert.

	.EXAMPLE
		PS C:\> Convert-CapaDataType -Datatype 1

	.NOTES
		A custom function to convert Capa data types to a more readable format.
#>
function Convert-CapaDataType {
	param
	(
		$Datatype
	)

	switch ($DataType) {
		1 { $Datatype = 'String' }
		2 { $Datatype = 'Time' }
		3 { $Datatype = 'Integer' }
		'I' { $Datatype = 'Integer' }
		'T' { $Datatype = 'Time' }
		'S' { $Datatype = 'String' }
		'N' { $Datatype = 'Text' }
		Default { $Datatype = $Datatype }
	}

	return $Datatype
}
