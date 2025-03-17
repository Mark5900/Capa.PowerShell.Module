# Reg_DeleteTree

Module: Capa.PowerShell.Module.PowerPack.Reg

## SYNOPSIS
Deletes a registry tree.

## SYNTAX

```
Reg_DeleteTree [-RegRoot] <String> [-RegPath] <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Deletes a registry tree in the registry, if RegRoot is HKCU, the function will delete the tree for all users that have logged on to the unit and future users.

## EXAMPLES

### EXAMPLE 1
```
Reg_DeleteTree -RegRoot "HKLM" -RegPath "SOFTWARE\CapaSystems" -RegKey "Test"
```

### EXAMPLE 2
```
Reg_DeleteTree -RegRoot "HKCU" -RegPath "SOFTWARE\CapaSystems" -RegKey "Test"
```

## PARAMETERS

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

### -RegPath
The path of the registry key.

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

### -RegRoot
The root of the registry key, can be HKLM, HKCU or HKU.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455836/cs.Reg+DelTree

## RELATED LINKS
