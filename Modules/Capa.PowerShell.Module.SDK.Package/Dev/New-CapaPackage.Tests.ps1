BeforeAll {
	# Import file
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

    $Folders = @(
        'Capa.PowerShell.Module.SDK.Authentication',
        'Capa.PowerShell.Module.SDK.Package'
    )
    foreach ($Folder in $Folders) {
        $Items = Get-ChildItem -Path "$RootPath\$Folder\Dev\" -Filter '*.ps1' | Where-Object { $_.Name -notlike '*Tests.ps1' }
        foreach ($Item in $Items) {
            Import-Module $Item.FullName -Force -ErrorAction Stop
        }
    }

	$CapaSDK = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 1
	$PackageRoot = Get-ItemPropertyValue -Path 'registry::HKEY_LOCAL_MACHINE\SOFTWARE\CapaSystems\CapaInstaller' -Name 'Packageroot'
	$ComputerJobsPath = Join-Path $PackageRoot.Replace('Prod', $env:COMPUTERNAME) 'ComputerJobs'
	$script:SkipIntegration = $false
	$script:SkipReason = ''

	$TestSettings = @{
		CapaSDK        = $CapaSDK
		PackageName    = 'Test1'
		PackageVersion = 'v1.0'
		UnitType       = 'Computer'
		DisplayName    = 'Test Package'
	}
}
Describe 'Create a new package' {
	It 'Does the function work' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }

		try {
			$Status = New-CapaPackage @TestSettings
		} catch {
			$script:SkipIntegration = $true
			$script:SkipReason = $_.Exception.Message
			Set-ItResult -Skipped -Because $script:SkipReason
			return
		}
		$Status | Should -Be $true
	}
	It 'Does the package exist' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }

		$Package = Exist-CapaPackage -CapaSDK $CapaSDK -Name $TestSettings.PackageName -Version $TestSettings.PackageVersion -Type $TestSettings.UnitType
		$Package | Should -Be $true
	}
	It 'Creates Scripts and Kit folders for the package' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }

		$PackagePath = Join-Path (Join-Path $ComputerJobsPath $TestSettings.PackageName) $TestSettings.PackageVersion
		$ScriptsPath = Join-Path $PackagePath 'Scripts'
		$KitPath = Join-Path $PackagePath 'Kit'

		$ScriptsPath | Should -Exist
		$KitPath | Should -Exist
	}
}
AfterAll {
	if ($script:SkipIntegration) { return }

	$PackageSplatting = @{
		CapaSDK        = $CapaSDK
		PackageName    = $TestSettings.PackageName
		PackageVersion = $TestSettings.PackageVersion
		PackageType    = $TestSettings.UnitType
	}
	Remove-CapaPackage @PackageSplatting
}