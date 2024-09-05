# Set-CapaCustomInventory

## SYNOPSIS
Set custom inventory for a unit.

## SYNTAX

### NameType (Default)
```
Set-CapaCustomInventory -CapaSDK <Object> -UnitName <String> -UnitType <String> -Section <String>
 -Name <String> -Value <String> -DataType <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Uuid
```
Set-CapaCustomInventory -CapaSDK <Object> -Uuid <String> -Section <String> -Name <String> -Value <String>
 -DataType <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Set custom inventory for a unit, either by name and type or by UUID.

## EXAMPLES

### EXAMPLE 1
```
Set-CapaCustomInventory -CapaSDK $CapaSDK -UnitName 'Klient' -UnitType Computer -Section 'Antivirus' -Name 'Version' -Value '4' -DataType Integer
```

## PARAMETERS

### -CapaSDK
The CapaSDK object.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DataType
The data type of the value, can be String, Integer, Text or Time.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The name of the value.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
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

### -Section
The inventory section.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UnitName
The name of the unit.

```yaml
Type: String
Parameter Sets: NameType
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UnitType
The type of the unit, can be Computer or User.

```yaml
Type: String
Parameter Sets: NameType
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Uuid
The UUID of the unit.

```yaml
Type: String
Parameter Sets: Uuid
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value
The value.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246438/Set+custom+inventory

## RELATED LINKS
