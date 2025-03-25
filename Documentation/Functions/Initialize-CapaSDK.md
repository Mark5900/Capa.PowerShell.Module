# Initialize-CapaSDK

Module: Capa.PowerShell.Module.SDK.Authentication

## SYNOPSIS
Create a new CapaSDK object that is needed for all other functions.

## SYNTAX

```
Initialize-CapaSDK [-Server] <String> [-Database] <String> [[-UserName] <String>] [[-Password] <String>]
 [[-DefaultManagementPoint] <String>] [[-InstanceManagementPoint] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Create a new CapaSDK object that is needed for all other functions, with the option to set the database settings and management points.

## EXAMPLES

### EXAMPLE 1
```
Initialize-CapaSDK -Server 'CAPASQL01' -Database 'CapaInstaller' -DefaultManagementPoint 1
```

### EXAMPLE 2
```
Initialize-CapaSDK -Server 'CAPASQL01' -Database 'CapaInstaller' -InstanceManagementPoint 1
```

### EXAMPLE 3
```
Initialize-CapaSDK -Server 'CAPASQL01' -Database 'CapaInstaller' -UserName 'sa' -Password 'P@ssw0rd' -DefaultManagementPoint 1
```

## PARAMETERS

### -Database
The name of the database.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultManagementPoint
Id of the default management point.
DO NOT USE.
This will set the management point for all SDK objects, use InstanceManagementPoint instead.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstanceManagementPoint
Id of the instance management point.
Sets the management point for the current SDK object.
Use DefaultManagementPoint to set the management point for all SDK objects.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Password
If set, the database will be accessed with the given username and password.
Default is to use Windows Authentication.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
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

### -Server
The name of the server where the database is located.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserName
If set, the database will be accessed with the given username and password.
Default is to use Windows Authentication.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI67DOC/pages/20342580733/Set+database+settings
And https://capasystems.atlassian.net/wiki/spaces/CI67DOC/pages/20342580750/Set+default+management+point
And https://capasystems.atlassian.net/wiki/spaces/CI67DOC/pages/20342580769/Set+instance+management+point
And https://capasystems.atlassian.net/wiki/spaces/CI67DOC/pages/20342580794/Set+splitter

## RELATED LINKS
