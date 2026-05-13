BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$script:LastCall = $null
	$script:CapaSDK = [pscustomobject]@{}
	Add-Member -InputObject $script:CapaSDK -MemberType ScriptMethod -Name EditExchangePayload -Value {
		param($ProfileID, $CurrentAccountName, $AccountName, $DomainandUserName, $Password, $EmailAddress, $ExchangeActiveSyncHost, $UseSSL, $PastDaysofMailtoSync, $AllowMove, $UseOnlyinMail, $UseSMIME, $AllowRecentAddressSyncing, $Syncinterval, $SyncEmail, $SyncContacts, $SyncTasks, $ChangelogComment)
		$script:LastCall = @($ProfileID, $CurrentAccountName, $AccountName, $DomainandUserName, $Password, $EmailAddress, $ExchangeActiveSyncHost, $UseSSL, $PastDaysofMailtoSync, $AllowMove, $UseOnlyinMail, $UseSMIME, $AllowRecentAddressSyncing, $Syncinterval, $SyncEmail, $SyncContacts, $SyncTasks, $ChangelogComment)
		return 'OK'
	}
}

Describe 'Edit-CapaExchangePayload' {
	It 'Calls SDK method with expected values' {
		$Result = Edit-CapaExchangePayload -CapaSDK $script:CapaSDK -ProfileID 1 -CurrentAccountName 'Old' -AccountName 'New' -DomainandUserName 'dom\\usr' -EmailAddress 'a@b.c' -ExchangeActiveSyncHost 'host' -UseSSL $true -Syncinterval '30 minutes' -Confirm:$false
		$Result | Should -Be 'OK'
		$script:LastCall[1] | Should -Be 'Old'
		$script:LastCall[2] | Should -Be 'New'
	}
}

