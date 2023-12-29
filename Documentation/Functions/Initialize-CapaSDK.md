# Initialize-CapaSDK
Module: Capa.PowerShell.Module.SDK.Authentication

Create a new CapaSDK object that is needed for all other functions.

## Syntax

```powershell
Initialize-CapaSDK
	-Server <String>
	-Database <String>
	-UserName <String>
	-Password <String>
	-DefaultManagementPoint <String>
	-InstanceManagementPoint <String>
```

## Description

Create a new CapaSDK object that is needed for all other functions, with the option to set the database settings and management points.

## Examples

### Example 1
```powershell
Initialize-CapaSDK -Server 'CAPASQL01' -Database 'CapaInstaller' -DefaultManagementPoint 1
```
    
### Example 2
```powershell
Initialize-CapaSDK -Server 'CAPASQL01' -Database 'CapaInstaller' -InstanceManagementPoint 1
```
    
### Example 3
```powershell
Initialize-CapaSDK -Server 'CAPASQL01' -Database 'CapaInstaller' -UserName 'sa' -Password 'P@ssw0rd' -DefaultManagementPoint 1
```
    

## Parameters

-**Server**

The name of the server where the database is located.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Database**

The name of the database.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**UserName**

If set, the database will be accessed with the given username and password.
Default is to use Windows Authentication.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Password**

If set, the database will be accessed with the given username and password.
Default is to use Windows Authentication.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 4 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**DefaultManagementPoint**

Id of the default management point.
DO NOT USE. This will set the management point for all SDK objects, use InstanceManagementPoint instead.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 5 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**InstanceManagementPoint**

Id of the instance management point.
Sets the management point for the current SDK object. Use DefaultManagementPoint to set the management point for all SDK objects.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 6 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246140/Set+database+settings 		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246148/Set+default+management+point 		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246158/Set+instance+management+point 		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246174/Set+splitter
