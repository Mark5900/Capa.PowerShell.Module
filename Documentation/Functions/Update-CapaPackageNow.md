# Update-CapaPackageNow

## SYNOPSIS
Performs a update now on a package.

## SYNTAX

```
Update-CapaPackageNow [-CapaSDK] <Object> [-PackageName] <String> [-PackageVersion] <String>
 [-PackageType] <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Performs the Update now procedure on a package.
This will create a SyncJob to the CiSync service residing on the Point-server with the 'AutoJob' bit set which
will (after completion) in turn create 'auto-syncjobs' to child servers as well as BaseAgent-DistributionServers when/if the package is assigned or the child
servers are 'replica' servers.

This function is equivalent to the CM-plugin right-click action on a package.

## EXAMPLES

### EXAMPLE 1
```
Update-CapaPackageNow -CapaSDK $CapaSDK -PackageName 'Winrar' -PackageVersion '5.50' -PackageType 'Computer'
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

### -PackageName
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

### -PackageType
The type of the package, either Computer or User.

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

### -PackageVersion
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
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247056/Update+Now+on+Package

## RELATED LINKS
