# Get-CapaPackages
Module: Capa.PowerShell.Module.SDK.Package

Get a list of packages.

## Syntax

```powershell
Get-CapaPackages
	-CapaSDK <Object>
	-Type <String>
	-BusinessUnit <String>
```

## Description

Get a list of packages and if a BusinessUnit is specified, get the packages on that BusinessUnit.

## Examples

### Example 1
```powershell
Get-CapaPackages -CapaSDK $CapaSDK -Type 'Computer'
```
    
### Example 2
```powershell
Get-CapaPackages -CapaSDK $CapaSDK -Type 'Computer' -BusinessUnit 'TestBusinessUnit'
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

-**Type**

If specified, only get packages of this type. Can be either Computer or User.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**BusinessUnit**

If specified, only get packages on this BusinessUnit.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246954/Get+packages 		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246964/Get+packages+on+Business+Unit
