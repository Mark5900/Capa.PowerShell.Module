# Initialize-PpInputObject

Module: Capa.PowerShell.Module.PowerPack

## SYNOPSIS
Initialize the InputObject object.

## SYNTAX

```
Initialize-PpInputObject
```

## DESCRIPTION
Used in PowerPacks to initialize the InputObject object, if it is not already initialized.
If you run a PowerPack script locally, then InputObject is null and you can use this function create a obejct to test your script.

The only thing that does not work is CMS functions, because they need a real InputObject object.
The message box is also not the real one, but a simple example.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
