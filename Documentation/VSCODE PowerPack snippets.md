# VSCODE PowerPack snippets
This file contains snippets useful for PowerPacks.

## PowerPack template
In the installation or uninstallation script delete all and use the following snippet instead.
```json
    "PowerPackTemplate": {
		"prefix": "PowerPackTemplate",
		"description": "Template for a PowerShell package in CapaInstaller",
		"body": [
			"[CmdletBinding()]",
			"Param(",
			"\t[Parameter(Mandatory = $$true)]",
			"\t[string]$$Packageroot,",
			"\t[Parameter(Mandatory = $$true)]",
			"\t[string]$$AppName,",
			"\t[Parameter(Mandatory = $$true)]",
			"\t[string]$$AppRelease,",
			"\t[Parameter(Mandatory = $$true)]",
			"\t[string]$$LogFile,",
			"\t[Parameter(Mandatory = $$true)]",
			"\t[string]$$TempFolder,",
			"\t[Parameter(Mandatory = $$true)]",
			"\t[string]$$DllPath,",
			"\t[Parameter(Mandatory = $$false)]",
			"\t[Object]$$InputObject = $$null",
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
			"\tparam(",
			"\t\t$$InputObject,",
			"\t\t$$Packageroot,",
			"\t\t$$AppName,",
			"\t\t$$AppRelease,",
			"\t\t$$LogFile,",
			"\t\t$$TempFolder,",
			"\t\t$$DllPath",
			"\t)",
			"",
			"\t\t##############################################",
			"\t\t#load core PS lib - don't mess with this!",
			"\t\tif ($$InputObject) { $$pgkit = '' }else { $$pgkit = 'kit' }",
			"\t\tImport-Module (Join-Path $$Packageroot $$pgkit 'PSlib.psm1') -ErrorAction stop",
			"\t\t#load Library dll",
			"\t\t$$Global:cs = Add-PSDll",
			"\t\t##############################################",
			"",
			"\t\tJob_Start -JobType WS -AppName $$AppName -AppRelease $$AppRelease -LogFile $$LogFile -JobAction INSTALL",
			"\t\tJob_WriteLog -Message (\"[Init]: Starting package: '\" + $$AppName + \"' Release: '\" + $$AppRelease + \"'\")",
			"\t\tIf (!(Sys_IsMinimumRequiredDiskspaceAvailable -DriveLetter 'c:' -RequiredSpace 1500)) { Exit-PSScript 3333 }",
			"\t\tIf ($$global:DownloadPackage -and $$InputObject) { Start-PSDownloadPackage }",
			"",
			"\t\tJob_WriteLog -Message (\"[Init]: `$$PackageRoot:` '\" + $$Packageroot + \"'\")",
			"\t\tJob_WriteLog -Message (\"[Init]: `$$AppName:` '\" + $$AppName + \"'\")",
			"\t\tJob_WriteLog -Message (\"[Init]: `$$AppRelease:` '\" + $$AppRelease + \"'\")",
			"\t\tJob_WriteLog -Message (\"[Init]: `$$LogFile:` '\" + $$LogFile + \"'\")",
			"\t\tJob_WriteLog -Message (\"[Init]: `$$TempFolder:` '\" + $$TempFolder + \"'\")",
			"\t\tJob_WriteLog -Message (\"[Init]: `$$DllPath:` '\" + $$DllPath + \"'\")",
			"\t\tJob_WriteLog -Message (\"[Init]: `$$global:DownloadPackage`: '\" + $$global:DownloadPackage + \"'\")",
			"}",
			"",
			"##############",
			"### SCRIPT ###",
			"##############",
			"try {",
			"\tBegin -InputObject $$InputObject -Packageroot $$Packageroot -AppName $$AppName -AppRelease $$AppRelease -LogFile $$LogFile -TempFolder $$TempFolder -DllPath $$DllPath",
			"\tExit-PSScript $$Error",
			"} catch {",
			"\t$$line = $$_.InvocationInfo.ScriptLineNumber",
			"\tJob_WriteLog -FunctionName '*****************' -Message (\"Something bad happend at line $$($$line): $$($$_.Exception.Message)\")",
			"\tExit-PSScript $$_.Exception.HResult",
			"}"
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
			"Job_WriteLog -FunctionName 'Install' -Message \"$$AppName completed with status: $$RetValue\""
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
			"Job_WriteLog -FunctionName 'Install' -Message \"$$AppName completed with status: $$RetValue\""
		]
	}
```