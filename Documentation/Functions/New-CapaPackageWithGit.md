# New-CapaPackageWithGit

## SYNOPSIS
Creates a new capa package with Git support

## SYNTAX

### NotAdvanced
```
New-CapaPackageWithGit -PackageName <String> -PackageVersion <String> -PackageType <String> -BasePath <String>
 [-CapaServer <String>] [-SQLServer <String>] [-Database <String>] [-DefaultManagementPoint <String>]
 [-PackageBasePath <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Advanced
```
New-CapaPackageWithGit -SoftwareName <String> -SoftwareVersion <String> -PackageType <String>
 -BasePath <String> [-CapaServer <String>] [-SQLServer <String>] [-Database <String>]
 [-DefaultManagementPoint <String>] [-PackageBasePath <String>] [-Advanced]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Creates a local folder structure you can use with Git to manage your deployment of Capa packages.
There is both a simple and advanced mode.

It is recommended to read the documentation before using this function.
https://github.com/Mark5900/Capa.PowerShell.Module/tree/main/Documentation

## EXAMPLES

### EXAMPLE 1
```
New-CapaPackageWithGit -PackageName 'Test1' -PackageVersion 'v1.0' -PackageType 'VBScript' -BasePath 'C:\Temp' -CapaServer 'CISERVER' -SQLServer 'CISERVER' -Database 'CapaInstaller' -DefaultManagementPoint '1' -PackageBasePath 'E:\CapaInstaller\CMPProduction\ComputerJobs'
```

### EXAMPLE 2
```
New-CapaPackageWithGit -SoftwareName 'Test1' -SoftwareVersion 'v1.0' -PackageType 'PowerPack' -BasePath 'C:\Temp' -CapaServer 'CISERVER' -SQLServer 'CISERVER' -Database 'CapaInstaller' -DefaultManagementPoint '1' -PackageBasePath 'E:\CapaInstaller\CMPProduction\ComputerJobs' -Advanced
```

## PARAMETERS

### -Advanced
When specified the advanced setup will be used

```yaml
Type: SwitchParameter
Parameter Sets: Advanced
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -BasePath
The base path where the package folder will be created

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CapaServer
The Capa server name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Database
The Capa database name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultManagementPoint
The default management point

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PackageBasePath
The path of where CapaInstaller is saving the packages, example E:\CapaInstaller\CMPProduction\ComputerJobs

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PackageName
The name of the package

```yaml
Type: String
Parameter Sets: NotAdvanced
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PackageType
The type of the package, either VBScript or PowerPack

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PackageVersion
The version of the package

```yaml
Type: String
Parameter Sets: NotAdvanced
Aliases:

Required: True
Position: Named
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

### -SoftwareName
The name of the software

```yaml
Type: String
Parameter Sets: Advanced
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SoftwareVersion
The version of the software

```yaml
Type: String
Parameter Sets: Advanced
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SQLServer
The SQL server name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

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
This is a custom function that is not part of the CapaSDK

## RELATED LINKS
