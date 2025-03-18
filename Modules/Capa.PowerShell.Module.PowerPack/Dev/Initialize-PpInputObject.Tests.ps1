$Global:InputObject =	$null
Initialize-PpInputObject
$Global:InputObject.ShowMessageBox('MessageBox title', 'This is a test messageBox from a PowerPack (æøå). Please click one of the three buttons below', 'YESNOCANCEL', 'TWO', 'INFORMATION', 180, $false)