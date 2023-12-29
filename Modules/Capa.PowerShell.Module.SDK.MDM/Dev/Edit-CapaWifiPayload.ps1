# TODO: #144 Update and add tests

<#
	.SYNOPSIS
		Edit an existing WiFi payload.

	.DESCRIPTION
		Edit an existing WiFi payload in the specified profile.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER ProfileID
		The ID of the profile you wish to edit.

	.PARAMETER CurrentNetworkName
		The network name (SSID) of the wifi payload you wish to edit.

	.PARAMETER NetworkName
		The name of the WiFi network the devices should join. This is a mandatory parameter.

	.PARAMETER HiddenNetwork
		Enable if target network is not open or broadcasting.

	.PARAMETER AutoJoin
		Automatically join this wireless network.

	.PARAMETER SecurityType
		The type of WiFi security used on the WiFi network. Options are: None, WEP, WPA and Any.

	.PARAMETER Password
		The password used to authenticate against the WiFi network. This setting is mandatory if securityType is WEP, WPA or Any.

	.PARAMETER ProxyType
		Configures proxy settings to be used with this network. Options are: Automatic, Manual, None.

	.PARAMETER ProxyServer
		The proxy server's network address. Mandatory if proxyType is Manual.

	.PARAMETER ProxyPort
		The proxy server's port. Mandatory if proxyType is Manual.

	.PARAMETER ProxyAuthentication
		The username used to authenticate to the proxy server. Mandatory if proxyType is Manual.

	.PARAMETER ProxyPassword
		The password used to authenticate to the proxy server. Mandatory if proxyType is Manual.

	.PARAMETER ProxyServerConfigURL
		AThe URL of the PAC file that defines the proxy configuration. Mandatory if proxyType is Automatic.

	.PARAMETER ChangelogComment
		Comment you wish to be added to the changelog.

	.EXAMPLE
				PS C:\> Edit-CapaWifiPayload @(
					CapaSDK = $CapaSDK
					ProfileID = 1
					CurrentNetworkName = "Test"
					NetworkName = "Test"
					HiddenNetwork = $false
					AutoJoin = $true
					SecurityType = "WEP"
					Password = "1234567890"
					ProxyType = "None"
					ProxyServer = ""
					ProxyPort = ""
					ProxyAuthentication = ""
					ProxyPassword = ""
					ProxyServerConfigURL = ""
					ChangelogComment = "Editing WiFi Payload"
				)

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246604/Edit+WiFi+Payload
#>
function Edit-CapaWifiPayload {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$ProfileID,
		[Parameter(Mandatory = $true)]
		[string]$CurrentNetworkName,
		[Parameter(Mandatory = $true)]
		[string]$NetworkName,
		[ValidateSet('False', 'True')]
		[bool]$HiddenNetwork = $false,
		[ValidateSet('True', 'False')]
		[bool]$AutoJoin = $true,
		[Parameter(Mandatory = $true)]
		[ValidateSet('None', 'WEP', 'WPA', 'Any')]
		[string]$SecurityType,
		[string]$Password = '',
		[Parameter(Mandatory = $true)]
		[ValidateSet('Automatic', 'Manual', 'None')]
		[string]$ProxyType,
		[string]$ProxyServer = '',
		[string]$ProxyPort = '',
		[string]$ProxyAuthentication = '',
		[string]$ProxyPassword = '',
		[string]$ProxyServerConfigURL = '',
		[string]$ChangelogComment = ''
	)

	if ($Password -eq '' -and $SecurityType -ne 'None') {
		Write-Error "Password cannot be NULL when choosing SecurityType: $SecurityType"
	} elseif ($ProxyType -eq 'Manual' -and $ProxyServer -eq '') {
		Write-Error "ProxyServer cannot be NULL when choosing ProxyType: $ProxyType"
	} elseif ($ProxyType -eq 'Manual' -and $ProxyPort -eq '') {
		Write-Error "ProxyPort cannot be NULL when choosing ProxyType: $ProxyType"
	} elseif ($ProxyType -eq 'Manual' -and $ProxyAuthentication -eq '') {
		Write-Error "ProxyAuthentication cannot be NULL when choosing ProxyType: $ProxyType"
	} elseif ($ProxyType -eq 'Manual' -and $ProxyPassword -eq '') {
		Write-Error "ProxyPassword cannot be NULL when choosing ProxyType: $ProxyType"
	} elseif ($ProxyType -eq 'Automatic' -and $ProxyServerConfigURL -eq '') {
		Write-Error "ProxyServerConfigURL cannot be NULL when choosing ProxyType: $ProxyType"
	} Else {
		$value = $CapaSDK.EditWifiPayload($ProfileID, $CurrentNetworkName, $NetworkName, $HiddenNetwork, $AutoJoin, $SecurityType, $Password, $ProxyType, $ProxyType, $ProxyServer, $ProxyPort, $ProxyAuthentication, $ProxyPassword, $ProxyServerConfigURL, $ChangelogComment)
		return $value
	}
}
