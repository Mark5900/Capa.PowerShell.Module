# Get-CapaManagementPoint

## SYNOPSIS
Get management points or a specific management point.

## SYNTAX

```
Get-CapaManagementPoint [-CapaSDK] <Object> [[-CmpId] <Int32>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
If CmpId is not specified, all management points are returned.

## EXAMPLES

### EXAMPLE 1
```
Get-CapaManagementPoint -CapaSDK $value1 -CmpId $value2
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

### -CmpId
The ID of the management point to return.
If omitted, all management points are returned.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247106/Get+management+point
And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247116/Get+management+points

## RELATED LINKS
