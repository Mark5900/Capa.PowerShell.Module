# How to update module
- [ ] In every .psd1 file: Update ModuleVersion, RequiredVersion = '' and FunctionsToExport
- [ ] Update $Version in [CreateInstaller.ps1](../CreateInstaller.ps1) and run the file to create new MSI installer
- [ ] Delete old MSI installer 