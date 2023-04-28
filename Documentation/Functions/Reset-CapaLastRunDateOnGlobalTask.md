# Reset-CapaLastRunDateOnGlobalTask
Module: Capa.PowerShell.Module.SDK.SystemSdk

Resets the last run date on a global task.

## Syntax

```powershell
Reset-CapaLastRunDateOnGlobalTask
	-CapaSDK <Object>
	-TaskDisplayName <String>
```

## Description

Returns the last run date on a global task.

## Examples

### Example 1
```powershell
Reset-CapaLastRunDateOnGlobalTask -CapaSDK $CapaSDK -TaskDisplayName 'Auto Archive Changelog'
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

-**TaskDisplayName**

The display name of the task. Can be one of the following:
	Auto Archive Changelog
	Cleanup Performance Index Data
	Clear Changeset
	Clear Deleted Units
	Group Health Check
	Inventory Cleanup
	Process Metering History
	Process SQL groups
	System Health
	Update Active Directory Groups
	Update Application Groups
	Update OS Version
	Update Unit Commands
	Update Unlicensed Software Queries
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247152/Reset+LastRun+Date+On+Global+Task
