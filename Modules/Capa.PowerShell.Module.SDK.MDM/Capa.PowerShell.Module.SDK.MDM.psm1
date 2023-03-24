<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246463/Link+profile+to+device
	
	.DESCRIPTION
		A detailed description of the Add-CapaUnitToProfile function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER Uuid
		A description of the Uuid parameter.
	
	.PARAMETER ProfileName
		A description of the ProfileName parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment  parameter.
	
	.EXAMPLE
				PS C:\> Add-CapaUnitToProfile -Uuid 'Value1'
	
	.NOTES
		Additional information about the function.
#>
function Add-CapaUnitToProfile
{
	[CmdletBinding()]
	[Alias('Link-CapaUnitToProfile')]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(ParameterSetName = 'NameType',
				   Mandatory = $true)]
		[String]$UnitName,
		[Parameter(ParameterSetName = 'Uuid',
				   Mandatory = $true)]
		[String]$Uuid,
		[Parameter(Mandatory = $true)]
		[String]$ProfileName,
		[Parameter(Mandatory = $false)]
		[String]$ChangelogComment
	)
	
	switch ($PsCmdlet.ParameterSetName)
	{
		'Uuid' {
			$value = $CapaSDK.AddUnitToProfile($UnitName, $ProfileName, $ChangelogComment)
			break
		}
		'NameType' {
			$value = $CapaSDK.AddUnitToProfile($Uuid, $ProfileName, $ChangelogComment)
			break
		}
	}
	
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246474/Unlink+profile+from+device
	
	.DESCRIPTION
		A detailed description of the Unlink-CapaUnitFromProfile function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER ProfileName
		A description of the ProfileName parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment parameter.
	
	.PARAMETER Uuid
		A description of the Uuid parameter.
	
	.EXAMPLE
				PS C:\> Unlink-CapaUnitFromProfile -Uuid 'Value1'
	
	.NOTES
		Additional information about the function.
#>
function Unlink-CapaUnitFromProfile
{
	[CmdletBinding(DefaultParameterSetName = 'Uuid')]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(ParameterSetName = 'NameType',
				   Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[String]$ProfileName,
		[Parameter(Mandatory = $true)]
		[String]$ChangelogComment,
		[Parameter(ParameterSetName = 'Uuid',
				   Mandatory = $true)]
		[String]$Uuid
	)
	
	switch ($PsCmdlet.ParameterSetName)
	{
		'NameType' {
			$value = $CapaSDK.UnlinkUnitFromProfile($UnitName, $ProfileName, $ChangelogComment)
			break
		}
		'Uuid' {
			$value = $CapaSDK.UnlinkUnitFromProfile($Uuid, $ProfileName, $ChangelogComment)
			break
		}
	}
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246487/Remove+profile+from+device
	
	.DESCRIPTION
		A detailed description of the Remove-CapaProfileFromDevice function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UUID
		A description of the UUID  parameter.
	
	.PARAMETER ProfileName
		A description of the ProfileName parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment  parameter.
	
	.EXAMPLE
				PS C:\> Remove-CapaProfileFromDevice -UnitName 'Value1'
	
	.NOTES
		Additional information about the function.
#>
function Remove-CapaProfileFromDevice
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(ParameterSetName = 'NameType',
				   Mandatory = $true)]
		[String]$UnitName,
		[Parameter(ParameterSetName = 'Uuid',
				   Mandatory = $true)]
		[String]$UUID,
		[Parameter(Mandatory = $true)]
		[String]$ProfileName,
		[Parameter(Mandatory = $true)]
		[String]$ChangelogComment
	)
	
	switch ($PsCmdlet.ParameterSetName)
	{
		'NameType' {
			$value = $CapaSDK.RemoveUnitFromProfile($UnitName, $ProfileName, $ChangelogComment)
			break
		}
		'Uuid' {
			$value = $CapaSDK.RemoveUnitFromProfile($UUID, $ProfileName, $ChangelogComment)
			break
		}
	}
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246500/Add+Exchange+Payload+to+Profile
	
	.DESCRIPTION
		A detailed description of the Add-CapaExchangePayloadToProfile function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER ProfileID
		A description of the ProfileID parameter.
	
	.PARAMETER AccountName
		A description of the AccountName  parameter.
	
	.PARAMETER DomainandUserName
		A description of the DomainandUserName parameter.
	
	.PARAMETER Password
		A description of the Password parameter.
	
	.PARAMETER EmailAddress
		A description of the EmailAddress parameter.
	
	.PARAMETER ExchangeActiveSyncHost
		A description of the ExchangeActiveSyncHost parameter.
	
	.PARAMETER UseSSL
		A description of the UseSSL parameter.
	
	.PARAMETER PastDaysofMailtoSync
		A description of the PastDaysofMailtoSync parameter.
	
	.PARAMETER AllowMove
		A description of the AllowMove parameter.
	
	.PARAMETER UseOnlyinMail
		A description of the UseOnlyinMail parameter.
	
	.PARAMETER UseSMIME
		A description of the UseSMIME parameter.
	
	.PARAMETER AllowRecentAddressSyncing
		A description of the AllowRecentAddressSyncing parameter.
	
	.PARAMETER Syncinterval
		A description of the Syncinterval parameter.
	
	.PARAMETER SyncEmail
		A description of the SyncEmail parameter.
	
	.PARAMETER SyncCalendar
		A description of the SyncCalendar parameter.
	
	.PARAMETER SyncContacts
		A description of the SyncContacts parameter.
	
	.PARAMETER SyncTasks
		A description of the SyncTasks parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment  parameter.
	
	.EXAMPLE
		PS C:\> Add-CapaExchangePayloadToProfile -CapaSDK $value1 -ProfileID $value2 -AccountName  'Value3' -DomainandUserName 'Value4' -Password $value5 -EmailAddress 'Value6' -ExchangeActiveSyncHost 'Value7' -UseSSL $value8
	
	.NOTES
		Additional information about the function.
#>
function Add-CapaExchangePayloadToProfile
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$ProfileID,
		[Parameter(Mandatory = $true)]
		[string]$AccountName,
		[Parameter(Mandatory = $true)]
		[string]$DomainandUserName,
		[Parameter(Mandatory = $false)]
		[securestring]$Password = '',
		[Parameter(Mandatory = $true)]
		[string]$EmailAddress,
		[Parameter(Mandatory = $true)]
		[string]$ExchangeActiveSyncHost,
		[Parameter(Mandatory = $true)]
		[ValidateSet('True', 'False')]
		[bool]$UseSSL,
		[Parameter(Mandatory = $false)]
		[ValidateSet('0', '1', '3', '7', '14', '31')]
		[int]$PastDaysofMailtoSync = 0,
		[ValidateSet('True', 'False')]
		[bool]$AllowMove = $false,
		[ValidateSet('True', 'False')]
		[bool]$UseOnlyinMail = $false,
		[ValidateSet('True', 'False')]
		[bool]$UseSMIME = $false,
		[ValidateSet('False', 'True')]
		[bool]$AllowRecentAddressSyncing = $false,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Automatic Push', 'Manually', '15 minutes', '30 minutes', '60 minutes')]
		[string]$Syncinterval,
		[ValidateSet('False', 'True')]
		[bool]$SyncEmail = $false,
		[ValidateSet('False', 'True')]
		[bool]$SyncCalendar = $false,
		[ValidateSet('False', 'True')]
		[bool]$SyncContacts = $false,
		[ValidateSet('False', 'True')]
		[bool]$SyncTasks = $false,
		[string]$ChangelogComment = ''
	)
	
	$value = $CapaSDK.AddExchangePayloadToProfile($ProfileID, $AccountName, $DomainandUserName, $Password, $EmailAddress, $ExchangeActiveSyncHost, $UseSSL, $PastDaysofMailtoSync, $AllowMove, $UseOnlyinMail, $UseSMIME, $AllowRecentAddressSyncing, $Syncinterval, $SyncEmail, $SyncCalendar, $SyncContacts, $SyncTasks, $ChangelogComment)
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246510/Add+WiFi+Payload+to+Profile
	
	.DESCRIPTION
		A detailed description of the Add-CapaWifiPayloadToProfile function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER ProfileID
		A description of the ProfileID parameter.
	
	.PARAMETER NetworkName
		A description of the NetworkName parameter.
	
	.PARAMETER HiddenNetwork
		A description of the HiddenNetwork parameter.
	
	.PARAMETER AutoJoin
		A description of the AutoJoin parameter.
	
	.PARAMETER SecurityType
		A description of the SecurityType parameter.
	
	.PARAMETER Password
		A description of the Password parameter.
	
	.PARAMETER ProxyType
		A description of the ProxyType parameter.
	
	.PARAMETER ProxyServer
		A description of the ProxyServer parameter.
	
	.PARAMETER ProxyPort
		A description of the ProxyPort parameter.
	
	.PARAMETER ProxyAuthentication
		A description of the ProxyAuthentication parameter.
	
	.PARAMETER ProxyPassword
		A description of the ProxyPassword  parameter.
	
	.PARAMETER ProxyServerConfigURL
		A description of the ProxyServerConfigURL parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment parameter.
	
	.EXAMPLE
		PS C:\> Add-CapaWifiPayloadToProfile -CapaSDK $value1 -ProfileID $value2 -NetworkName 'Value3' -SecurityType None
	
	.NOTES
		Additional information about the function.
#>
function Add-CapaWifiPayloadToProfile
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$ProfileID,
		[Parameter(Mandatory = $true)]
		[string]$NetworkName,
		[ValidateSet('False', 'True')]
		[bool]$HiddenNetwork = $false,
		[ValidateSet('True', 'False')]
		[bool]$AutoJoin = $true,
		[Parameter(Mandatory = $true)]
		[ValidateSet('None', 'WEP', 'WPA', 'Any')]
		[string]$SecurityType,
		[string]$Password = '',
		[Parameter(Mandatory = $true)]
		[ValidateSet('Automatic', 'Manual', 'None')]
		[string]$ProxyType,
		[string]$ProxyServer = '',
		[string]$ProxyPort = '',
		[string]$ProxyAuthentication = '',
		[string]$ProxyPassword = '',
		[string]$ProxyServerConfigURL = '',
		[string]$ChangelogComment = ''
	)
	
	if ($Password -eq '' -and $SecurityType -ne 'None')
	{
		Write-Error "Password cannot be NULL when choosing SecurityType: $SecurityType"
	}
	elseif ($ProxyType -eq 'Manual' -and $ProxyServer -eq '')
	{
		Write-Error "ProxyServer cannot be NULL when choosing ProxyType: $ProxyType"
	}
	elseif ($ProxyType -eq 'Manual' -and $ProxyPort -eq '')
	{
		Write-Error "ProxyPort cannot be NULL when choosing ProxyType: $ProxyType"
	}
	elseif ($ProxyType -eq 'Manual' -and $ProxyAuthentication -eq '')
	{
		Write-Error "ProxyAuthentication cannot be NULL when choosing ProxyType: $ProxyType"
	}
	elseif ($ProxyType -eq 'Manual' -and $ProxyPassword -eq '')
	{
		Write-Error "ProxyPassword cannot be NULL when choosing ProxyType: $ProxyType"
	}
	elseif ($ProxyType -eq 'Automatic' -and $ProxyServerConfigURL -eq '')
	{
		Write-Error "ProxyServerConfigURL cannot be NULL when choosing ProxyType: $ProxyType"
	}
	Else
	{
		$value = $CapaSDK.AddWifiPayloadToProfile($ProfileID, $NetworkName, $HiddenNetwork, $AutoJoin, $SecurityType, $Password, $ProxyType, $ProxyType, $ProxyServer, $ProxyPort, $ProxyAuthentication, $ProxyPassword, $ProxyServerConfigURL, $ChangelogComment)
		return $value
	}
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246520/Add+edit+Enforce+Passcode+Android
	
	.DESCRIPTION
		A detailed description of the Add-CapaEnforcePasscodeAndroid function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER ProfileId
		A description of the ProfileId parameter.
	
	.PARAMETER Passcode
		A description of the Passcode  parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment parameter.
	
	.EXAMPLE
		PS C:\> Add-CapaEnforcePasscodeAndroid
	
	.NOTES
		Additional information about the function.
#>
function Add-CapaEnforcePasscodeAndroid
{
	[CmdletBinding()]
	[Alias('Edit-CapaEnforcePasscodeAndroid')]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$ProfileId,
		[Parameter(Mandatory = $true)]
		[string]$Passcode,
		$ChangelogComment = ''
	)
	
	$value = $CapaSDK.AddEditEnforcePasscodeAndroid($ProfileId, $Passcode, $ChangelogComment)
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246531/Add+edit+Key+Value+setting+to+Android+AppConfig
	
	.DESCRIPTION
		A detailed description of the Add-KeyValueToAppConfigAndroid function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER DeviceApplicationID
		A description of the DeviceApplicationID  parameter.
	
	.PARAMETER Key
		A description of the Key parameter.
	
	.PARAMETER Value
		A description of the Value  parameter.
	
	.PARAMETER KeyValueType
		A description of the KeyValueType parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment parameter.
	
	.EXAMPLE
				PS C:\> Add-KeyValueToAppConfigAndroid -CapaSDK $value1 -DeviceApplicationID  $value2 -Key 'Value3' -Value  'Value4' -KeyValueType String
	
	.NOTES
		Additional information about the function.
#>
function Add-CapaKeyValueToAppConfigAndroid
{
	[CmdletBinding()]
	[Alias('Edit-CapaKeyValueToAppConfigAndroid')]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$DeviceApplicationID,
		[Parameter(Mandatory = $true)]
		[string]$Key,
		[Parameter(Mandatory = $true)]
		[string]$Value,
		[Parameter(Mandatory = $true)]
		[ValidateSet('String', 'Bool', 'Hidden', 'Integer')]
		$KeyValueType,
		$ChangelogComment = ''
	)
	
	$value = $CapaSDK.AddKeyValueToAppConfigAndroid($DeviceApplicationID, $Key, $Value, $KeyValueType, $ChangelogComment)
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246542/Add+edit+Key+Value+setting+to+iOS+AppConfig
	
	.DESCRIPTION
		A detailed description of the Add-KeyValueToAppConfigIOS function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER DeviceApplicationID
		A description of the DeviceApplicationID  parameter.
	
	.PARAMETER Key
		A description of the Key  parameter.
	
	.PARAMETER Value
		A description of the Value  parameter.
	
	.PARAMETER KeyValueType
		A description of the KeyValueType parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment parameter.
	
	.EXAMPLE
		PS C:\> Add-KeyValueToAppConfigIOS
	
	.NOTES
		Additional information about the function.
#>
function Add-CapaKeyValueToAppConfigIOS
{
	[CmdletBinding()]
	[Alias('Edit-CapaKeyValueToAppConfigIOS')]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$DeviceApplicationID,
		[Parameter(Mandatory = $true)]
		[string]$Key,
		[Parameter(Mandatory = $true)]
		[string]$Value,
		[Parameter(Mandatory = $true)]
		[ValidateSet('String', 'Boolean', 'Int', 'Float', 'DateTime')]
		[string]$KeyValueType,
		[string]$ChangelogComment = ''
	)
	
	$value = $CapaSDK.AddKeyValueToAppConfigIOS($DeviceApplicationID, $Key, $Value, $KeyValueType, $ChangelogComment)
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246552/Assign+Profile+to+Business+Unit
	
	.DESCRIPTION
		A detailed description of the Assign-CapaProfileToBusinessUnit function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER ProfileId
		A description of the ProfileId parameter.
	
	.PARAMETER BusinessUnitName
		A description of the BusinessUnitName parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment parameter.
	
	.EXAMPLE
				PS C:\> Assign-CapaProfileToBusinessUnit -CapaSDK $value1 -ProfileId $value2 -BusinessUnitName 'Value3'
	
	.NOTES
		Additional information about the function.
#>
function Assign-CapaProfileToBusinessUnit
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$ProfileId,
		[Parameter(Mandatory = $true)]
		[string]$BusinessUnitName,
		[string]$ChangelogComment = ''
	)
	
	$value = $CapaSDK.AssignProfileToBusinessUnit($ProfileId, $BusinessUnitName, $ChangelogComment)
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246561/Clone+Device+Application
	
	.DESCRIPTION
		A detailed description of the Clone-CapaDeviceApplication function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER DeviceApplicationID
		A description of the DeviceApplicationID  parameter.
	
	.PARAMETER NewName
		A description of the NewName  parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment parameter.
	
	.EXAMPLE
				PS C:\> Clone-CapaDeviceApplication -CapaSDK $value1 -DeviceApplicationID  $value2 -NewName  'Value3'
	
	.NOTES
		Additional information about the function.
#>
function Clone-CapaDeviceApplication
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$DeviceApplicationID,
		[Parameter(Mandatory = $true)]
		[string]$NewName,
		[string]$ChangelogComment = ''
	)
	
	$value = $CapaSDK.CloneDeviceApplication($DeviceApplicationID, $NewName, $ChangelogComment)
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246572/Create+Profile
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246582/Create+Profile+in+Business+Unit
	
	.DESCRIPTION
		A detailed description of the Create-CapaProfile function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER Name
		A description of the Name parameter.
	
	.PARAMETER Description
		A description of the Description parameter.
	
	.PARAMETER Priority
		A description of the Priority parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment parameter.
	
	.EXAMPLE
				PS C:\> Create-CapaProfile -CapaSDK $value1 -Name 'Value2' -Description 'Value3' -Priority $value4
	
	.NOTES
		Additional information about the function.
#>
function Create-CapaProfile
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$Name,
		[Parameter(Mandatory = $true)]
		[string]$Description,
		[Parameter(Mandatory = $true)]
		[int]$Priority,
		[string]$ChangelogComment = '',
		[string]$BusinessUnitId = ''
	)
	
	if ($BusinessUnitId -eq '')
	{
		$value = $CapaSDK.CreateProfile($Name, $Description, $Priority, $ChangelogComment)
	}
	else
	{
		$value = $CapaSDK.CreateProfileInBusinessUnit($Name, $Description, $Priority, $ChangelogComment, $BusinessUnitId)
	}
	
	return $value
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246594/Edit+Exchange+Payload
	
	.DESCRIPTION
		A detailed description of the Edit-ExchangePayload function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER ProfileID
		A description of the ProfileID parameter.
	
	.PARAMETER CurrentAccountName
		A description of the CurrentAccountName parameter.
	
	.PARAMETER AccountName
		A description of the AccountName parameter.
	
	.PARAMETER DomainandUserName
		A description of the DomainandUserName parameter.
	
	.PARAMETER Password
		A description of the Password parameter.
	
	.PARAMETER EmailAddress
		A description of the EmailAddress parameter.
	
	.PARAMETER ExchangeActiveSyncHost
		A description of the ExchangeActiveSyncHost parameter.
	
	.PARAMETER UseSSL
		A description of the UseSSL parameter.
	
	.PARAMETER PastDaysofMailtoSync
		A description of the PastDaysofMailtoSync parameter.
	
	.PARAMETER AllowMove
		A description of the AllowMove parameter.
	
	.PARAMETER UseOnlyinMail
		A description of the UseOnlyinMail parameter.
	
	.PARAMETER UseSMIME
		A description of the UseSMIME parameter.
	
	.PARAMETER AllowRecentAddressSyncing
		A description of the AllowRecentAddressSyncing parameter.
	
	.PARAMETER Syncinterval
		A description of the Syncinterval parameter.
	
	.PARAMETER SyncEmail
		A description of the SyncEmail parameter.
	
	.PARAMETER SyncContacts
		A description of the SyncContacts parameter.
	
	.PARAMETER SyncTasks
		A description of the SyncTasks parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment parameter.
	
	.EXAMPLE
				PS C:\> Edit-ExchangePayload -CapaSDK $value1 -ProfileID $value2 -CurrentAccountName 'Value3' -AccountName 'Value4' -DomainandUserName 'Value5' -EmailAddress 'Value6' -ExchangeActiveSyncHost 'Value7' -UseSSL True -Syncinterval 'Automatic Push'
	
	.NOTES
		Additional information about the function.
#>
function Edit-CapaExchangePayload
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$ProfileID,
		[Parameter(Mandatory = $true)]
		[string]$CurrentAccountName,
		[Parameter(Mandatory = $true)]
		[string]$AccountName,
		[Parameter(Mandatory = $true)]
		[string]$DomainandUserName,
		[Parameter(Mandatory = $false)]
		[securestring]$Password = '',
		[Parameter(Mandatory = $true)]
		[string]$EmailAddress,
		[Parameter(Mandatory = $true)]
		[string]$ExchangeActiveSyncHost,
		[Parameter(Mandatory = $true)]
		[ValidateSet('True', 'False')]
		[bool]$UseSSL,
		[Parameter(Mandatory = $false)]
		[ValidateSet('0', '1', '3', '7', '14', '31')]
		[int]$PastDaysofMailtoSync = 0,
		[ValidateSet('True', 'False')]
		[bool]$AllowMove = $false,
		[ValidateSet('True', 'False')]
		[bool]$UseOnlyinMail = $false,
		[ValidateSet('True', 'False')]
		[bool]$UseSMIME = $false,
		[ValidateSet('False', 'True')]
		[bool]$AllowRecentAddressSyncing = $false,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Automatic Push', 'Manually', '15 minutes', '30 minutes', '60 minutes')]
		[string]$Syncinterval,
		[ValidateSet('False', 'True')]
		[bool]$SyncEmail = $false,
		[ValidateSet('False', 'True')]
		[bool]$SyncContacts = $false,
		[ValidateSet('False', 'True')]
		[bool]$SyncTasks = $false,
		[string]$ChangelogComment = ''
	)
	
	$value = $CapaSDK.EditExchangePayload($ProfileID, $CurrentAccountName, $AccountName, $DomainandUserName, $Password, $EmailAddress, $ExchangeActiveSyncHost, $UseSSL, $PastDaysofMailtoSync, $AllowMove, $UseOnlyinMail, $UseSMIME, $AllowRecentAddressSyncing, $Syncinterval, $SyncEmail, $SyncContacts, $SyncTasks, $ChangelogComment)
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246604/Edit+WiFi+Payload
	
	.DESCRIPTION
		A detailed description of the Edit-CapaWifiPayload function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER ProfileID
		A description of the ProfileID parameter.
	
	.PARAMETER NetworkName
		A description of the NetworkName parameter.
	
	.PARAMETER HiddenNetwork
		A description of the HiddenNetwork parameter.
	
	.PARAMETER AutoJoin
		A description of the AutoJoin parameter.
	
	.PARAMETER SecurityType
		A description of the SecurityType parameter.
	
	.PARAMETER Password
		A description of the Password parameter.
	
	.PARAMETER ProxyType
		A description of the ProxyType parameter.
	
	.PARAMETER ProxyServer
		A description of the ProxyServer parameter.
	
	.PARAMETER ProxyPort
		A description of the ProxyPort parameter.
	
	.PARAMETER ProxyAuthentication
		A description of the ProxyAuthentication parameter.
	
	.PARAMETER ProxyPassword
		A description of the ProxyPassword parameter.
	
	.PARAMETER ProxyServerConfigURL
		A description of the ProxyServerConfigURL parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment parameter.
	
	.EXAMPLE
				PS C:\> Edit-CapaWifiPayload -CapaSDK $value1 -ProfileID $value2 -NetworkName 'Value3' -SecurityType None -ProxyType Automatic
	
	.NOTES
		Additional information about the function.
#>
function Edit-CapaWifiPayload
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$ProfileID,
		[Parameter(Mandatory = $true)]
		[string]$CurrentNetworkName,
		[Parameter(Mandatory = $true)]
		[string]$NetworkName,
		[ValidateSet('False', 'True')]
		[bool]$HiddenNetwork = $false,
		[ValidateSet('True', 'False')]
		[bool]$AutoJoin = $true,
		[Parameter(Mandatory = $true)]
		[ValidateSet('None', 'WEP', 'WPA', 'Any')]
		[string]$SecurityType,
		[string]$Password = '',
		[Parameter(Mandatory = $true)]
		[ValidateSet('Automatic', 'Manual', 'None')]
		[string]$ProxyType,
		[string]$ProxyServer = '',
		[string]$ProxyPort = '',
		[string]$ProxyAuthentication = '',
		[string]$ProxyPassword = '',
		[string]$ProxyServerConfigURL = '',
		[string]$ChangelogComment = ''
	)
	
	if ($Password -eq '' -and $SecurityType -ne 'None')
	{
		Write-Error "Password cannot be NULL when choosing SecurityType: $SecurityType"
	}
	elseif ($ProxyType -eq 'Manual' -and $ProxyServer -eq '')
	{
		Write-Error "ProxyServer cannot be NULL when choosing ProxyType: $ProxyType"
	}
	elseif ($ProxyType -eq 'Manual' -and $ProxyPort -eq '')
	{
		Write-Error "ProxyPort cannot be NULL when choosing ProxyType: $ProxyType"
	}
	elseif ($ProxyType -eq 'Manual' -and $ProxyAuthentication -eq '')
	{
		Write-Error "ProxyAuthentication cannot be NULL when choosing ProxyType: $ProxyType"
	}
	elseif ($ProxyType -eq 'Manual' -and $ProxyPassword -eq '')
	{
		Write-Error "ProxyPassword cannot be NULL when choosing ProxyType: $ProxyType"
	}
	elseif ($ProxyType -eq 'Automatic' -and $ProxyServerConfigURL -eq '')
	{
		Write-Error "ProxyServerConfigURL cannot be NULL when choosing ProxyType: $ProxyType"
	}
	Else
	{
		$value = $CapaSDK.EditWifiPayload($ProfileID, $CurrentNetworkName, $NetworkName, $HiddenNetwork, $AutoJoin, $SecurityType, $Password, $ProxyType, $ProxyType, $ProxyServer, $ProxyPort, $ProxyAuthentication, $ProxyPassword, $ProxyServerConfigURL, $ChangelogComment)
		return $value
	}
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246614/Get+Device+Applications
	
	.DESCRIPTION
		A detailed description of the Get-CapaDeviceApplications function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaDeviceApplications -CapaSDK $value1
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaDeviceApplications
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetDeviceApplications()
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID		    = $aItem[0];
			Name	    = $aItem[1];
			Description = $aItem[2];
			Priority    = $aItem[3];
			Version	    = $aItem[4];
			CMPID	    = $aItem[5];
			GUID	    = $aItem[6]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246626/Get+Profiles
	
	.DESCRIPTION
		A detailed description of the Get-CapaProfiles function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaProfiles -CapaSDK $value1
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaProfiles
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetProfiles()
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID		    = $aItem[0];
			Name	    = $aItem[1];
			Description = $aItem[2];
			Priority    = $aItem[3];
			Version	    = $aItem[4];
			CMPID	    = $aItem[5];
			GUID	    = $aItem[6]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246638/Link+profile+to+group
	
	.DESCRIPTION
		A detailed description of the Link-CapaProfileToGroup function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER ProfileId
		A description of the ProfileId parameter.
	
	.PARAMETER GroupName
		A description of the GroupName parameter.
	
	.PARAMETER GroupType
		A description of the GroupType parameter.
	
	.PARAMETER BusinessUnitName
		A description of the BusinessUnitName parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment parameter.
	
	.EXAMPLE
				PS C:\> Link-CapaProfileToGroup -CapaSDK $value1 -ProfileId $value2 -GroupName 'Value3' -GroupType AD
	
	.NOTES
		Additional information about the function.
#>
function Link-CapaProfileToGroup
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$ProfileId,
		[Parameter(Mandatory = $true)]
		[string]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('AD', 'Department', 'Dynamic', 'Static')]
		[string]$GroupType,
		[string]$BusinessUnitName = '',
		[string]$ChangelogComment = ''
	)
	
	$value = $CapaSDK.AddProfileToGroup($ProfileId, $GroupName, $GroupType, $BusinessUnitName, $ChangelogComment)
	return $value
}