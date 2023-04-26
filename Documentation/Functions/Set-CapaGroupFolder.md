# Set-CapaGroupFolder
Module: Capa.PowerShell.Module.SDK.Group

Sets the folder structure of a group.

## Syntax

```powershell
Set-CapaGroupFolder
	-CapaSDK <Object>
	-GroupName <Object>
	-GroupType <Object>
	-FolderStructure <Object>
	-BusinessunitName <String>
```

## Description

Sets the folder structure of a group, either in a business unit or global.

## Examples

### Example 1
```powershell
Set-CapaGroupFolder -CapaSDK $CapaSDK -GroupName "Lenovo" -GroupType Static -FolderStructure  "Static\Manufacturers"
```
    
### Example 2
```powershell
Set-CapaGroupFolder -CapaSDK $CapaSDK -GroupName "Lenovo" -GroupType Static -FolderStructure  "Static\Manufacturers" -BusinessunitName "Test"
```
    

## Parameters

-**CapaSDK**

CapaSDK object.
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
| Type: | Object |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**GroupType**

The type of the group, either Dynamic_ADSI, Calendar, Department, Dynamic_SQL or Static.
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**FolderStructure**

The folder structure example: "Folder1\Folder2\Folder3".
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | 4 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**BusinessunitName**


| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 5 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246318/Set+Group+Folder 		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246326/Set+Group+folder+in+a+Business+Unit
