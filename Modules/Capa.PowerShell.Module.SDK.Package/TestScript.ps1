function New-CapaPowerPack {
    param (
        [Parameter(Mandatory = $true)]
        $CapaSDK,
        [Parameter(Mandatory = $true)]
        [String]$PackageName,
        [Parameter(Mandatory = $true)]
        [String]$PackageVersion,
        [Parameter(Mandatory = $true)]
        [string]$DisplayName,
        [String]$InstallScriptContent = '',
        [String]$UninstallScriptContent = '',
        [String]$KitFolderPath = ''
    )
    $XMLFile = "$PSScriptRoot\Dependecies\ciPackage.xml"
    $TempFolder = "C:\Users\$env:UserName\AppData\Local\CapaInstaller\CMS\TempScripts"
    $TempTempFolder = "$TempFolder\Temp"
    $PackageTempFolder = "$TempTempFolder\$($PackageName)_$($PackageVersion)"
    $PackageZipFile = "$TempTempFolder\$($PackageName)_$($PackageVersion).zip"

    # Create Temp Folder
    If (!(Test-Path $TempFolder)) {
        New-Item -ItemType Directory -Path $TempTempFolder -Force | Out-Null
    }
    New-Item -ItemType Directory -Path "$PackageTempFolder\Zip" -Force | Out-Null
    New-Item -ItemType Directory -Path "$PackageTempFolder\Scripts" -Force | Out-Null

    # Create XML File
    $XML = [xml](Get-Content $XMLFile)
    $XML.Info.Package.Name = $PackageName
    $XML.Info.Package.Version = $PackageVersion
    $XML.Info.Package.DisplayName = $DisplayName

    If ($InstallScriptContent -ne '') {
        $InstallScriptContentBytes = [System.Text.Encoding]::UTF8.GetBytes("$InstallScriptContent")
        $XML.Info.Package.InstallScriptContent = [System.Convert]::ToBase64String($InstallScriptContentBytes)
    }

    If ($UninstallScriptContent -ne '') {
        $UninstallScriptContentBytes = [System.Text.Encoding]::UTF8.GetBytes("$UninstallScriptContent")
        $XML.Info.Package.UnInstallScriptContent = [System.Convert]::ToBase64String($UninstallScriptContentBytes)
    }

    $XML.Save("$PackageTempFolder\ciPackage.xml")

    # Create kit folder
    If ($KitFolderPath -ne '') {
        Copy-Item -Path $KitFolderPath -Destination "$PackageTempFolder\Kit" -Recurse -Force | Out-Null
    } else {
        New-Item -ItemType Directory -Path "$PackageTempFolder\Kit" -Force | Out-Null
        New-Item -ItemType File -Path "$PackageTempFolder\Kit\Dummy.txt" -Force | Out-Null
        Add-Content -Value 'Placeholder for the build of CapaInstaller.kit' -Path "$PackageTempFolder\Kit\Dummy.txt"
    }

    # Create zip file
    #TODO: Missing Zip and Scripts folder
    $Items = Get-ChildItem -Path $PackageTempFolder
    Compress-Archive -Path $Items -DestinationPath $PackageZipFile -Force | Out-Null

    #TODO: Add to CI
    #TODO: Remove Temp Folder
}

New-CapaPowerPack -CapaSDK '1' -PackageName 'Test1' -PackageVersion 'v1.0' -DisplayName 'Test1'
#New-CapaPowerPack -CapaSDK '1' -PackageName 'Test2' -PackageVersion 'v1.0' -DisplayName 'Test2' -InstallScriptContent "Write-Host 'Test2 Install Script'" -UninstallScriptContent "Write-Host 'Test2 Uninstall Script'"
#New-CapaPowerPack -CapaSDK '1' -PackageName 'Test3' -PackageVersion 'v1.0' -DisplayName 'Test3' -KitFolderPath 'D:\CapaInstaller\CMPProduction\ComputerJobs\7-Zip 22.00 EN\v2.0\Kit'