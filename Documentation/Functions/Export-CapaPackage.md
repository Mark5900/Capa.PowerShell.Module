# Export-CapaPackage
Module: Capa.PowerShell.Module.SDK.Package

Export a package.

## Syntax

```powershell
Export-CapaPackage
	-CapaSDK <Object>
	-PackageType <String>
	-PackageName <String>
	-PackageVersion <String>
	-ToFolder <String>
```

## Description

Eports a package to a folder.

## Examples

### Example 1
```powershell
Export-CapaPackage -CapaSDK $CapaSDK -PackageType 'Computer' -PackageName 'TestPackage' -PackageVersion 'v1.0.0' -ToFolder 'C:\Temp'
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

-**PackageType**

The type of package, can be either Computer or User.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageName**

The name of the package.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageVersion**

The version of the package.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 4 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ToFolder**

Path to the folder where the package should be exported to.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 5 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246882/Export+package
