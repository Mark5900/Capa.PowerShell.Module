# Set-CapaUnitPackageStatus

Module: Capa.PowerShell.Module.SDK.Unit

## SYNOPSIS
https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247748/Set+unit+package+status

## SYNTAX

```
Set-CapaUnitPackageStatus [-CapaSDK] <Object> [-UnitName] <String> [-UnitType] <String> [-PackageName] <String>
 [-PackageVersion] <String> [-Status] <String> [[-ChangelogComment] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
A detailed description of the Set-CapaUnitPackageStatus function.

## EXAMPLES

### EXAMPLE 1
```
Set-CapaUnitPackageStatus -CapaSDK $value1 -UnitName  $value2 -UnitType Computer -PackageName  $value4 -PackageVersion  $value5 -Status  $value6
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

### -ChangelogComment
A description of the ChangelogComment parameter.

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

### -PackageName
A description of the PackageName  parameter.

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

### -PackageVersion
A description of the PackageVersion  parameter.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
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

### -Status
A description of the Status  parameter.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Additional information about the function.

## RELATED LINKS
