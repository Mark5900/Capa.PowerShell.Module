# Set-CapaPackageFolder
Module: Capa.PowerShell.Module.SDK.Package

Set the folder structure of a package.

## Syntax

```powershell
Set-CapaPackageFolder
	-CapaSDK <Object>
	-PackageType <String>
	-PackageName <String>
	-PackageVersion <String>
	-FolderStructure <String>
	-ChangelogText <String>
```

## Description

Set the folder structure of a package.

## Examples

### Example 1
```powershell
Set-CapaPackageFolder -CapaSDK $CapaSDK -PackageType 'Computer' -PackageName 'Winrar' -PackageVersion '5.50' -FolderStructure 'Folder1\Folder2' -ChangelogText 'This is a changelog'
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

The type of package to set the folder structure of, either Computer or User.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageName**

The name of the package to set the folder structure of.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageVersion**

The version of the package to set the folder structure of.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 4 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**FolderStructure**

The folder structure to set, for example 'Folder1\Folder2'.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 5 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ChangelogText**

An optional changelog text to set.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 6 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247032/Set+Package+Folder
