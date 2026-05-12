BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$script:LastCall = $null
	$script:CapaSDK = [pscustomobject]@{}
	Add-Member -InputObject $script:CapaSDK -MemberType ScriptMethod -Name AddWifiPayloadToProfile -Value {
		param($ProfileID, $NetworkName, $HiddenNetwork, $AutoJoin, $SecurityType, $Password, $ProxyType, $ProxyServer, $ProxyPort, $ProxyAuthentication, $ProxyPassword, $ProxyServerConfigURL, $ChangelogComment)
		$script:LastCall = @($ProfileID, $NetworkName, $HiddenNetwork, $AutoJoin, $SecurityType, $Password, $ProxyType, $ProxyServer, $ProxyPort, $ProxyAuthentication, $ProxyPassword, $ProxyServerConfigURL, $ChangelogComment)
		return 'OK'
	}
}

Describe 'Add-CapaWifiPayloadToProfile' {
	It 'Calls SDK with expected values for a valid WPA payload' {
		$Result = Add-CapaWifiPayloadToProfile -CapaSDK $script:CapaSDK -ProfileID 1 -NetworkName 'CorpWiFi' -SecurityType 'WPA' -Password 'p@ss' -ProxyType 'None' -Confirm:$false
		$Result | Should -Be 'OK'
		$script:LastCall[1] | Should -Be 'CorpWiFi'
		$script:LastCall[6] | Should -Be 'None'
	}

	It 'Throws when password is missing for secured network' {
		{ Add-CapaWifiPayloadToProfile -CapaSDK $script:CapaSDK -ProfileID 1 -NetworkName 'CorpWiFi' -SecurityType 'WPA' -ProxyType 'None' -ErrorAction Stop -Confirm:$false } | Should -Throw
	}
}

