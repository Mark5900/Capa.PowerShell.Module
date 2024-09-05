# Set-CapaGroupFolder

## SYNOPSIS
Sets the folder structure of a group.

## SYNTAX

```
Set-CapaGroupFolder [-CapaSDK] <Object> [-GroupName] <Object> [-GroupType] <Object> [-FolderStructure] <Object>
 [[-BusinessunitName] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Sets the folder structure of a group, either in a business unit or global.

## EXAMPLES

### EXAMPLE 1
```
Set-CapaGroupFolder -CapaSDK $CapaSDK -GroupName "Lenovo" -GroupType Static -FolderStructure  "Static\Manufacturers"
```

### EXAMPLE 2
```
Set-CapaGroupFolder -CapaSDK $CapaSDK -GroupName "Lenovo" -GroupType Static -FolderStructure  "Static\Manufacturers" -BusinessunitName "Test"
```

## PARAMETERS

### -BusinessunitName
{{ Fill BusinessunitName Description }}

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

### -CapaSDK
CapaSDK object.

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

### -FolderStructure
The folder structure example: "Folder1\Folder2\Folder3".

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupName
The name of the group.

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

### -GroupType
The type of the group, either Dynamic_ADSI, Calendar, Department, Dynamic_SQL or Static.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246318/Set+Group+Folder
And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246326/Set+Group+folder+in+a+Business+Unit

## RELATED LINKS
