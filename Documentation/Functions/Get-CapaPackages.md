# Get-CapaPackages

## SYNOPSIS
Get a list of packages.

## SYNTAX

```
Get-CapaPackages [-CapaSDK] <Object> [[-Type] <String>] [[-BusinessUnit] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Get a list of packages and if a BusinessUnit is specified, get the packages on that BusinessUnit.

## EXAMPLES

### EXAMPLE 1
```
Get-CapaPackages -CapaSDK $CapaSDK -Type 'Computer'
```

### EXAMPLE 2
```
Get-CapaPackages -CapaSDK $CapaSDK -Type 'Computer' -BusinessUnit 'TestBusinessUnit'
```

## PARAMETERS

### -BusinessUnit
If specified, only get packages on this BusinessUnit.

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

### -Type
If specified, only get packages of this type.
Can be either Computer or User.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246954/Get+packages
And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246964/Get+packages+on+Business+Unit

## RELATED LINKS
