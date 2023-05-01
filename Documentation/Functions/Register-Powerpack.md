# Register-Powerpack
Module: Capa.PowerShell.Module.PowerPack

Register a Powerpack in the registry

## Syntax

```powershell
Register-Powerpack
	-Application <String>
	-AppName <String>
	-Arch <String>
	-Language <String>
	-AppCode <String>
	-Version <String>
	-Vendor <String>
```

## Description

Register a Powerpack in the registry

## Examples

### Example 1
```powershell
Register-Powerpack -Application 'CapaOne.ScriptingLibrary' -AppName 'CapaOne Scripting Library' -Arch 'x64' -Language 'en-us' -AppCode 'COSL' -Version '1.0' -Vendor 'CapaSystems'
```
    

## Parameters

-**Application**

The application
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**AppName**

The application name
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Arch**

The architecture
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Language**

The language
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 4 | 
| Default value: | en-us | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**AppCode**

The application code
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 5 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Version**

The version
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 6 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Vendor**

The vendor
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 7 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

Command from PSlib.psm1
