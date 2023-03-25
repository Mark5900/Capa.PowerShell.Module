$RetValue = Shell_Execute @(
    Command = 'msiexec'
    Arguments = "/i `"$Packageroot\kit\GoogleChromeStandaloneEnterprise64.Msi`" /QN REBOOT=REALLYSUPPRESS ALLUSERS=1"
)
if ($RetValue -ne 0) { Exit-PSScript $RetValue }
Job_WriteLog -FunctionName 'Install' -Message "$AppName completed with status: $RetValue"