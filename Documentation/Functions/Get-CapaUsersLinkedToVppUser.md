# Get-CapaUsersLinkedToVppUser

Module: Capa.PowerShell.Module.SDK.VPP

## SYNOPSIS
Gets a list of users linked to a VPP user.

## SYNTAX

```
Get-CapaUsersLinkedToVppUser [-CapaSDK] <Object> [-VppUserID] <Int32> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Gets a list of users linked to a vpp user, including inventory variables like full name and emails.

## EXAMPLES

### EXAMPLE 1
```
Get-CapaUsersLinkedToVppUser -CapaSDK $CapaSDK -VppUserID 1
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

### -VppUserID
The ID of the VPP user.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247612/Get+users+linked+to+vpp+user

## RELATED LINKS
