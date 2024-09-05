# Add-CapaUnitToReinstall

## SYNOPSIS
https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247348/Add+unit+to+reinstall

## SYNTAX

```
Add-CapaUnitToReinstall [-CapaSDK] <Object> [-ComputerName] <String> [-OSpointID] <Int32> [-OSserverID] <Int32>
 [-OSImageID] <Int32> [-DiskConfigID] <Int32> [-InstallTypeID] <Int32> [[-NewUnitName] <String>]
 [[-ReinstallMode] <String>] [[-Active] <Boolean>] [[-UnlinkAllPackagesAndGroups] <Boolean>]
 [[-UnlinkAllAdvPackages] <Boolean>] [[-ChangelogComment] <String>] [[-ReinstallStartDate] <String>]
 [[-CustomField1] <String>] [[-CustomField2] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
A detailed description of the Add-CapaUnitToReinstall function.

## EXAMPLES

### EXAMPLE 1
```
Add-CapaUnitToReinstall -CapaSDK $value1 -ComputerName 'Value2' -OSpointID $value3 -OSserverID $value4 -OSImageID $value5 -DiskConfigID $value6 -InstallTypeID $value7
```

## PARAMETERS

### -Active
A description of the Active parameter.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

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
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName
A description of the ComputerName parameter.

```yaml
Type: String
Parameter Sets: (All)
Aliases: UUID

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CustomField1
A description of the CustomField1 parameter.

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

### -CustomField2
A description of the CustomField2 parameter.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DiskConfigID
A description of the DiskConfigID parameter.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 6
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstallTypeID
A description of the InstallTypeID parameter.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 7
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -NewUnitName
A description of the NewUnitName parameter.

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

### -OSImageID
A description of the OSImageID parameter.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -OSpointID
A description of the OSpointID parameter.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -OSserverID
A description of the OSserverID parameter.

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

### -ReinstallMode
A description of the ReinstallMode parameter.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: Silent
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReinstallStartDate
A description of the ReinstallStartDate parameter.

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

### -UnlinkAllAdvPackages
A description of the UnlinkAllAdvPackages parameter.

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

### -UnlinkAllPackagesAndGroups
A description of the UnlinkAllPackagesAndGroups parameter.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Additional information about the function.

## RELATED LINKS
