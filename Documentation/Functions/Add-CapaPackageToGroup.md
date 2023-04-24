# Add-CapaPackageToGroup
Module: Capa.PowerShell.Module.SDK.Package

Adds a package to a group.

## Syntax

```powershell
Add-CapaPackageToGroup
	-CapaSDK <Object>
	-PackageName <String>
	-PackageVersion <String>
	-PackageType <String>
	-GroupName <String>
	-GroupType <String>
```

## Description

Adds a package to a group.

## Examples

### Example 1
```powershell
Add-CapaPackageToGroup -CapaSDK $CapaSDK -PackageName 'Winrar' -PackageVersion 'v3.0' -PackageType Computer -GroupName 'Bronx' -GroupType 'Dynamic_ADSI'
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

-**PackageName**

The name of the package.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageVersion**

The version of the package.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageType**

The type of the package, either Computer or User.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 4 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**GroupName**

The name of the group.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 5 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**GroupType**

The type of the group, either Dynamic_ADSI, Calendar, Department, Dynamic_SQL, Reinstall, Security or Static.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 6 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246807/Add+package+to+group
