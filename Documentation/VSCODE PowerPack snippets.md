# VSCODE PowerPack snippets
This file contains snippets useful for PowerPacks.

## PowerPack template
In the installation or uninstallation script delete all and use the following snippet instead.
```json
    "PowerPackTemplateInstall": {
		"prefix": "PowerPackTemplateInstall",
		"body": [
			"[CmdletBinding()]",
			"Param(",
			"  [Parameter(Mandatory = $$true)]",
			"  [string]$$Packageroot,",
			"  [Parameter(Mandatory = $$true)]",
			"  [string]$$AppName,",
			"  [Parameter(Mandatory = $$true)]",
			"  [string]$$AppRelease,",
			"  [Parameter(Mandatory = $$true)]",
			"  [string]$$LogFile,",
			"  [Parameter(Mandatory = $$true)]",
			"  [string]$$TempFolder,",
			"  [Parameter(Mandatory = $$true)]",
			"  [string]$$DllPath,",
			"  [Parameter(Mandatory = $$false)]",
			"  [Object]$$InputObject = $$null",
			")",
			"",
			"Import-Module Capa.PowerShell.Module.PowerPack",
			"##################",
			"### PARAMETERS ###",
			"##################",
			"# DO NOT CHANGE",
			"[bool]$$global:DownloadPackage = $$true",
			"# Change as needed",
			"",
			"#################",
			"### FUNCTIONS ###",
			"#################",
			"function Begin {",
			"  param(",
			"    $$InputObject,",
			"    $$Packageroot,",
			"    $$AppName,",
			"    $$AppRelease,",
			"    $$LogFile,",
			"    $$TempFolder,",
			"    $$DllPath",
			"  )",
			"    ",
			"  ### Download package kit",
			"  [bool]$$global:DownloadPackage = $$true",
			"",
			"  ##############################################",
			"  #load core PS lib - don't mess with this!",
			"  if ($$InputObject) { $$pgkit = '' }else { $$pgkit = 'kit' }",
			"  Import-Module (Join-Path $$Packageroot $$pgkit 'PSlib.psm1') -ErrorAction stop",
			"  #load Library dll",
			"  $$Global:Cs = Add-PSDll",
			"  ##############################################",
			"",
			"  #Begin",
			"  Job_Start -JobType 'WS' -PackageName $$AppName -PackageVersion $$AppRelease -LogPath $$LogFile -Action 'INSTALL'",
			"  Log_SectionHeader -Name 'Begin'",
			"  Job_WriteLog -Text (\"[Init]: Starting package: '\" + $$AppName + \"' Release: '\" + $$AppRelease + \"'\")",
			"  If (!(Sys_IsMinimumRequiredDiskspaceAvailable -Drive 'c:' -MinimumRequiredDiskspace 1500)) { Exit-PSScript 3333 }",
			"  If ($$global:DownloadPackage -and $$InputObject) { Start-PSDownloadPackage }",
			"",
			"  Job_WriteLog -Text (\"[Init]: `$$PackageRoot:` '\" + $$Packageroot + \"'\")",
			"  Job_WriteLog -Text (\"[Init]: `$$AppName:` '\" + $$AppName + \"'\")",
			"  Job_WriteLog -Text (\"[Init]: `$$AppRelease:` '\" + $$AppRelease + \"'\")",
			"  Job_WriteLog -Text (\"[Init]: `$$LogFile:` '\" + $$LogFile + \"'\")",
			"  Job_WriteLog -Text (\"[Init]: `$$TempFolder:` '\" + $$TempFolder + \"'\")",
			"  Job_WriteLog -Text (\"[Init]: `$$DllPath:` '\" + $$DllPath + \"'\")",
			"  Job_WriteLog -Text (\"[Init]: `$$global:DownloadPackage`: '\" + $$global:DownloadPackage + \"'\")",
			"}",
			"",
			"function PreInstall {",
			"  Log_SectionHeader -Name 'PreInstall'",
			"}",
			"",
			"function Install {",
			"  Log_SectionHeader -Name 'Install'",
			"}",
			"",
			"function PostInstall {",
			"  Log_SectionHeader -Name 'PostInstall'",
			"}",
			"############",
			"### Main ###",
			"############",
			"try {",
			"  Begin -InputObject $$InputObject -Packageroot $$Packageroot -AppName $$AppName -AppRelease $$AppRelease -LogFile $$LogFile -TempFolder $$TempFolder -DllPath $$DllPath",
			"  PreInstall",
			"  Install",
			"  PostInstall",
			"  Exit-PSScript $$Error",
			"} catch {",
			"  $$line = $$_.InvocationInfo.ScriptLineNumber",
			"  Job_WriteLog -FunctionName '*****************' -Text \"Something bad happend at line $$($$line): $$($$_.Exception.Message)\"",
			"  Exit-PSScript $$_.Exception.HResult",
			"}",
			""
		]
	}
```

## Exe template
```json
"PowerPackExeExcution": {
		"prefix": "PowerPackExeExcution",
		"description": "Template for a PowerShell exe excution in CapaInstaller PowerPacks",
		"body": [
			"$$Command = \"$$Packageroot\\kit\\chrome.exe\"",
			"$$Arguments = '/SILENT'",
			"$RetValue = Shell_Execute -Command $$Command -Arguments $$Arguments",
			"",
			"if ($$RetValue -ne 0) { Exit-PSScript $RetValue }",
			"Job_WriteLog -FunctionName 'Install' -Text \"$$AppName completed with status: $$RetValue\""
		]
	}
```

## MSI template
```json
"PowerPackMsiExcution": {
		"prefix": "PowerPackMsiExcution",
		"description": "Template for a PowerShell msi excution in CapaInstaller PowerPacks",
		"body": [
			"$$Command = 'msiexec.exe'",
			"$$Arguments = \"/i `\"$$Packageroot\\kit\\GoogleChromeStandaloneEnterprise64.Msi`\" /QN REBOOT=REALLYSUPPRESS ALLUSERS=1\"",
			"$RetValue = Shell_Execute -Command $$Command -Arguments $$Arguments",
			"",
			"if ($$RetValue -ne 0) { Exit-PSScript $RetValue }",
			"Job_WriteLog -FunctionName 'Install' -Text \"$$AppName completed with status: $$RetValue\""
		]
	}
```