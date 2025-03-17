# Invoke-BaseAgentDownloadFile

Module: Capa.PowerShell.Module.Tools

## SYNOPSIS
Downloads a file from CI server using the BaseAgent.

## SYNTAX

```
Invoke-BaseAgentDownloadFile [-RemotePath] <String> [-LocalPath] <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Downloads a file from server using the BaseAgent.

## EXAMPLES

### EXAMPLE 1
```
Invoke-BaseAgentDownloadFile -RemotePath "\Resources/AgentInstaller/CapaInstaller agent.xml" -LocalPath "c:\temp"
```

### EXAMPLE 2
```
Invoke-BaseAgentDownloadFile -RemotePath "\Resources/AgentInstaller/CapaInstaller agent.xml" -LocalPath "c:\temp\CapaInstaller agent.xml"
```

## PARAMETERS

### -LocalPath
The folder or specific path where the file will be downloaded to.

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

### -RemotePath
The path of the file to download.

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
This function requires the Capa BaseAgent to be installed on the machine.

## RELATED LINKS
