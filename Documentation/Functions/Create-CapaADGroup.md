# Create-CapaADGroup
Module: Capa.PowerShell.Module.SDK.Utilities

Create an CapaInstaller AD group.

## Syntax

```powershell
Create-CapaADGroup
	-CapaSDK <Object>
	-GroupName <String>
	-UnitType <String>
	-LDAPPath <String>
	-recursive <String>
```

## Description

Create an CapaInstaller AD group.

## Examples

### Example 1
```powershell
Create-CapaADGroup -CapaSDK $CapaSDK -GroupName 'TestGroup' -UnitType 'Computer' -LDAPPath 'LDAP://OU=TestOU,DC=capa,DC=local' -recursive 'true'
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

-**UnitType**

The type of the elements in the group. This can be either "Computer" or "User"
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**LDAPPath**

The LDAP path of the elements in the group.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 4 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**recursive**

Indicates whether the group should be processed recursively.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 5 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246216/Create+AD+group
