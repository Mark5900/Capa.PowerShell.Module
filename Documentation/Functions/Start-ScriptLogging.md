# Start-ScriptLogging

Module: Capa.PowerShell.Module.Tools

## SYNOPSIS
This fuction is used to start logging of a SDK script.

## SYNTAX

```
Start-ScriptLogging [-Path] <String> [[-UseDateInFileName] <Boolean>] [[-UseTimeInFileName] <Boolean>]
 [[-UseStopwatch] <Boolean>] [[-DeleteDaysOldLogs] <Int32>] [[-LogName] <String>] [[-DeleteAllLogs] <Boolean>]
 [[-AppendToLog] <Boolean>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This fuction is used to start logging of a SDK script.
The log file will be stored in a folder named Logs_\<LogName\> in the path specified.
You can get the path to the log file by using the global variable $Global:SDKScriptLogfile.

## EXAMPLES

### EXAMPLE 1
```
Start-ScriptLogging -Path $PSScriptRoot -LogName 'Test-Module'
```

### EXAMPLE 2
```
Start-ScriptLogging -Path $PSScriptRoot -LogName 'Test-Module' -UseDateInFileName False
```

### EXAMPLE 3
```
Start-ScriptLogging -Path $PSScriptRoot -LogName 'Test-Module' -UseTimeInFileName False
```

### EXAMPLE 4
```
Start-ScriptLogging -Path $PSScriptRoot -LogName 'Test-Module' -UseStopwatch False
```

### EXAMPLE 5
```
Start-ScriptLogging -Path $PSScriptRoot -LogName 'Test-Module' -DeleteDaysOldLogs 1
```

## PARAMETERS

### -AppendToLog
Default is true.
If set to false a new log file will be created.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -DeleteAllLogs
Default is false.
If set to true all logs will be deleted.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DeleteDaysOldLogs
Sets the number of days old logs should be deleted.
Default is 90 days.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 90
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogName
Sets the name of the log file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Defines the path to the folder where the log file should be stored.
In most cases this should be $PSScriptRoot.

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

### -UseDateInFileName
Default is true.
If set to false the date will not be used in the log file name.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseStopwatch
Default is true.
If set to false the stopwatch will not be used in the log file.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseTimeInFileName
Default is true.
If set to false the time will not be used in the log file name.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
This is a custom function created to have a standard way of starting logging in SDK scripts.

## RELATED LINKS
