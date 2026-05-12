BeforeAll {
	# Import file
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$script:SkipIntegration = $false
	$script:SkipReason = ''
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

	$FolderStructure = 'Test1\Test2'
}
Describe 'Test with a new package' {
	It 'Should create a new package' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }

		$PackageSpllatting = @{
			CapaSDK        = $CapaSDK
			PackageName    = 'Test1'
			PackageVersion = 'v1.0'
			UnitType       = 'Computer'
			DisplayName    = 'Test1 v1.0'
		}
		try {
			$bStatus = New-CapaPackage @PackageSpllatting
		} catch {
			$script:SkipIntegration = $true
			$script:SkipReason = $_.Exception.Message
			Set-ItResult -Skipped -Because $script:SkipReason
			return
		}
		$bStatus | Should -Be $true
	}
	It 'Should set the folder structure of the package' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }

		$ChangelogComment = 'This is a changelog'
		$bStatus = Set-CapaPackageFolder -CapaSDK $CapaSDK -PackageName 'Test1' -PackageVersion 'v1.0' -PackageType 'Computer' -PackageFolder $FolderStructure -ChangelogComment $ChangelogComment
		$bStatus | Should -Be $true
	}
	It 'The package should be in the folder' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }

		$PackageFolder = Get-CapaPackageFolder -CapaSDK $CapaSDK -PackageType 'Computer' -PackageName 'Test1' -PackageVersion 'v1.0'
		$PackageFolder | Should -BeLike "$FolderStructure*"
	}
}
Describe 'Test with a package allready in the folder' {
	It 'Move to same folder using legacy parameter aliases' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }

		$ChangelogText = 'This is a changelog'
		$bStatus = Set-CapaPackageFolder -CapaSDK $CapaSDK -PackageName 'Test1' -PackageVersion 'v1.0' -PackageType 'Computer' -FolderStructure $FolderStructure -ChangelogText $ChangelogText
		$bStatus | Should -Be $true
	}
	It 'The package should be in the folder' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }

		$PackageFolder = Get-CapaPackageFolder -CapaSDK $CapaSDK -PackageType 'Computer' -PackageName 'Test1' -PackageVersion 'v1.0'
		$PackageFolder | Should -BeLike "$FolderStructure*"
	}
}
AfterAll {
	if ($script:SkipIntegration) { return }

	Remove-CapaPackage -CapaSDK $CapaSDK -PackageName 'Test1' -PackageVersion 'v1.0' -PackageType 'Computer' -Force True
}