# Get-CapaGroupFolder
Module: Capa.PowerShell.Module.SDK.Group

Gets the folder structure of a group.

## Syntax

```powershell
Get-CapaGroupFolder
	-CapaSDK <Object>
	-GroupName <String>
	-GroupType <String>
```

## Description

Returns a string with the folder structure of a group.
Someting like: "Folder1\Folder2".

## Examples

### Example 1
```powershell
Get-CapaGroupFolder -CapaSDK $CapaSDK -GroupName 'Default' -GroupType Dynamic_ADSI
```
    

## Parameters

-**CapaSDK**

The CapaSDK object.
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**GroupName**

The name of the group.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**GroupType**

The type of the group, either Dynamic_ADSI, Department, Dynamic_SQL or Static.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246272/Get+Group+Folder
