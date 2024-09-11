# Register-Powerpack

Module: Capa.PowerShell.Module.PowerPack

## SYNOPSIS
Register a Powerpack in the registry

## SYNTAX

```
Register-Powerpack [-Application] <String> [-AppName] <String> [-Arch] <String> [[-Language] <String>]
 [[-AppCode] <String>] [-Version] <String> [[-Vendor] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Register a Powerpack in the registry

## EXAMPLES

### EXAMPLE 1
```
Register-Powerpack -Application 'CapaOne.ScriptingLibrary' -AppName 'CapaOne Scripting Library' -Arch 'x64' -Language 'en-us' -AppCode 'COSL' -Version '1.0' -Vendor 'CapaSystems'
```

## PARAMETERS

### -AppCode
The application code

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

### -Application
The application

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

### -AppName
The application name

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

### -Arch
The architecture

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

### -Language
The language

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: En-us
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

### -Vendor
The vendor

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

### -Version
The version

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Command from PSlib.psm1

## RELATED LINKS
