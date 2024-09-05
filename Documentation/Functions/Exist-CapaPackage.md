# Exist-CapaPackage

Module: Capa.PowerShell.Module.SDK.Package

## SYNOPSIS
Verifies if a package exists.

## SYNTAX

```
Exist-CapaPackage [-CapaSDK] <Object> [-Name] <String> [-Version] <String> [-Type] <String>
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Veirfies if a package exists.

## EXAMPLES

### EXAMPLE 1
```
Exist-CapaPackage -CapaSDK $CapaSDK -Name 'TestPackage' -Version 'v1.0.0' -Type 'Computer'
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

### -Name
The name of the package.

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

### -Type
The type of package, can be either Computer or User.

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

### -Version
The version of the package.

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
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246874/Exist+package

## RELATED LINKS
