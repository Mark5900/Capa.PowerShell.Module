# Set-PpRegistryValue

Module: Capa.PowerShell.Module.PowerPack.Reg

## SYNOPSIS
Sets a registry value.

## SYNTAX

```
Set-PpRegistryValue [-RegRoot] <String> [-Datatype] <String> [-RegKey] <String> [-RegValue] <String>
 [[-RegData] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Sets a registry value in the registry, if RegRoot is HKCU, the function will set the value for all users that have logged on to the unit and future users.

## EXAMPLES

### EXAMPLE 1
```
Set-PpRegistryValue -RegRoot "HKLM" -Datatype "String" -RegKey "SOFTWARE\CapaSystems" -RegValue "Test" -RegData "Test1"
```

### EXAMPLE 2
```
Set-PpRegistryValue -RegRoot "HKCU" -Datatype "String" -RegKey "SOFTWARE\CapaSystems" -RegValue "Test" -RegData "Test1"
```

## PARAMETERS

### -Datatype
The datatype of the registry value, can be String, DWORD (32-bit) or Expanded String.

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

### -RegData
The data of the registry value.

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

### -RegKey
The path of the registry key.

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

### -RegValue
The name of the registry value.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
