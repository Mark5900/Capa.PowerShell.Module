---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.Tools-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.Tools
ms.date: 12/02/2025
PlatyPS schema version: 2024-05-01
title: New-MessageBox
---

# New-MessageBox

## SYNOPSIS

New-Popup will display a message box. If a timeout is requested it uses Wscript.Shell PopUp method. If a default button is requested it uses the ::Show method from 'Windows.Forms.MessageBox'

## SYNTAX

### Timeout (Default)

```
New-MessageBox -Message <string> -Title <string> [-Time <int>] [-Buttons <string>] [-Icon <string>]
 [-ShowOnTop] [-AsString] [<CommonParameters>]
```

### DefaultButton

```
New-MessageBox -Message <string> -Title <string> [-Buttons <string>] [-Icon <string>]
 [-DefaultButton <string>] [-AsString] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The New-Popup command uses the Wscript.Shell PopUp method to display a graphical message
box.
You can customize its appearance of icons and buttons.
By default the user
must click a button to dismiss but you can set a timeout value in seconds to
automatically dismiss the popup.

The command will write the return value of the clicked button to the pipeline:
Timeout = -1
OK = 1
Cancel = 2
Abort = 3
Retry = 4
Ignore = 5
Yes = 6
No = 7

If no button is clicked, the return value is -1.

## EXAMPLES

### EXAMPLE 1

new-popup -message "The update script has completed" -title "Finished" -time 5

This will display a popup message using the default OK button and default
Information icon.
The popup will automatically dismiss after 5 seconds.

### EXAMPLE 2

$answer = new-popup -Message "Please pick" -Title "form" -buttons "OKCancel" -icon "information"

If the user clicks "OK" the $answer variable will be equal to 1.
If the user clicks "Cancel" the
$answer variable will be equal to 2.

### EXAMPLE 3

$answer = new-popup -Message "Please pick" -Title "form" -buttons "OKCancel" -icon "information" -AsString

If the user clicks "OK" the $answer variable will be equal to 'OK'.
If the user clicks "Cancel" the
$answer variable will be 'Cancel'

## PARAMETERS

### -AsString

Will return a human readable representation of which button was pressed as opposed to an integer value.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Timeout
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: DefaultButton
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Buttons

Valid values for -Buttons include:
"OK"
"OKCancel"
"AbortRetryIgnore"
"YesNo"
"YesNoCancel"
"RetryCancel"

```yaml
Type: System.String
DefaultValue: OK
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Timeout
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: DefaultButton
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -DefaultButton

{{ Fill DefaultButton Description }}

```yaml
Type: System.String
DefaultValue: Button1
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: DefaultButton
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Icon

Valid values for -Icon include:
"Stop"
"Question"
"Exclamation"
"Information"
"None"

```yaml
Type: System.String
DefaultValue: None
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Timeout
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: DefaultButton
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Message

The message you want displayed

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Timeout
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: DefaultButton
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ShowOnTop

Switch which will force the popup window to appear on top of all other windows.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Timeout
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Time

The time to display the message.
Defaults to 0 (zero) which will keep dialog open until a button is clicked

```yaml
Type: System.Int32
DefaultValue: 0
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Timeout
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Title

The text to appear in title bar of dialog box

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Timeout
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: DefaultButton
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### An integer with the following value depending upon the button pushed.

Timeout = -1 # Value when timer finishes countdown.
OK = 1
Cancel = 2
Abort = 3
Retry = 4
Ignore = 5
Yes = 6
No = 7

{{ Fill in the Description }}

### int

{{ Fill in the Description }}

## NOTES

## RELATED LINKS

- [Wscript.Shell]()
