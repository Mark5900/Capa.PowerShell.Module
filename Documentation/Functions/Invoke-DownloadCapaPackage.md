# Invoke-DownloadCapaPackage

Module: Capa.PowerShell.Module.Tools

## SYNOPSIS
Downloads a Capa package from CI server using the BaseAgent.

## SYNTAX

```
Invoke-DownloadCapaPackage [-PackageName] <String> [-PackageVersion] <String> [-DestinationFolder] <String>
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Downloads a Capa package from server using the BaseAgent.

## EXAMPLES

### EXAMPLE 1
```
Invoke-DownloadCapaPackage -PackageName 'CP CapaDrivers Latitude 5440' -PackageVersion 'W10 Custom' -DestinationFolder 'c:\temp\Test'
```

## PARAMETERS

### -DestinationFolder
The folder where the package will be downloaded and extracted to.

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

### -PackageName
The name of the package to download.

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

### -PackageVersion
The version of the package to download.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
This function requires the Capa BaseAgent to be installed on the machine.

## RELATED LINKS
