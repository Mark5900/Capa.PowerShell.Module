# Overview of all functions in modules

## Capa.PowerShell.Module.PowerPack

* [Add-PpDll](Functions/Add-PpDll.md)
* [Initialize-PpVariables](Functions/Initialize-PpVariables.md)
* [Invoke-RunAsLoggedOnUser](Functions/Invoke-RunAsLoggedOnUser.md)
* [Register-Powerpack](Functions/Register-Powerpack.md)
* [Start-PSDownloadPackage](Functions/Start-PSDownloadPackage.md)
* [Unregister-Powerpack](Functions/Unregister-Powerpack.md)

## Capa.PowerShell.Module.PowerPack.Exit

* [Exit-PpApplicationAlreadyInstalled](Functions/Exit-PpApplicationAlreadyInstalled.md)
* [Exit-PpCommandFailed](Functions/Exit-PpCommandFailed.md)
* [Exit-PpCommandHandlingFailed](Functions/Exit-PpCommandHandlingFailed.md)
* [Exit-PpCommandNotDelivered](Functions/Exit-PpCommandNotDelivered.md)
* [Exit-PpCommandNotRecognized](Functions/Exit-PpCommandNotRecognized.md)
* [Exit-PpCommandObsolete](Functions/Exit-PpCommandObsolete.md)
* [Exit-PpCommandSucceded](Functions/Exit-PpCommandSucceded.md)
* [Exit-PpCommandTimedOut](Functions/Exit-PpCommandTimedOut.md)
* [Exit-PpMissingDiskSpace](Functions/Exit-PpMissingDiskSpace.md)
* [Exit-PpModuleNotFound](Functions/Exit-PpModuleNotFound.md)
* [Exit-PpPackageCancelled](Functions/Exit-PpPackageCancelled.md)
* [Exit-PpPackageFailedInstall](Functions/Exit-PpPackageFailedInstall.md)
* [Exit-PpPackageFailedUninstall](Functions/Exit-PpPackageFailedUninstall.md)
* [Exit-PpPackageNotCompliant](Functions/Exit-PpPackageNotCompliant.md)
* [Exit-PpPowerShellExecutionFailed](Functions/Exit-PpPowerShellExecutionFailed.md)
* [Exit-PpRebootRequested](Functions/Exit-PpRebootRequested.md)
* [Exit-PpRetryLater](Functions/Exit-PpRetryLater.md)
* [Exit-PpScript](Functions/Exit-PpScript.md)

## Capa.PowerShell.Module.PowerPack.File

* [File_AppendToFile](Functions/File_AppendToFile.md)
* [File_CopyFile](Functions/File_CopyFile.md)
* [File_CopyTree](Functions/File_CopyTree.md)
* [File_CreateDir](Functions/File_CreateDir.md)
* [File_DelEmptyFolder](Functions/File_DelEmptyFolder.md)
* [File_DeleteLineInFile](Functions/File_DeleteLineInFile.md)
* [File_DelFile](Functions/File_DelFile.md)
* [File_DelTree](Functions/File_DelTree.md)
* [File_ExistDir](Functions/File_ExistDir.md)
* [File_ExistFile](Functions/File_ExistFile.md)
* [File_FindFile](Functions/File_FindFile.md)
* [File_GetFileVersion](Functions/File_GetFileVersion.md)
* [File_GetProductVersion](Functions/File_GetProductVersion.md)
* [File_RenameDir](Functions/File_RenameDir.md)
* [File_RenameFile](Functions/File_RenameFile.md)

## Capa.PowerShell.Module.PowerPack.Ini

* [Ini_ReadEntry](Functions/Ini_ReadEntry.md)
* [Ini_WriteEntry](Functions/Ini_WriteEntry.md)

## Capa.PowerShell.Module.PowerPack.Job

* [Job_DisableLog](Functions/Job_DisableLog.md)
* [Job_EnableLog](Functions/Job_EnableLog.md)
* [Job_EnableLog](Functions/Job_EnableLog.md)
* [Job_Start](Functions/Job_Start.md)
* [Job_WriteLog](Functions/Job_WriteLog.md)

## Capa.PowerShell.Module.PowerPack.Log

* [Log_SectionHeader](Functions/Log_SectionHeader.md)

## Capa.PowerShell.Module.PowerPack.MSI

* [MSI_GetProductCodeFromMSI](Functions/MSI_GetProductCodeFromMSI.md)
* [MSI_GetPropertiesFromMSI](Functions/MSI_GetPropertiesFromMSI.md)
* [MSI_GetPropertyFromMSI](Functions/MSI_GetPropertyFromMSI.md)
* [MSI_IsMSIFileInstalled](Functions/MSI_IsMSIFileInstalled.md)
* [MSI_IsMSIGuidInstalled](Functions/MSI_IsMSIGuidInstalled.md)

## Capa.PowerShell.Module.PowerPack.Reg

* [Reg_CreateKey](Functions/Reg_CreateKey.md)
* [Reg_DeleteVariable](Functions/Reg_DeleteVariable.md)
* [Reg_DelTree](Functions/Reg_DelTree.md)
* [Reg_EnumKey](Functions/Reg_EnumKey.md)
* [Reg_ExistKey](Functions/Reg_ExistKey.md)
* [Reg_ExistVariable](Functions/Reg_ExistVariable.md)
* [Reg_GetString](Functions/Reg_GetString.md)
* [Reg_SetDword](Functions/Reg_SetDword.md)
* [Reg_SetExpandString](Functions/Reg_SetExpandString.md)
* [Reg_SetInteger](Functions/Reg_SetInteger.md)
* [Reg_SetString](Functions/Reg_SetString.md)

## Capa.PowerShell.Module.PowerPack.Service

* [Service_Exist](Functions/Service_Exist.md)
* [Service_Start](Functions/Service_Start.md)
* [Service_Stop](Functions/Service_Stop.md)

## Capa.PowerShell.Module.PowerPack.Shell

* [Shell_Execute](Functions/Shell_Execute.md)

## Capa.PowerShell.Module.PowerPack.Sys

* [Sys_ExistProcess](Functions/Sys_ExistProcess.md)
* [Sys_GetFreeDiskSpace](Functions/Sys_GetFreeDiskSpace.md)
* [Sys_IsMinimumRequiredDiskspaceAvailable](Functions/Sys_IsMinimumRequiredDiskspaceAvailable.md)
* [Sys_KillProcess](Functions/Sys_KillProcess.md)
* [Sys_WaitForProcess](Functions/Sys_WaitForProcess.md)
* [Sys_WaitForProcessToExist](Functions/Sys_WaitForProcessToExist.md)

## Capa.PowerShell.Module.SDK.Authentication

* [Initialize-CapaSDK](Functions/Initialize-CapaSDK.md)

## Capa.PowerShell.Module.SDK.Container

* [Get-CapaDllVersion](Functions/Get-CapaDllVersion.md)
* [Get-CapaSchedule](Functions/Get-CapaSchedule.md)

## Capa.PowerShell.Module.SDK.Group

* [Create-CapaGroup](Functions/Create-CapaGroup.md)
* [Get-CapaApplicationGroups](Functions/Get-CapaApplicationGroups.md)
* [Get-CapaGroupDescription](Functions/Get-CapaGroupDescription.md)
* [Get-CapaGroupFolder](Functions/Get-CapaGroupFolder.md)
* [Get-CapaGroupPackages](Functions/Get-CapaGroupPackages.md)
* [Get-CapaGroupPrinters](Functions/Get-CapaGroupPrinters.md)
* [Get-CapaGroups](Functions/Get-CapaGroups.md)
* [Get-CapaGroupUnits](Functions/Get-CapaGroupUnits.md)
* [Remove-CapaGroup](Functions/Remove-CapaGroup.md)
* [Set-CapaGroupDescription](Functions/Set-CapaGroupDescription.md)
* [Set-CapaGroupFolder](Functions/Set-CapaGroupFolder.md)

## Capa.PowerShell.Module.SDK.Inventory

* [Convert-CapaDataType](Functions/Convert-CapaDataType.md)
* [Get-CapaCustomInventoryCategoriesAndEntries](Functions/Get-CapaCustomInventoryCategoriesAndEntries.md)
* [Get-CapaCustomInventoryForUnit](Functions/Get-CapaCustomInventoryForUnit.md)
* [Get-CapaHardwareInventoryForUnit](Functions/Get-CapaHardwareInventoryForUnit.md)
* [Get-CapaLogonHistoryForUnit](Functions/Get-CapaLogonHistoryForUnit.md)
* [Get-CapaMeteringGroups](Functions/Get-CapaMeteringGroups.md)
* [Get-CapaSoftwareInventoryForUnit](Functions/Get-CapaSoftwareInventoryForUnit.md)
* [Get-CapaUpdateInventoryForUnit](Functions/Get-CapaUpdateInventoryForUnit.md)
* [Get-CapaUserInventory](Functions/Get-CapaUserInventory.md)
* [Set-CapaCustomInventory](Functions/Set-CapaCustomInventory.md)
* [Set-CapaHardwareInventory](Functions/Set-CapaHardwareInventory.md)

## Capa.PowerShell.Module.SDK.MDM

* [Add-CapaEnforcePasscodeAndroid](Functions/Add-CapaEnforcePasscodeAndroid.md)
* [Add-CapaExchangePayloadToProfile](Functions/Add-CapaExchangePayloadToProfile.md)
* [Add-CapaKeyValueToAppConfigAndroid](Functions/Add-CapaKeyValueToAppConfigAndroid.md)
* [Add-CapaKeyValueToAppConfigIOS](Functions/Add-CapaKeyValueToAppConfigIOS.md)
* [Add-CapaUnitToProfile](Functions/Add-CapaUnitToProfile.md)
* [Add-CapaWifiPayloadToProfile](Functions/Add-CapaWifiPayloadToProfile.md)
* [Assign-CapaProfileToBusinessUnit](Functions/Assign-CapaProfileToBusinessUnit.md)
* [Clone-CapaDeviceApplication](Functions/Clone-CapaDeviceApplication.md)
* [Create-CapaProfile](Functions/Create-CapaProfile.md)
* [Edit-CapaExchangePayload](Functions/Edit-CapaExchangePayload.md)
* [Edit-CapaWifiPayload](Functions/Edit-CapaWifiPayload.md)
* [Get-CapaDeviceApplications](Functions/Get-CapaDeviceApplications.md)
* [Get-CapaProfiles](Functions/Get-CapaProfiles.md)
* [Link-CapaProfileToGroup](Functions/Link-CapaProfileToGroup.md)
* [Remove-CapaProfileFromDevice](Functions/Remove-CapaProfileFromDevice.md)
* [Unlink-CapaUnitFromProfile](Functions/Unlink-CapaUnitFromProfile.md)

## Capa.PowerShell.Module.SDK.OSDeployment

* [Get-CapaOSDiskConfigration](Functions/Get-CapaOSDiskConfigration.md)
* [Get-CapaOSImages](Functions/Get-CapaOSImages.md)
* [Get-CapaOSInstallationTypes](Functions/Get-CapaOSInstallationTypes.md)
* [Get-CapaOSPoints](Functions/Get-CapaOSPoints.md)
* [Get-CapaOSServers](Functions/Get-CapaOSServers.md)

## Capa.PowerShell.Module.SDK.Package

* [Add-CapaPackageToBusinessUnit](Functions/Add-CapaPackageToBusinessUnit.md)
* [Add-CapaPackageToGroup](Functions/Add-CapaPackageToGroup.md)
* [Add-CapaPackageToManagementServer](Functions/Add-CapaPackageToManagementServer.md)
* [Clone-CapaPackage](Functions/Clone-CapaPackage.md)
* [Copy-CapaPackage](Functions/Copy-CapaPackage.md)
* [Copy-CapaPackageRelation](Functions/Copy-CapaPackageRelation.md)
* [Create-CapaPackage](Functions/Create-CapaPackage.md)
* [Disable-CapaPackageSchedule](Functions/Disable-CapaPackageSchedule.md)
* [Enable-CapaPackageSchedule](Functions/Enable-CapaPackageSchedule.md)
* [Exist-CapaPackage](Functions/Exist-CapaPackage.md)
* [Export-CapaPackage](Functions/Export-CapaPackage.md)
* [Get-CapaAllInventoryPackages](Functions/Get-CapaAllInventoryPackages.md)
* [Get-CapaPackageDescription](Functions/Get-CapaPackageDescription.md)
* [Get-CapaPackageFolder](Functions/Get-CapaPackageFolder.md)
* [Get-CapaPackageGroups](Functions/Get-CapaPackageGroups.md)
* [Get-CapaPackages](Functions/Get-CapaPackages.md)
* [Get-CapaPackagesOnManagementServer](Functions/Get-CapaPackagesOnManagementServer.md)
* [Get-CapaPackageStatus](Functions/Get-CapaPackageStatus.md)
* [Get-CapaPackageUnits](Functions/Get-CapaPackageUnits.md)
* [Get-CapatAllNoneInventoryPackages](Functions/Get-CapatAllNoneInventoryPackages.md)
* [Import-CapaPackage](Functions/Import-CapaPackage.md)
* [Initialize-CapaPackagePromote](Functions/Initialize-CapaPackagePromote.md)
* [New-CapaPackageWithGit](Functions/New-CapaPackageWithGit.md)
* [New-CapaPowerPack](Functions/New-CapaPowerPack.md)
* [Remove-CapaPackage](Functions/Remove-CapaPackage.md)
* [Remove-CapaPackageFromGroup](Functions/Remove-CapaPackageFromGroup.md)
* [Remove-CapaPackageFromManagementServer](Functions/Remove-CapaPackageFromManagementServer.md)
* [Set-CapaPackageDescription](Functions/Set-CapaPackageDescription.md)
* [Set-CapaPackageFolder](Functions/Set-CapaPackageFolder.md)
* [Set-CapaPackagePriority](Functions/Set-CapaPackagePriority.md)
* [Set-CapaPackageSchedule](Functions/Set-CapaPackageSchedule.md)
* [Update-CapaPackageNow](Functions/Update-CapaPackageNow.md)
* [Update-CapaPackageScriptAndKit](Functions/Update-CapaPackageScriptAndKit.md)

## Capa.PowerShell.Module.SDK.SystemSdk

* [Count-CapaConscomActions](Functions/Count-CapaConscomActions.md)
* [Get-CapaBusinessUnits](Functions/Get-CapaBusinessUnits.md)
* [Get-CapaExternalTools](Functions/Get-CapaExternalTools.md)
* [Get-CapaManagementPoint](Functions/Get-CapaManagementPoint.md)
* [Get-CapaManagementServers](Functions/Get-CapaManagementServers.md)
* [Rebuild-CapaKitFileOnManagementServer](Functions/Rebuild-CapaKitFileOnManagementServer.md)
* [Rebuild-CapaKitFileOnPoint](Functions/Rebuild-CapaKitFileOnPoint.md)
* [Reset-CapaLastRunDateOnGlobalTask](Functions/Reset-CapaLastRunDateOnGlobalTask.md)

## Capa.PowerShell.Module.SDK.Unit

* [Add-CapaPrinterToUnit](Functions/Add-CapaPrinterToUnit.md)
* [Add-CapaUnitToBusinessUnit](Functions/Add-CapaUnitToBusinessUnit.md)
* [Add-CapaUnitToCalendarGroup](Functions/Add-CapaUnitToCalendarGroup.md)
* [Add-CapaUnitToFolder](Functions/Add-CapaUnitToFolder.md)
* [Add-CapaUnitToGroup](Functions/Add-CapaUnitToGroup.md)
* [Add-CapaUnitToPackage](Functions/Add-CapaUnitToPackage.md)
* [Add-CapaUnitToReinstall](Functions/Add-CapaUnitToReinstall.md)
* [Create-CapaUnit](Functions/Create-CapaUnit.md)
* [Delete-CapaUnit](Functions/Delete-CapaUnit.md)
* [Exist-CapaUnit](Functions/Exist-CapaUnit.md)
* [Exist-CapaUnitLocation](Functions/Exist-CapaUnitLocation.md)
* [Exist-CapaUnitOnManagementPoint](Functions/Exist-CapaUnitOnManagementPoint.md)
* [Get-CapaUnitDescription](Functions/Get-CapaUnitDescription.md)
* [Get-CapaUnitFolder](Functions/Get-CapaUnitFolder.md)
* [Get-CapaUnitGroups](Functions/Get-CapaUnitGroups.md)
* [Get-CapaUnitLastRuntime](Functions/Get-CapaUnitLastRuntime.md)
* [Get-CapaUnitLinkedUnits](Functions/Get-CapaUnitLinkedUnits.md)
* [Get-CapaUnitLinkedUser](Functions/Get-CapaUnitLinkedUser.md)
* [Get-CapaUnitManagementPoint](Functions/Get-CapaUnitManagementPoint.md)
* [Get-CapaUnitManagementServerRelation](Functions/Get-CapaUnitManagementServerRelation.md)
* [Get-CapaUnitPackages](Functions/Get-CapaUnitPackages.md)
* [Get-CapaUnitPackageStatus](Functions/Get-CapaUnitPackageStatus.md)
* [Get-CapaUnitRelations](Functions/Get-CapaUnitRelations.md)
* [Get-CapaUnits](Functions/Get-CapaUnits.md)
* [Get-CapaUnitsInFolder](Functions/Get-CapaUnitsInFolder.md)
* [Get-CapaUnitWSUSGroup](Functions/Get-CapaUnitWSUSGroup.md)
* [Remove-CapaUnitByUUID](Functions/Remove-CapaUnitByUUID.md)
* [Remove-CapaUnitFromBusinessUnit](Functions/Remove-CapaUnitFromBusinessUnit.md)
* [Remove-CapaUnitFromCalendarGroup](Functions/Remove-CapaUnitFromCalendarGroup.md)
* [Remove-CapaUnitFromGroup](Functions/Remove-CapaUnitFromGroup.md)
* [Remove-CapaUnitFromPackage](Functions/Remove-CapaUnitFromPackage.md)
* [Remove-CapaUnitFromReinstall](Functions/Remove-CapaUnitFromReinstall.md)
* [Rename-CapaUnit](Functions/Rename-CapaUnit.md)
* [Send-CapaUnitCommand](Functions/Send-CapaUnitCommand.md)
* [Set-CapaUnitDescription](Functions/Set-CapaUnitDescription.md)
* [Set-CapaUnitLabel](Functions/Set-CapaUnitLabel.md)
* [Set-CapaUnitName](Functions/Set-CapaUnitName.md)
* [Set-CapaUnitPackageStatus](Functions/Set-CapaUnitPackageStatus.md)
* [Set-CapaUnitStatus](Functions/Set-CapaUnitStatus.md)

## Capa.PowerShell.Module.SDK.User

* [Clear-CapaPrimaryUser](Functions/Clear-CapaPrimaryUser.md)
* [Get-CapaUsers](Functions/Get-CapaUsers.md)
* [Set-CapaPrimaryUser](Functions/Set-CapaPrimaryUser.md)

## Capa.PowerShell.Module.SDK.Utilities

* [Create-CapaADGroup](Functions/Create-CapaADGroup.md)
* [Get-CapaLog](Functions/Get-CapaLog.md)
* [Get-CapaReinstallStatus](Functions/Get-CapaReinstallStatus.md)
* [Move-CapaDeviceToPoint](Functions/Move-CapaDeviceToPoint.md)
* [Restart-CapaAgent](Functions/Restart-CapaAgent.md)
* [Set-CapaWakeOnLAN](Functions/Set-CapaWakeOnLAN.md)

## Capa.PowerShell.Module.SDK.VPP

* [Get-CapaDevicesLinkedToVppUser](Functions/Get-CapaDevicesLinkedToVppUser.md)
* [Get-CapaUsersLinkedToVppUser](Functions/Get-CapaUsersLinkedToVppUser.md)
* [Get-CapaVppPrograms](Functions/Get-CapaVppPrograms.md)
* [Get-CapaVppUsers](Functions/Get-CapaVppUsers.md)
* [Invite-CapaUnitToVppProgram](Functions/Invite-CapaUnitToVppProgram.md)

## Capa.PowerShell.Module.SDK.WSUS

* [Get-CapaWSUSGroups](Functions/Get-CapaWSUSGroups.md)
* [Get-CapaWSUSGroupUnits](Functions/Get-CapaWSUSGroupUnits.md)
* [Get-CapaWSUSPoints](Functions/Get-CapaWSUSPoints.md)
