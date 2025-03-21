# Capa.PowerShell.Module.CCS

## How to create the CCSProxy.dll

1. In browser ogen CCSWebservice path like `https://mracapa02.capainstaller.com/CCSWebservice/CCS.asmx?WSDL`
2. Save site as `CCS.wsdl`
3. Run `Developer Powershell for VS 2022` as administrator
4. cd to the directory where `CCS.wsdl` is located
5. Run the following command to generate the proxy class:

```powershell
svcutil.exe .\CCS.wsdl /out:CCSProxy.cs /n:*,CapaProxy
```

6. Run the following command to generate the DLL:

```powershell
svcutil.exe .\CCS.wsdl /out:CCSProxy.cs /n:*,CapaProxy
```

## Example of using CCSProxy.dll

```powershell
Add-Type -Path 'C:\Users\Administrator\Downloads\CCSProxy.dll'

$binding = New-Object System.ServiceModel.BasicHttpBinding
$binding.Security.Mode = [System.ServiceModel.BasicHttpSecurityMode]::Transport
$binding.Security.Transport.ClientCredentialType = [System.ServiceModel.HttpClientCredentialType]::Basic

$endpoint = New-Object System.ServiceModel.EndpointAddress('https://mracapa02.capainstaller.com/CCSWebservice/CCS.asmx')
$client = New-Object CapaProxy.CCSSoapClient($binding, $endpoint)
$client.ClientCredentials.UserName.UserName = 'svc_capawebservice@firmax.local'
$client.ClientCredentials.UserName.Password = 'Admin1234'

$response = $client.ActiveDirectory_GetComputerNames('', 'Firmax.local', "Administrator", 'mOQXCLuC/rSkIrAQU3Ttbg==')
```
