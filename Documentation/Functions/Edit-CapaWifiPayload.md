# Edit-CapaWifiPayload
Module: Capa.PowerShell.Module.SDK.MDM

Edit an existing WiFi payload.

## Syntax

```powershell
Edit-CapaWifiPayload
	-CapaSDK <Object>
	-ProfileID <Int32>
	-CurrentNetworkName <String>
	-NetworkName <String>
	-HiddenNetwork <Boolean>
	-AutoJoin <Boolean>
	-SecurityType <String>
	-Password <String>
	-ProxyType <String>
	-ProxyServer <String>
	-ProxyPort <String>
	-ProxyAuthentication <String>
	-ProxyPassword <String>
	-ProxyServerConfigURL <String>
	-ChangelogComment <String>
```

## Description

Edit an existing WiFi payload in the specified profile.

## Examples

### Example 1
```powershell
Edit-CapaWifiPayload @(
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
```
    

## Parameters

-**CapaSDK**

The CapaSDK object.
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ProfileID**

The ID of the profile you wish to edit.
| Name | Value |
| ---- | ---- |
| Type: | Int32 |
| Position: | 2 | 
| Default value: | 0 | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**CurrentNetworkName**

The network name (SSID) of the wifi payload you wish to edit.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**NetworkName**

The name of the WiFi network the devices should join. This is a mandatory parameter.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 4 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**HiddenNetwork**

Enable if target network is not open or broadcasting.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 5 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**AutoJoin**

Automatically join this wireless network.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 6 | 
| Default value: | True | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**SecurityType**

The type of WiFi security used on the WiFi network. Options are: None, WEP, WPA and Any.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 7 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Password**

The password used to authenticate against the WiFi network. This setting is mandatory if securityType is WEP, WPA or Any.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 8 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ProxyType**

Configures proxy settings to be used with this network. Options are: Automatic, Manual, None.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 9 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ProxyServer**

The proxy server's network address. Mandatory if proxyType is Manual.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 10 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ProxyPort**

The proxy server's port. Mandatory if proxyType is Manual.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 11 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ProxyAuthentication**

The username used to authenticate to the proxy server. Mandatory if proxyType is Manual.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 12 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ProxyPassword**

The password used to authenticate to the proxy server. Mandatory if proxyType is Manual.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 13 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ProxyServerConfigURL**

AThe URL of the PAC file that defines the proxy configuration. Mandatory if proxyType is Automatic.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 14 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ChangelogComment**

Comment you wish to be added to the changelog.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 15 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246604/Edit+WiFi+Payload
