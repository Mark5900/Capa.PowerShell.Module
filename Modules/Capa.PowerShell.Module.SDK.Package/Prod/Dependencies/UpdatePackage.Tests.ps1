$Splat = @{
	BasePath               = 'C:\Temp'
	CapaServer             = 'CISERVER'
	SQLServer              = 'CISERVER'
	Database               = 'CapaInstaller'
	DefaultManagementPoint = 1
	PackageBasePath        = 'E:\CapaInstaller\CMPProduction\ComputerJobs'
}

New-CapaPackageWithGit @Splat -PackageName 'VB Normal' -PackageVersion 'v1.0' -PackageType VBScript
New-CapaPackageWithGit @Splat -PackageName 'VB Normal' -PackageVersion 'v1.1' -PackageType VBScript
New-CapaPackageWithGit @Splat -PackageName 'PP Normal' -PackageVersion 'v1.0' -PackageType PowerPack

New-CapaPackageWithGit @Splat -SoftwareName 'VB Advanced' -SoftwareVersion '1.0' -PackageType VBScript -Advanced
New-CapaPackageWithGit @Splat -SoftwareName 'PP Advanced' -SoftwareVersion '1.0' -PackageType PowerPack -Advanced