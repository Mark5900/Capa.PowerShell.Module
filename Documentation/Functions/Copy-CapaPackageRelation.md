# Copy-CapaPackageRelation

Module: Capa.PowerShell.Module.SDK.Package

## SYNOPSIS
Custom funktion to copy a package relations.

## SYNTAX

```
Copy-CapaPackageRelation [-CapaSDK] <Object> [-FromPackageName] <String> [-FromPackageVersion] <String>
 [-FromPackageType] <String> [-ToPackageName] <String> [-ToPackageVersion] <String> [-ToPackageType] <String>
 [[-CopyGroups] <Boolean>] [[-CopyUnits] <Boolean>] [[-UnlinkGroupsAndUnitsFromExistingPackage] <Boolean>]
 [[-DisableScheduleOnExistingPackage] <Boolean>] [[-CopySchedule] <Boolean>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Custom funktion to copy a package relations, that uses other CapaSDK functions.

## EXAMPLES

### EXAMPLE 1
```
Copy-CapaPackageRelation @(
	CapaSDK = $CapaSDK
	FromPackageType = 'Winrar'
	FromPackageName = 'v3.0'
	FromPackageVersion = 'Computer'
	ToPackageType = 'Winrar'
	ToPackageName = 'v3.1'
	ToPackageVersion = 'Computer'
	CopyGroups = 'All'
	CopyUnits = "None"
	UnlinkGroupsAndUnitsFromExistingPackage = $true
	DisableScheduleOnExistingPackage = $true
	CopySchedule = $true
)
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

### -CopyGroups
If set to All, all groups will be copied.
If set to None, no groups will be copied.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -CopySchedule
If set to true, the schedule will be copied from the existing package.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -CopyUnits
If set to All, all units will be copied.
If set to None, no units will be copied.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisableScheduleOnExistingPackage
If set to true, the schedule will be disabled on the existing package.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FromPackageName
The name of the package to copy relations from.

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

### -FromPackageType
The type of the package to copy relations from, either Computer or User.

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

### -FromPackageVersion
The version of the package to copy relations from.

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

### -ToPackageName
The name of the package to copy relationsto.

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

### -ToPackageType
The type of the package to copy relations to, either Computer or User.

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

### -ToPackageVersion
The version of the package to copy relations to.

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

### -UnlinkGroupsAndUnitsFromExistingPackage
If set to true, all groups and units will be unlinked from the existing package.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Custom command.

## RELATED LINKS
