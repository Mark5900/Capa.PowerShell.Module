# Update-CapaPackageScriptAndKit

## SYNOPSIS
Use this function to update a package script and kit in Capa.

## SYNTAX

### VBScriptWithKit
```
Update-CapaPackageScriptAndKit -PackageName <String> -PackageVersion <String> -ScriptContent <String>
 -ScriptType <String> -PackageType <String> -PackageBasePath <String> -KitFolderPath <String>
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### PowerPackWithKit
```
Update-CapaPackageScriptAndKit -PackageName <String> -PackageVersion <String> -ScriptContent <String>
 -ScriptType <String> -PackageType <String> -PackageBasePath <String> -SqlServerInstance <String>
 -Database <String> [-Credential <PSCredential>] -KitFolderPath <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### VBScript
```
Update-CapaPackageScriptAndKit -PackageName <String> -PackageVersion <String> -ScriptContent <String>
 -ScriptType <String> -PackageType <String> -PackageBasePath <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### PowerPack
```
Update-CapaPackageScriptAndKit -PackageName <String> -PackageVersion <String> -ScriptContent <String>
 -ScriptType <String> -PackageType <String> -SqlServerInstance <String> -Database <String>
 [-Credential <PSCredential>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Kit
```
Update-CapaPackageScriptAndKit -PackageName <String> -PackageVersion <String> -PackageBasePath <String>
 -KitFolderPath <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Use this function to update a package script and kit in Capa.
You will need SqlServer module installed if you want to update a PowerPack script.

## EXAMPLES

### EXAMPLE 1
```
$ScriptContent = Get-Content -Path 'C:\Users\CIKursus\Downloads\InstallScript.ps1' | Out-String
Update-CapaPackageScriptAndKit -PackageName 'Test1' -PackageVersion 'v1.0' -ScriptContent $ScriptContent -ScriptType 'Install' -PackageType 'PowerPack' -SqlServerInstance $CapaServer -Database $Database
```

### EXAMPLE 2
```
Update-CapaPackageScriptAndKit -PackageName 'Test1' -PackageVersion 'v1.0' -ScriptContent "Write-Host 'Hello World'" -ScriptType 'Install' -PackageType 'PowerPack' -SqlServerInstance $CapaServer -Database $Database
```

### EXAMPLE 3
```
Update-CapaPackageScriptAndKit -PackageName 'Test1' -PackageVersion 'v1.0' -ScriptContent "Write-Host 'Hello World'" -ScriptType 'Uninstall' -PackageType 'PowerPack' -SqlServerInstance $CapaServer -Database $Database
```

### EXAMPLE 4
```
Update-CapaPackageScriptAndKit -PackageName 'Test1' -PackageVersion 'v1.0' -ScriptContent "Write-Host 'Hello World'" -ScriptType 'Install' -PackageType 'PowerPack' -SqlServerInstance $CapaServer -Database $Database -PackageBasePath 'D:\CapaInstaller\CMPProduction\ComputerJobs' -KitFolderPath 'C:\Users\CIKursus\Downloads\Kit'
```

### EXAMPLE 5
```
Update-CapaPackageScriptAndKit -PackageName 'Opgave 1' -PackageVersion 'v1.0' -ScriptContent "Write-Host 'Hello World'" -ScriptType 'Install' -PackageType 'VBScript' -PackageBasePath 'D:\CapaInstaller\CMPProduction\ComputerJobs'
```

### EXAMPLE 6
```
Update-CapaPackageScriptAndKit -PackageName 'Opgave 1' -PackageVersion 'v1.0' -ScriptContent "Write-Host 'Hello World'" -ScriptType 'Uninstall' -PackageType 'VBScript' -PackageBasePath 'D:\CapaInstaller\CMPProduction\ComputerJobs'
```

### EXAMPLE 7
```
Update-CapaPackageScriptAndKit -PackageName 'Opgave 1' -PackageVersion 'v1.0' -PackageBasePath 'D:\CapaInstaller\CMPProduction\ComputerJobs' -KitFolderPath 'C:\Users\CIKursus\Downloads\Kit\'
```

## PARAMETERS

### -Credential
The credentials to use when connecting to the SQL Server instance.
Default is to use the current user's credentials.

```yaml
Type: PSCredential
Parameter Sets: PowerPackWithKit, PowerPack
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Database
The name of the database.

```yaml
Type: String
Parameter Sets: PowerPackWithKit, PowerPack
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -KitFolderPath
The path to the folder containing files to set as kit.

```yaml
Type: String
Parameter Sets: VBScriptWithKit, PowerPackWithKit, Kit
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PackageBasePath
The path to the package folder.
Example: \\\\CISRVKURSUS.CIKURSUS.local\CMPProduction\ComputerJobs

```yaml
Type: String
Parameter Sets: VBScriptWithKit, PowerPackWithKit, VBScript, Kit
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PackageName
The name of the package.

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

### -PackageType
The type of the package.
Valid values are: PowerPack, VBScript.

```yaml
Type: String
Parameter Sets: VBScriptWithKit, PowerPackWithKit, VBScript, PowerPack
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PackageVersion
The version of the package.

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

### -ScriptContent
The content of the script.

```yaml
Type: String
Parameter Sets: VBScriptWithKit, PowerPackWithKit, VBScript, PowerPack
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScriptType
The type of the script.
Valid values are: Install, Uninstall, UserConfiguration.

```yaml
Type: String
Parameter Sets: VBScriptWithKit, PowerPackWithKit, VBScript, PowerPack
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SqlServerInstance
The name of the SQL Server instance.

```yaml
Type: String
Parameter Sets: PowerPackWithKit, PowerPack
Aliases:

Required: True
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
