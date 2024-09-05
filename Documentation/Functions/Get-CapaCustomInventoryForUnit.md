# Get-CapaCustomInventoryForUnit

## SYNOPSIS
Get the custom inventory for a unit.

## SYNTAX

### NameType
```
Get-CapaCustomInventoryForUnit -CapaSDK <Object> -UnitName <String> -UnitType <String>
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Uuid
```
Get-CapaCustomInventoryForUnit -CapaSDK <Object> -Uuid <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Get the custom inventory for a unit, with the option to get the inventory by name and type or by UUID.

## EXAMPLES

### EXAMPLE 1
```
Get-CapaCustomInventoryForUnit -Uuid 'E3FBEC1E-32AC-4E51-AB9F-A644CD9F0A6B'
```

### EXAMPLE 2
```
Get-CapaCustomInventoryForUnit -UnitName 'CAPA-TEST-01' -UnitType 'Computer'
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
The type of the unit.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246358/Get+custom+inventory+for+unit

## RELATED LINKS
