# Copy-CapaPackageRelation
Module: Capa.PowerShell.Module.SDK.Package

Custom funktion to copy a package relations.

## Syntax

```powershell
Copy-CapaPackageRelation
	-CapaSDK <Object>
	-FromPackageType <String>
	-FromPackageName <String>
	-FromPackageVersion <String>
	-ToPackageType <String>
	-ToPackageName <String>
	-ToPackageVersion <String>
	-CopyGroups <String>
	-CopyUnits <String>
	-UnlinkGroupsAndUnitsFromExistingPackage <Boolean>
	-DisableScheduleOnExistingPackage <Boolean>
```

## Description

Custom funktion to copy a package relations, that uses other CapaSDK functions.

## Examples

### Example 1
```powershell
Copy-CapaPackageRelation @(
	CapaSDK = $CapaSDK
	FromPackageType = 'Winrar'
	FromPackageName = 'v3.0'
	FromPackageVersion = 'Computer'
	ToPackageType = 'Winrar'
	ToPackageName = 'v3.1'
	ToPackageVersion = 'Computer'
	CopyGroups = 'All'
	CopyUnits = "None"
	UnlinkGroupsAndUnitsFromExistingPackage = $true
	DisableScheduleOnExistingPackage = $true
)
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

-**FromPackageType**

The type of the package to copy relations from, either Computer or User.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**FromPackageName**

The name of the package to copy relations from.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**FromPackageVersion**

The version of the package to copy relations from.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 4 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ToPackageType**

The type of the package to copy relations to, either Computer or User.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 5 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ToPackageName**

The name of the package to copy relationsto.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 6 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ToPackageVersion**

The version of the package to copy relations to.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 7 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**CopyGroups**

If set to All, all groups will be copied. If set to None, no groups will be copied.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 8 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**CopyUnits**

If set to All, all units will be copied. If set to None, no units will be copied.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 9 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**UnlinkGroupsAndUnitsFromExistingPackage**

If set to true, all groups and units will be unlinked from the existing package.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 10 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**DisableScheduleOnExistingPackage**

If set to true, the schedule will be disabled on the existing package.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 11 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

Custom command.
