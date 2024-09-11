# Invite-CapaUnitToVppProgram

Module: Capa.PowerShell.Module.SDK.VPP

## SYNOPSIS
Creates a VPP user at Apple where an invitation URL is generated.
This invitation is then sent to the device where the user will have the option to accept or decline.

## SYNTAX

```
Invite-CapaUnitToVppProgram [-CapaSDK] <Object> [-VppProgramID] <Int32> [-UnitID] <Int32>
 [-UserFullName] <String> [-UserEmailName] <String> [-UserDescription] <String>
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Creates a VPP user at Apple where an invitation URL is generated.
This invitation is then sent to the device where the user will have the option to accept or decline.
If the user accepts the invitation, its Apple ID will be linked to the VPP user at Apple, which can be seen in the system after the next synchronization cycle.

There are a few requirements for the operation to succeed.
	The device must be running iOS8 or higher.
	The device should not already be enrolled in the Volume Purchase Program specified.
	If an invitation previously sent to the device was not accepted, a VPP user will already exist at Apple.
In order to avoid creating multiple VPP users, the system will reuse that original invitation and send it to the device again.

## EXAMPLES

### EXAMPLE 1
```
Invite-CapaUnitToVppProgram -CapaSDK $CapaSDK -VppProgramID 1 -UnitID 1 -UserFullName 'Test User' -UserEmailName 'Test@test.com' -UserDescription 'Test User'
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

### -UnitID
The id of the iOS device which should receive an invitation.

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

### -UserDescription
The description of the vpp user being created.

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

### -UserEmailName
The email of the vpp user being created.

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

### -UserFullName
The fullname of the vpp user being created.

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

### -VppProgramID
The VPP user will be created in the program with the specified id.

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
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247828/Invite+unit+to+vpp

## RELATED LINKS
