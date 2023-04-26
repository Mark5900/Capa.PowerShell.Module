# Add-CapaPackageToBusinessUnit
Module: Capa.PowerShell.Module.SDK.Package

Adds a package to a business unit.

## Syntax

```powershell
Add-CapaPackageToBusinessUnit
	-CapaSDK <Object>
	-PackageName <Object>
	-PackageVersion <Object>
	-PackageType <Object>
	-BusinessUnitName <Object>
```

## Description

Adds a package to a business unit.

## Examples

### Example 1
```powershell
Add-CapaPackageToBusinessUnit -CapaSDK $CapaSDK -PackageName 'Winrar' -PackageVersion 'v3.0' -PackageType Computer -BusinessUnitName 'HeadQuarterBronx'
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
| Type: | Object |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageVersion**

The version of the package.
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageType**

The type of the package, either Computer or User.
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | 4 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**BusinessUnitName**

The name of the business unit.
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | 5 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

for more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246796/Add+Package+to+BusinessUnit
