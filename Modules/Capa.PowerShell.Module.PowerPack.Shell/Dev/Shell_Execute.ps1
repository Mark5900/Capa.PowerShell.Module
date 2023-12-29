# TODO: #102 Update and add tests

<#
	.SYNOPSIS
		Executes a command line application.

	.PARAMETER Command
		The command to execute.

	.PARAMETER Arguments
		The arguments to pass to the command.

	.PARAMETER Wait
		Wait for the command to finish before returning.

	.PARAMETER WindowStyle
		The window style to use when executing the command, default is 'Hidden'.
		Optional values are 'Hidden', 'Normal', 'Minimized', 'Maximized'.

	.PARAMETER MustExist
		Indicates if the command must exist, default is $false.
		If set to $true you need to specify the full path to the command.

	.PARAMETER WorkingDirectory
		The working directory for the command, default is empty.
#>
function Shell_Execute {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Command,
        [String]$Arguments = '',
        [Bool]$Wait = $true,
        [ValidateSet('Hidden', 'Normal', 'Minimized', 'Maximized')]
        $WindowStyle = 'Hidden',
        [Bool]$MustExist = $false,
        [string]$WorkingDirectory = ''
    )

    switch ($WindowStyle) {
        'Hidden' {
            $WindowStyleInt = 0
        }
        'Normal' {
            $WindowStyleInt = 1
        }
        'Minimized' {
            $WindowStyleInt = 2
        }
        'Maximized' {
            $WindowStyleInt = 3
        }
    }

    $Value = $Global:cs.Shell_Execute($Command, $Arguments, $Wait, $WindowStyleInt, $MustExist, $WorkingDirectory)

    return $Value
}