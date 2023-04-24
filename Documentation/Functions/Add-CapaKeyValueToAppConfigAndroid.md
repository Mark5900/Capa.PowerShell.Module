# Add-CapaKeyValueToAppConfigAndroid
Module: Capa.PowerShell.Module.SDK.MDM

Add a new key/value setting to an existing AppConfig payload in the specified profile.

## Syntax

```powershell
Add-CapaKeyValueToAppConfigAndroid
	-CapaSDK <Object>
	-DeviceApplicationID <Int32>
	-Key <String>
	-Value <String>
	-KeyValueType <Object>
	-ChangelogComment <Object>
```

## Description

Add a new Key/Value setting to an existing AppConfig payload in the specified profile.
If a setting with the specified key and type already exists, its value will be overwritten with the new value instead of creating a new setting.

## Examples

### Example 1
```powershell
Add-CapaKeyValueToAppConfigAndroid -CapaSDK $CapaSDK -DeviceApplicationID 1 -Key 'AllowSync' -Value 'True' -KeyValueType 'Bool' -ChangelogComment 'Adding new key/value setting to AppConfig payload'
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

-**DeviceApplicationID**

The ID of the Device Application you wish to edit.
| Name | Value |
| ---- | ---- |
| Type: | Int32 |
| Position: | 2 | 
| Default value: | 0 | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Key**

The key of the new setting.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Value**

The value of the new setting.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 4 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**KeyValueType**

The type of the new setting. Valid types are: String, Bool, Hidden, Integer
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | 5 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ChangelogComment**

the comment you wish to be added to the changelog.
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | 6 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246531/Add+edit+Key+Value+setting+to+Android+AppConfig
