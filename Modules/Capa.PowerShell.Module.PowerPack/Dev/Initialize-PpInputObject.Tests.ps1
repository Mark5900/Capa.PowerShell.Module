$Global:InputObject =	$null
Initialize-PpInputObject
CMS_AddPackageToUnit -package 'findes ikke' -version 'v1.0'
CMS_AddPackageToUnit -package 'Test' -version 'v1.0'
$Global:InputObject.ShowMessageBox('MessageBox title', 'This is a test messageBox from a PowerPack (æøå). Please click one of the three buttons below', 'YESNOCANCEL', 'TWO', 'INFORMATION', 180, $false)