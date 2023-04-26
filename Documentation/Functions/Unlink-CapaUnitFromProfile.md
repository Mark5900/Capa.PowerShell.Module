# Unlink-CapaUnitFromProfile
Module: Capa.PowerShell.Module.SDK.MDM

Unlink profile from a device.

## Syntax

```powershell
Unlink-CapaUnitFromProfile
	-CapaSDK <Object>
	-ProfileName <String>
	-ChangelogComment <String>
	-Uuid <String>
```
```powershell
Unlink-CapaUnitFromProfile
	-CapaSDK <Object>
	-UnitName <String>
	-ProfileName <String>
	-ChangelogComment <String>
```

## Description

This will unlink a profile from a device and not remove the profile from the physical device.

## Examples

### Example 1
```powershell
Unlink-CapaUnitFromProfile -CapaSDK $CapaSDK -UnitName 'Testdev01' -ProfileName 'Wi-Fi settings'
```
    
### Example 2
```powershell
Unlink-CapaUnitFromProfile -CapaSDK $CapaSDK -Uuid '4eea2959-fb4c-4afe-b61f-810cb3019cd6' -ProfileName 'Wi-Fi settings'
```
    

## Parameters

-**CapaSDK**

The CapaSDK object.
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**UnitName**

The unit name of the unit.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ProfileName**

The name of the MDM profile.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ChangelogComment**

A comment that will be added to the changelog.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Uuid**

The UUID of the unit.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246474/Unlink+profile+from+device
