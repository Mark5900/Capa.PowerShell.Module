$RetValue = Shell_Execute @(
    Command = "$Packageroot\kit\chrome.exe"
    Arguments = '/SILENT'
)
if ($RetValue -ne 0) { Exit-PSScript $RetValue }
Job_WriteLog -FunctionName 'Install' -Message "$AppName completed with status: $RetValue"