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
			"$$Global:Packageroot = $$Packageroot",
			"$$Global:AppName = $$AppName",
			"$$Global:AppRelease = $$AppRelease",
			"$$Global:LogFile = $$LogFile",
			"$$Global:TempFolder = $$TempFolder",
			"$$Global:DllPath = $$DllPath",
			"$$Global:InputObject = $$InputObject",
			"# Change as needed",
			"",
			"#################",
			"### FUNCTIONS ###",
			"#################",
			"function Begin {",
			"  ##############################################",
			"  #load Library dll",
			"  $Global:Cs = Add-PpDll -DllPath $Global:DllPath",
			"  ##############################################",
			"",
			"  #Begin",
			"  Job_Start -JobType 'WS' -PackageName $$Global:AppName -PackageVersion $$Global:AppRelease -LogPath $$Global:LogFile -Action 'INSTALL'",
			"  Log_SectionHeader -Name 'Begin'",
			"  Job_WriteLog -Text (\"[Init]: Starting package: '\" + $$Global:AppName + \"' Release: '\" + $$Global:AppRelease + \"'\")",
			"  If (!(Sys_IsMinimumRequiredDiskspaceAvailable -Drive 'c:' -MinimumRequiredDiskspace 1500)) { Exit-PpMissingDiskSpace }",
			"  If ($$global:DownloadPackage -and $$Global:InputObject) { Start-PSDownloadPackage }",
			"",
			"  Job_WriteLog -Text (\"[Init]: `$$Global:Packageroot:` '\" + $$Global:Packageroot + \"'\")",
			"  Job_WriteLog -Text (\"[Init]: `$$Global:AppName:` '\" + $$Global:AppName + \"'\")",
			"  Job_WriteLog -Text (\"[Init]: `$$Global:AppRelease:` '\" + $$Global:AppRelease + \"'\")",
			"  Job_WriteLog -Text (\"[Init]: `$$Global:LogFile:` '\" + $$Global:LogFile + \"'\")",
			"  Job_WriteLog -Text (\"[Init]: `$$Global:TempFolder:` '\" + $$Global:TempFolder + \"'\")",
			"  Job_WriteLog -Text (\"[Init]: `$$Global:DllPath:` '\" + $$Global:DllPath + \"'\")",
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
			"  Begin -InputObject $$Global:InputObject -Packageroot $$Global:Packageroot -AppName $$Global:AppName -AppRelease $$Global:AppRelease -LogFile $$Global:LogFile -TempFolder $$Global:TempFolder -DllPath $$Global:DllPath",
			"  PreInstall",
			"  Install",
			"  PostInstall",
			"  Exit-PpScript $$Error",
			"} catch {",
			"  $$line = $$_.InvocationInfo.ScriptLineNumber",
			"  Job_WriteLog -FunctionName '*****************' -Text \"Something bad happend at line $$($$line): $$($$_.Exception.Message)\"",
			"  Exit-PpScript $$_.Exception.HResult",
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
			"$$Command = \"$$Global:Packageroot\\kit\\chrome.exe\"",
			"$$Arguments = '/SILENT'",
			"$RetValue = Shell_Execute -Command $$Command -Arguments $$Arguments",
			"",
			"if ($$RetValue -ne 0) { Exit-PpScript $RetValue }",
			"Job_WriteLog -FunctionName 'Install' -Text \"$$Global:AppName completed with status: $$RetValue\""
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
			"$$Arguments = \"/i `\"$$Global:Packageroot\\kit\\GoogleChromeStandaloneEnterprise64.Msi`\" /QN REBOOT=REALLYSUPPRESS ALLUSERS=1\"",
			"$RetValue = Shell_Execute -Command $$Command -Arguments $$Arguments",
			"",
			"if ($$RetValue -ne 0) { Exit-PpScript $RetValue }",
			"Job_WriteLog -FunctionName 'Install' -Text \"$$Global:AppName completed with status: $$RetValue\""
		]
	}
```