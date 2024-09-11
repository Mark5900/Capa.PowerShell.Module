# Create-CapaUnit

Module: Capa.PowerShell.Module.SDK.Unit

## SYNOPSIS
https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247364/Create+unit

## SYNTAX

```
Create-CapaUnit [-CapaSDK] <Object> [-UnitName] <String> [-UnitType] <String>
 [-LinkToManagementServerID] <Int32> [[-Status] <String>] [[-Uuid] <String>] [[-SerialNumber] <String>]
 [[-UnitDeviceType] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
A detailed description of the Create-CapaUnit function.

## EXAMPLES

### EXAMPLE 1
```
Create-CapaUnit -CapaSDK $value1 -UnitName  'Value2' -UnitType Computer -LinkToManagementServerID  $value4
```

## PARAMETERS

### -CapaSDK
A description of the CapaSDK parameter.

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

### -LinkToManagementServerID
A description of the LinkToManagementServerID  parameter.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
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

### -SerialNumber
A description of the SerialNumber  parameter.

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

### -Status
A description of the Status parameter.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: Active
Accept pipeline input: False
Accept wildcard characters: False
```

### -UnitDeviceType
A description of the UnitDeviceType parameter.

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

### -UnitName
A description of the UnitName  parameter.

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

### -UnitType
A description of the UnitType parameter.

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

### -Uuid
A description of the Uuid  parameter.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Additional information about the function.

## RELATED LINKS
