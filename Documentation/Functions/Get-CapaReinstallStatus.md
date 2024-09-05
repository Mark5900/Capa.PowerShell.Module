# Get-CapaReinstallStatus

Module: Capa.PowerShell.Module.SDK.Utilities

## SYNOPSIS
Gets the reinstall status for a unit.

## SYNTAX

```
Get-CapaReinstallStatus [-CapaSDK] <Object> [-UnitName] <Object> [-UnitType] <Object>
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Gets the reinstall status for a unit.

## EXAMPLES

### EXAMPLE 1
```
Test-CapaReinstallStatus -CapaSDK $CapaSDK -UnitName 'TestComputer' -UnitType 'Computer'
```

## PARAMETERS

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

### -UnitName
The name of the unit.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UnitType
The type of the unit.
This can be either "Computer" or "User"

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
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
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247466/Get+reinstall+status

## RELATED LINKS
