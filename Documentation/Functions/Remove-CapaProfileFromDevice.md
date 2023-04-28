# Remove-CapaProfileFromDevice
Module: Capa.PowerShell.Module.SDK.MDM

This function will remove a profile from a device.

## Syntax

```powershell
Remove-CapaProfileFromDevice
	-CapaSDK <Object>
	-UnitName <String>
	-ProfileName <String>
	-ChangelogComment <String>
```
```powershell
Remove-CapaProfileFromDevice
	-CapaSDK <Object>
	-UUID <String>
	-ProfileName <String>
	-ChangelogComment <String>
```

## Description

This function will remove a profile from a device, subsequently when the device reports successful removal of the profile, the relation is then removed from the database

## Examples

### Example 1
```powershell
Remove-CapaProfileFromDevice -CapaSDK $CapaSDK -UnitName 'Testdev01' -ProfileName 'Wi-Fi settings'
```
    
### Example 2
```powershell
Remove-CapaProfileFromDevice -CapaSDK $CapaSDK -Uuid '4eea2959-fb4c-4afe-b61f-810cb3019cd6' -ProfileName 'Wi-Fi settings'
```
    
### Example 3
```powershell
Remove-CapaProfileFromDevice -CapaSDK $CapaSDK -UnitName 'Testdev01' -ProfileName 'Wi-Fi settings' -ChangelogComment 'Removing profile from device'
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

-**UUID**

The UUID of the unit.
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

The comment that will be added to the changelog.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246487/Remove+profile+from+device
