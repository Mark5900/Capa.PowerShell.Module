# Add-CapaUnitToProfile
Module: Capa.PowerShell.Module.SDK.MDM

Link profile to a device.

## Syntax

```powershell
Add-CapaUnitToProfile
	-CapaSDK <Object>
	-UnitName <String>
	-ProfileName <String>
	-ChangelogComment <String>
```
```powershell
Add-CapaUnitToProfile
	-CapaSDK <Object>
	-Uuid <String>
	-ProfileName <String>
	-ChangelogComment <String>
```

## Description

The Add-CapaUnitToProfile function links a profile to a device.

## Examples

### Example 1
```powershell
Add-CapaUnitToProfile -CapaSDK $CapaSDK -UnitName 'Testdev01' -ProfileName 'Wi-Fi settings'
```
    
### Example 2
```powershell
Add-CapaUnitToProfile -CapaSDK $CapaSDK -Uuid '4eea2959-fb4c-4afe-b61f-810cb3019cd6' -ProfileName 'Wi-Fi settings'
```
    
### Example 3
```powershell
Add-CapaUnitToProfile -CapaSDK $CapaSDK -UnitName 'Testdev01' -ProfileName 'Wi-Fi settings' -ChangelogComment 'Linking profile to device'
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

-**Uuid**

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

A comment that will be added to the changelog.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246463/Link+profile+to+device
