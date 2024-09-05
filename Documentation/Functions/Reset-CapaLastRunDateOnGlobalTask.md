# Reset-CapaLastRunDateOnGlobalTask

## SYNOPSIS
Resets the last run date on a global task.

## SYNTAX

```
Reset-CapaLastRunDateOnGlobalTask [-CapaSDK] <Object> [-TaskDisplayName] <String>
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns the last run date on a global task.

## EXAMPLES

### EXAMPLE 1
```
Reset-CapaLastRunDateOnGlobalTask -CapaSDK $CapaSDK -TaskDisplayName 'Auto Archive Changelog'
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

### -TaskDisplayName
The display name of the task.
Can be one of the following:
	Auto Archive Changelog
	Cleanup Performance Index Data
	Clear Changeset
	Clear Deleted Units
	Group Health Check
	Inventory Cleanup
	Process Metering History
	Process SQL groups
	System Health
	Update Active Directory Groups
	Update Application Groups
	Update OS Version
	Update Unit Commands
	Update Unlicensed Software Queries

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247152/Reset+LastRun+Date+On+Global+Task

## RELATED LINKS
