# Add-CapaWifiPayloadToProfile

Module: Capa.PowerShell.Module.SDK.MDM

## SYNOPSIS
Add a new WiFi payload to a profile.

## SYNTAX

```
Add-CapaWifiPayloadToProfile [-CapaSDK] <Object> [-ProfileID] <Int32> [-NetworkName] <String>
 [[-HiddenNetwork] <Boolean>] [[-AutoJoin] <Boolean>] [-SecurityType] <String> [[-Password] <String>]
 [-ProxyType] <String> [[-ProxyServer] <String>] [[-ProxyPort] <String>] [[-ProxyAuthentication] <String>]
 [[-ProxyPassword] <String>] [[-ProxyServerConfigURL] <String>] [[-ChangelogComment] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Add a new WiFi payload to a profile.

## EXAMPLES

### EXAMPLE 1
```
Add-CapaWifiPayloadToProfile @(
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
```

## PARAMETERS

### -AutoJoin
Automatically join this wireless network.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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
The comment you wish to be added to the changelog.

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

### -HiddenNetwork
Enable if target network is not open or broadcasting.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
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
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Password
The password used to authenticate against the WiFi network.
This setting is mandatory if SecurityType is WEP, WPA or Any.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProfileID
The ID of the profile to add the payload to.

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
Position: 11
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
Position: 12
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
Position: 10
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
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProxyServerConfigURL
The URL of the PAC file that defines the proxy configuration.
Mandatory if proxyType is Automatic.

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

### -ProxyType
Configures proxy settings to be used with this network.
Options are: Automatic, Manual, None.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 8
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
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246510/Add+WiFi+Payload+to+Profile

## RELATED LINKS
