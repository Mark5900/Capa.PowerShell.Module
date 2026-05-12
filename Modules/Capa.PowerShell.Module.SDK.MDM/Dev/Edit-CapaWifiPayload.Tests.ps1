BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$script:LastCall = $null
	$script:CapaSDK = [pscustomobject]@{}
	Add-Member -InputObject $script:CapaSDK -MemberType ScriptMethod -Name EditWifiPayload -Value {
		param($ProfileID, $CurrentNetworkName, $NetworkName, $HiddenNetwork, $AutoJoin, $SecurityType, $Password, $ProxyType, $ProxyServer, $ProxyPort, $ProxyAuthentication, $ProxyPassword, $ProxyServerConfigURL, $ChangelogComment)
		$script:LastCall = @($ProfileID, $CurrentNetworkName, $NetworkName, $HiddenNetwork, $AutoJoin, $SecurityType, $Password, $ProxyType, $ProxyServer, $ProxyPort, $ProxyAuthentication, $ProxyPassword, $ProxyServerConfigURL, $ChangelogComment)
		return 'OK'
	}
}

Describe 'Edit-CapaWifiPayload' {
	It 'Calls SDK with expected values for valid WPA payload' {
		$Result = Edit-CapaWifiPayload -CapaSDK $script:CapaSDK -ProfileID 1 -CurrentNetworkName 'OldWiFi' -NetworkName 'NewWiFi' -SecurityType 'WPA' -Password 'p@ss' -ProxyType 'None' -Confirm:$false
		$Result | Should -Be 'OK'
		$script:LastCall[1] | Should -Be 'OldWiFi'
		$script:LastCall[2] | Should -Be 'NewWiFi'
	}

	It 'Throws when password is missing for secured network' {
		{ Edit-CapaWifiPayload -CapaSDK $script:CapaSDK -ProfileID 1 -CurrentNetworkName 'OldWiFi' -NetworkName 'NewWiFi' -SecurityType 'WPA' -ProxyType 'None' -ErrorAction Stop -Confirm:$false } | Should -Throw
	}
}

