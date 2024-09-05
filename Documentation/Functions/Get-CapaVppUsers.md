# Get-CapaVppUsers

## SYNOPSIS
Gets a list of all VPP users.

## SYNTAX

```
Get-CapaVppUsers [-CapaSDK] <Object> [[-VppProgramID] <Int32>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Gets a list of all VPP users, if VppProgramID is specified, only VPP users for the specified program will be returned.

## EXAMPLES

### EXAMPLE 1
```
Get-CapaVppUsers -CapaSDK $CapaSDK
```

### EXAMPLE 2
```
Get-CapaVppUsers -CapaSDK $CapaSDK -VppProgramID 1
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

### -VppProgramID
A description of the VppProgramID parameter.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247808/Get+vpp+users
And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247818/Get+vpp+users+all

## RELATED LINKS
