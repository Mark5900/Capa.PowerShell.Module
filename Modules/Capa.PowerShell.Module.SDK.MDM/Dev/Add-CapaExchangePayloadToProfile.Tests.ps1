BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$script:LastCall = $null
	$script:CapaSDK = [pscustomobject]@{}
	Add-Member -InputObject $script:CapaSDK -MemberType ScriptMethod -Name AddExchangePayloadToProfile -Value {
		param($ProfileID, $AccountName, $DomainandUserName, $Password, $EmailAddress, $ExchangeActiveSyncHost, $UseSSL, $PastDaysofMailtoSync, $AllowMove, $UseOnlyinMail, $UseSMIME, $AllowRecentAddressSyncing, $Syncinterval, $SyncEmail, $SyncCalendar, $SyncContacts, $SyncTasks, $ChangelogComment)
		$script:LastCall = @($ProfileID, $AccountName, $DomainandUserName, $Password, $EmailAddress, $ExchangeActiveSyncHost, $UseSSL, $PastDaysofMailtoSync, $AllowMove, $UseOnlyinMail, $UseSMIME, $AllowRecentAddressSyncing, $Syncinterval, $SyncEmail, $SyncCalendar, $SyncContacts, $SyncTasks, $ChangelogComment)
		return 'OK'
	}
}

Describe 'Add-CapaExchangePayloadToProfile' {
	It 'Calls SDK method with expected values' {
		$Result = Add-CapaExchangePayloadToProfile -CapaSDK $script:CapaSDK -ProfileID 1 -AccountName 'acc' -EmailAddress 'a@b.c' -ExchangeActiveSyncHost 'host' -UseSSL $true -Syncinterval '30 minutes' -Confirm:$false
		$Result | Should -Be 'OK'
		$script:LastCall[0] | Should -Be 1
		$script:LastCall[1] | Should -Be 'acc'
		$script:LastCall[4] | Should -Be 'a@b.c'
	}
}

