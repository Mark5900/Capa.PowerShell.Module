# Capa.PowerShell.Module
This modules is made to use [CapaInstaller Software Development Kit functions](https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246085/SDK+-+CapaInstaller+Software+Development+Kit+functions) in PowerShell 7.
Any help and feedback is welcome! 😁

## Installation
There is two ways to install the module.
But both ways also needs you to fulfill the requirements that can be found [here](https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246085/SDK+-+CapaInstaller+Software+Development+Kit+functions).

### With MSI 🤖
Run the [installer](https://github.com/Mark5900/Capa.PowerShell.Module/blob/1fa8b8e3503760ac9a3909eb69fa40fed2bbbf3a/Installers/Capa.PowerShell.Module.msi)
### Copy paste the files 📂
To one of the paths you find when running
```powershell
$env:PSModulePath
```
Create a folder called "Capa.PowerShell.Module" and copy-paste [Capa.PowerShell.Module.psd1](Capa.PowerShell.Module.psd1) & [Capa.PowerShell.Module.psm1](Capa.PowerShell.Module.psm1)