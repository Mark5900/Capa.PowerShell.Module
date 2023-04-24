<#
	.SYNOPSIS
		Add a new WiFi payload to a profile.
	
	.DESCRIPTION
		Add a new WiFi payload to a profile.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER ProfileID
		The ID of the profile to add the payload to.
	
	.PARAMETER NetworkName
		The name of the WiFi network the devices should join. This is a mandatory parameter.
	
	.PARAMETER HiddenNetwork
		Enable if target network is not open or broadcasting.
	
	.PARAMETER AutoJoin
		Automatically join this wireless network.
	
	.PARAMETER SecurityType
		The type of WiFi security used on the WiFi network. Options are: None, WEP, WPA and Any.
	
	.PARAMETER Password
		The password used to authenticate against the WiFi network. This setting is mandatory if SecurityType is WEP, WPA or Any.
	
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
		The URL of the PAC file that defines the proxy configuration. Mandatory if proxyType is Automatic.
	
	.PARAMETER ChangelogComment
		The comment you wish to be added to the changelog.
	
	.EXAMPLE
		PS C:\> Add-CapaWifiPayloadToProfile @(
			CapaSDK = $CapaSDK
			ProfileID = 1
			NetworkName = 'MyWiFiNetwork'
			HiddenNetwork = $false
			AutoJoin = $true
			SecurityType = 'WPA'
			Password = '12345678'
			ProxyType = 'None'
			ProxyServer = ''
			ProxyPort = ''
			ProxyAuthentication = ''
			ProxyPassword = ''
			ProxyServerConfigURL = ''
			ChangelogComment = 'Adding WiFi payload to profile'
		)
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246510/Add+WiFi+Payload+to+Profile
#>
function Add-CapaWifiPayloadToProfile {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$ProfileID,
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
		$value = $CapaSDK.AddWifiPayloadToProfile($ProfileID, $NetworkName, $HiddenNetwork, $AutoJoin, $SecurityType, $Password, $ProxyType, $ProxyType, $ProxyServer, $ProxyPort, $ProxyAuthentication, $ProxyPassword, $ProxyServerConfigURL, $ChangelogComment)
		return $value
	}
}
