# Edit-CapaWifiPayload

Module: Capa.PowerShell.Module.SDK.MDM

## SYNOPSIS
Edit an existing WiFi payload.

## SYNTAX

```
Edit-CapaWifiPayload [-CapaSDK] <Object> [-ProfileID] <Int32> [-CurrentNetworkName] <String>
 [-NetworkName] <String> [[-HiddenNetwork] <Boolean>] [[-AutoJoin] <Boolean>] [-SecurityType] <String>
 [[-Password] <String>] [-ProxyType] <String> [[-ProxyServer] <String>] [[-ProxyPort] <String>]
 [[-ProxyAuthentication] <String>] [[-ProxyPassword] <String>] [[-ProxyServerConfigURL] <String>]
 [[-ChangelogComment] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Edit an existing WiFi payload in the specified profile.

## EXAMPLES

### EXAMPLE 1
```
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

## PARAMETERS

### -AutoJoin
Automatically join this wireless network.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -CapaSDK
The CapaSDK object.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ChangelogComment
Comment you wish to be added to the changelog.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CurrentNetworkName
The network name (SSID) of the wifi payload you wish to edit.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HiddenNetwork
Enable if target network is not open or broadcasting.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -NetworkName
The name of the WiFi network the devices should join.
This is a mandatory parameter.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Password
The password used to authenticate against the WiFi network.
This setting is mandatory if securityType is WEP, WPA or Any.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProfileID
The ID of the profile you wish to edit.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProxyAuthentication
The username used to authenticate to the proxy server.
Mandatory if proxyType is Manual.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProxyPassword
The password used to authenticate to the proxy server.
Mandatory if proxyType is Manual.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProxyPort
The proxy server's port.
Mandatory if proxyType is Manual.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProxyServer
The proxy server's network address.
Mandatory if proxyType is Manual.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProxyServerConfigURL
AThe URL of the PAC file that defines the proxy configuration.
Mandatory if proxyType is Automatic.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProxyType
Configures proxy settings to be used with this network.
Options are: Automatic, Manual, None.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecurityType
The type of WiFi security used on the WiFi network.
Options are: None, WEP, WPA and Any.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246604/Edit+WiFi+Payload

## RELATED LINKS
