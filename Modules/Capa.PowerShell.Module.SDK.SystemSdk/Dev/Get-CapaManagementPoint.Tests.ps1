BeforeAll {
	. $PSScriptRoot\Get-CapaManagementPoint.ps1
}

Describe 'Get-CapaManagementPoint' {
	It 'Calls GetManagementPoints when CmpId is not provided' {
		$script:getAllCalled = $false
		$script:getOneCalledWith = $null
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod GetManagementPoints {
			$script:getAllCalled = $true
			@('1;MP1;Desc;D:;guid;C:\\CMP;srv;share;parent')
		}
		$CapaSDK | Add-Member ScriptMethod GetManagementPoint {
			param($CmpId)
			$script:getOneCalledWith = $CmpId
			@('2;MP2;Desc2;E:;guid2;C:\\CMP2;srv2;share2;parent2')
		}

		$result = Get-CapaManagementPoint -CapaSDK $CapaSDK

		$result | Should -HaveCount 1
		$script:getAllCalled | Should -Be $true
		$script:getOneCalledWith | Should -BeNullOrEmpty
	}

	It 'Calls GetManagementPoint when CmpId is provided' {
		$script:getOneCalledWith = $null
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod GetManagementPoints {
			@()
		}
		$CapaSDK | Add-Member ScriptMethod GetManagementPoint {
			param($CmpId)
			$script:getOneCalledWith = $CmpId
			@('2;MP2;Desc2;E:;guid2;C:\\CMP2;srv2;share2;parent2')
		}

		$result = Get-CapaManagementPoint -CapaSDK $CapaSDK -CmpId 2

		$result | Should -HaveCount 1
		$script:getOneCalledWith | Should -Be 2
	}
}
