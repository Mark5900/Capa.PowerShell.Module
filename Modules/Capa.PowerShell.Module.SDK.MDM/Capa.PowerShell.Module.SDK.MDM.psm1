<#
	.SYNOPSIS
		Link profile to a device.
	
	.DESCRIPTION
		The Add-CapaUnitToProfile function links a profile to a device.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER UnitName
		The unit name of the unit.
	
	.PARAMETER Uuid
		The UUID of the unit.
	
	.PARAMETER ProfileName
		The name of the MDM profile.
	
	.PARAMETER ChangelogComment
		A comment that will be added to the changelog.
	
	.EXAMPLE
		PS C:\> Add-CapaUnitToProfile -CapaSDK $CapaSDK -UnitName 'Testdev01' -ProfileName 'Wi-Fi settings'

	.EXAMPLE
		PS C:\> Add-CapaUnitToProfile -CapaSDK $CapaSDK -Uuid '4eea2959-fb4c-4afe-b61f-810cb3019cd6' -ProfileName 'Wi-Fi settings'

	.EXAMPLE
		PS C:\> Add-CapaUnitToProfile -CapaSDK $CapaSDK -UnitName 'Testdev01' -ProfileName 'Wi-Fi settings' -ChangelogComment 'Linking profile to device'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246463/Link+profile+to+device
#>
function Add-CapaUnitToProfile {
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
	
	switch ($PsCmdlet.ParameterSetName) {
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
		Unlink profile from a device.
	
	.DESCRIPTION
		This will unlink a profile from a device and not remove the profile from the physical device.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER UnitName
		The unit name of the unit.
	
	.PARAMETER ProfileName
		The name of the MDM profile.
	
	.PARAMETER ChangelogComment
		A comment that will be added to the changelog.
	
	.PARAMETER Uuid
		The UUID of the unit.
	
	.EXAMPLE
		PS C:\> Unlink-CapaUnitFromProfile -CapaSDK $CapaSDK -UnitName 'Testdev01' -ProfileName 'Wi-Fi settings'

	.EXAMPLE
		PS C:\> Unlink-CapaUnitFromProfile -CapaSDK $CapaSDK -Uuid '4eea2959-fb4c-4afe-b61f-810cb3019cd6' -ProfileName 'Wi-Fi settings'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246474/Unlink+profile+from+device
#>
function Unlink-CapaUnitFromProfile {
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
	
	switch ($PsCmdlet.ParameterSetName) {
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
		This function will remove a profile from a device.
	
	.DESCRIPTION
		This function will remove a profile from a device, subsequently when the device reports successful removal of the profile, the relation is then removed from the database
	
	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UnitName
		The unit name of the unit.
	
	.PARAMETER UUID
		The UUID of the unit.
	
	.PARAMETER ProfileName
		The name of the MDM profile.
	
	.PARAMETER ChangelogComment
		The comment that will be added to the changelog.
	
	.EXAMPLE
		PS C:\> Remove-CapaProfileFromDevice -CapaSDK $CapaSDK -UnitName 'Testdev01' -ProfileName 'Wi-Fi settings'

	.EXAMPLE
		PS C:\> Remove-CapaProfileFromDevice -CapaSDK $CapaSDK -Uuid '4eea2959-fb4c-4afe-b61f-810cb3019cd6' -ProfileName 'Wi-Fi settings'

	.EXAMPLE
		PS C:\> Remove-CapaProfileFromDevice -CapaSDK $CapaSDK -UnitName 'Testdev01' -ProfileName 'Wi-Fi settings' -ChangelogComment 'Removing profile from device'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246487/Remove+profile+from+device
#>
function Remove-CapaProfileFromDevice {
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
	
	switch ($PsCmdlet.ParameterSetName) {
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
		This will add a new Exchange payload to a profile.
	
	.DESCRIPTION
		This will add a new Exchange payload to a profile.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER ProfileID
		The ID of the profile you wish to add the Exchange payload to.
	
	.PARAMETER AccountName
		Name of the Exchange ActiveSync/Web Services account.
	
	.PARAMETER DomainandUserName
		The domain and username of the Exchange account.
		If missing, the devices prompts for it during profile installation.
	
	.PARAMETER Password
		The password of the Exchange account.
	
	.PARAMETER EmailAddress
		Specifies the full email address for the account. The owners (primary user) email address must be injected upon delivery to the device.
		If not present in the payload, the device prompts for this string during profile installation.
	
	.PARAMETER ExchangeActiveSyncHost
		Specifies the Exchange server host name (or IP address).
	
	.PARAMETER UseSSL
		Specifies whether the Exchange server uses SSL for authentication.
	
	.PARAMETER PastDaysofMailtoSync
		The number of past days of mail to synchronize. No limit = 0. Allowed values: 0,1,3,7,14,31.
	
	.PARAMETER AllowMove
		Optional. Default false. If set to true, messages may not be moved out of this email account into another account.
		Also prevents forwarding or replying from a different account than the message was originated from.
	
	.PARAMETER UseOnlyinMail
		Optional. Default false. If set to true, this account will not be available for sending mail in third party applications.
	
	.PARAMETER UseSMIME
		Optional. Default false. If set to true, this account supports S/MIME.
	
	.PARAMETER AllowRecentAddressSyncing
		If true, this account is excluded from address Recents syncing. This defaults to false.
	
	.PARAMETER Syncinterval
		How often the device will sync with the Exchange server. Allowed values: Automatic Push, Manually, 15 minutes, 30 minutes, 60 minutes.
	
	.PARAMETER SyncEmail
		Whether to synchronize email between the device and the server.
	
	.PARAMETER SyncCalendar
		Whether to synchronize calendar between the device and the server.
	
	.PARAMETER SyncContacts
		Whether to synchronize contacts between the device and the server.
	
	.PARAMETER SyncTasks
		Whether to synchronize tasks between the device and the server.
	
	.PARAMETER ChangelogComment
		Comment you wish to be added to the changelog.
	
	.EXAMPLE
		PS C:\> Add-CapaExchangePayloadToProfile -CapaSDK $CapaSDK @(
			ID = 1
			AccountName = 'Test'
			DomainandUserName = 'tre@myco.com'
			Password = '123456'
			EmailAddress = 'tre@myco.com'
			ExchangeActiveSyncHost = 'outlook.office365.com'
			UseSSL = 'True'
			PastDaysofMailtoSync = 14
			AllowMove = 'True'
			UseOnlyinMail = 'False'
			UseSMIME = 'False'
			AllowRecentAddressSyncing = 'True'
			Syncinterval = '30 minutes'
			SyncEmail = 'True'
			SyncCalendar = 'True'
			SyncContacts = 'True'
			SyncTasks = 'True'
			ChangelogComment = 'Adding Exchange payload to profile'
		)
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246500/Add+Exchange+Payload+to+Profile
#>
function Add-CapaExchangePayloadToProfile {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$ProfileID,
		[Parameter(Mandatory = $true)]
		[string]$AccountName,
		[Parameter(Mandatory = $false)]
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
		Add a new WiFi payload to a profile.
	
	.DESCRIPTION
		Add a new WiFi payload to a profile.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER ProfileID
		The ID of the profile to add the payload to.
	
	.PARAMETER NetworkName
		The name of the WiFi network the devices should join. This is a mandatory parameter.
	
	.PARAMETER HiddenNetwork
		Enable if target network is not open or broadcasting.
	
	.PARAMETER AutoJoin
		Automatically join this wireless network.
	
	.PARAMETER SecurityType
		The type of WiFi security used on the WiFi network. Options are: None, WEP, WPA and Any.
	
	.PARAMETER Password
		The password used to authenticate against the WiFi network. This setting is mandatory if SecurityType is WEP, WPA or Any.
	
	.PARAMETER ProxyType
		Configures proxy settings to be used with this network. Options are: Automatic, Manual, None.
	
	.PARAMETER ProxyServer
		The proxy server's network address. Mandatory if proxyType is Manual.
	
	.PARAMETER ProxyPort
		The proxy server's port. Mandatory if proxyType is Manual.
	
	.PARAMETER ProxyAuthentication
		The username used to authenticate to the proxy server. Mandatory if proxyType is Manual.
	
	.PARAMETER ProxyPassword
		The password used to authenticate to the proxy server. Mandatory if proxyType is Manual.
	
	.PARAMETER ProxyServerConfigURL
		The URL of the PAC file that defines the proxy configuration. Mandatory if proxyType is Automatic.
	
	.PARAMETER ChangelogComment
		The comment you wish to be added to the changelog.
	
	.EXAMPLE
		PS C:\> Add-CapaWifiPayloadToProfile @(
			CapaSDK = $CapaSDK
			ProfileID = 1
			NetworkName = 'MyWiFiNetwork'
			HiddenNetwork = $false
			AutoJoin = $true
			SecurityType = 'WPA'
			Password = '12345678'
			ProxyType = 'None'
			ProxyServer = ''
			ProxyPort = ''
			ProxyAuthentication = ''
			ProxyPassword = ''
			ProxyServerConfigURL = ''
			ChangelogComment = 'Adding WiFi payload to profile'
		)
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246510/Add+WiFi+Payload+to+Profile
#>
function Add-CapaWifiPayloadToProfile {
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
	
	if ($Password -eq '' -and $SecurityType -ne 'None') {
		Write-Error "Password cannot be NULL when choosing SecurityType: $SecurityType"
	} elseif ($ProxyType -eq 'Manual' -and $ProxyServer -eq '') {
		Write-Error "ProxyServer cannot be NULL when choosing ProxyType: $ProxyType"
	} elseif ($ProxyType -eq 'Manual' -and $ProxyPort -eq '') {
		Write-Error "ProxyPort cannot be NULL when choosing ProxyType: $ProxyType"
	} elseif ($ProxyType -eq 'Manual' -and $ProxyAuthentication -eq '') {
		Write-Error "ProxyAuthentication cannot be NULL when choosing ProxyType: $ProxyType"
	} elseif ($ProxyType -eq 'Manual' -and $ProxyPassword -eq '') {
		Write-Error "ProxyPassword cannot be NULL when choosing ProxyType: $ProxyType"
	} elseif ($ProxyType -eq 'Automatic' -and $ProxyServerConfigURL -eq '') {
		Write-Error "ProxyServerConfigURL cannot be NULL when choosing ProxyType: $ProxyType"
	} Else {
		$value = $CapaSDK.AddWifiPayloadToProfile($ProfileID, $NetworkName, $HiddenNetwork, $AutoJoin, $SecurityType, $Password, $ProxyType, $ProxyType, $ProxyServer, $ProxyPort, $ProxyAuthentication, $ProxyPassword, $ProxyServerConfigURL, $ChangelogComment)
		return $value
	}
}

<#
	.SYNOPSIS
		Add a new Enforce Passcode payload or edit an existing one.
	
	.DESCRIPTION
		Add a new Enforce Passcode payload or edit an existing payload in the specified profile.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER ProfileId
		The ID of the profile to add the payload to.
	
	.PARAMETER Passcode
		The passcode to enforce.
	
	.PARAMETER ChangelogComment
		The comment you wish to be added to the changelog.
	
	.EXAMPLE
		PS C:\> Add-CapaEnforcePasscodeAndroid -CapaSDK $CapaSDK -ProfileId 1 -Passcode '12345678' -ChangelogComment 'Adding Enforce Passcode payload to profile'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246520/Add+edit+Enforce+Passcode+Android
#>
function Add-CapaEnforcePasscodeAndroid {
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
		Add a new key/value setting to an existing AppConfig payload in the specified profile.
	
	.DESCRIPTION
		Add a new Key/Value setting to an existing AppConfig payload in the specified profile.
		If a setting with the specified key and type already exists, its value will be overwritten with the new value instead of creating a new setting.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER DeviceApplicationID
		The ID of the Device Application you wish to edit.
	
	.PARAMETER Key
		The key of the new setting.
	
	.PARAMETER Value
		The value of the new setting.
	
	.PARAMETER KeyValueType
		The type of the new setting. Valid types are: String, Bool, Hidden, Integer
	
	.PARAMETER ChangelogComment
		the comment you wish to be added to the changelog.
	
	.EXAMPLE
		PS C:\> Add-CapaKeyValueToAppConfigAndroid -CapaSDK $CapaSDK -DeviceApplicationID 1 -Key 'AllowSync' -Value 'True' -KeyValueType 'Bool' -ChangelogComment 'Adding new key/value setting to AppConfig payload'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246531/Add+edit+Key+Value+setting+to+Android+AppConfig
#>
function Add-CapaKeyValueToAppConfigAndroid {
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
		Add a new key/value setting to an existing AppConfig payload in the specified profile.
	
	.DESCRIPTION
		Add a new Key/Value setting to an existing AppConfig payload in the specified profile.
		If a setting with the specified key and type already exists, its value will be overwritten with the new value instead of creating a new setting.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER DeviceApplicationID
		The id of the Device Application you wish to edit.
	
	.PARAMETER Key
		The Key of the new setting.
	
	.PARAMETER Value
		The Value of the new setting.
	
	.PARAMETER KeyValueType
		The type of the new setting. Valid types are: String, Boolean, Int, Float, DateTime. (DateTime format: dd-MM-yyyy HH:mm:ss).
	
	.PARAMETER ChangelogComment
		The comment you wish to be added to the changelog.
	
	.EXAMPLE
		PS C:\> Add-CapaKeyValueToAppConfigIOS -CapaSDK $CapaSDK -DeviceApplicationID 1 -Key 'AllowSync' -Value 'True' -KeyValueType 'Boolean' -ChangelogComment 'Adding new key/value setting to AppConfig payload'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246542/Add+edit+Key+Value+setting+to+iOS+AppConfig
#>
function Add-CapaKeyValueToAppConfigIOS {
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
		Assign a profile to a business unit.
	
	.DESCRIPTION
		Assign a profile to a business unit.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER ProfileId
		The ID of the profile you wish to assign to a business unit.
	
	.PARAMETER BusinessUnitName
		The name of the business unit you wish to assign the profile to.
	
	.PARAMETER ChangelogComment
		The comment you wish to be added to the changelog.
	
	.EXAMPLE
		PS C:\> Assign-CapaProfileToBusinessUnit -CapaSDK $CapaSDK -ProfileId 1 -BusinessUnitName 'My Business Unit' -ChangelogComment 'Assigning profile to business unit'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246552/Assign+Profile+to+Business+Unit
#>
function Assign-CapaProfileToBusinessUnit {
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
		Clone an existing Device Application and its payloads.
	
	.DESCRIPTION
		Clone an existing Device Application and its payloads.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER DeviceApplicationID
		The id of the Device Application you wish to clone.
	
	.PARAMETER NewName
		The name of the new Device Application.
	
	.PARAMETER ChangelogComment
		The comment you wish to be added to the changelog.
	
	.EXAMPLE
		PS C:\> Clone-CapaDeviceApplication -CapaSDK $CapaSDK -DeviceApplicationID 1 -NewName 'My New Device Application' -ChangelogComment 'Cloning Device Application'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246561/Clone+Device+Application
#>
function Clone-CapaDeviceApplication {
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
		Create a new profile in the Default Management Point.
	
	.DESCRIPTION
		Create a new profile in the Default Management Point. If BusinessUnitName is specified, the profile will be linked to the specified business unit.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER Name
		The name of the new profile.
	
	.PARAMETER Description
		The description of the new profile.
	
	.PARAMETER Priority
		The priority of the new profile.

	.PARAMETER BusinessUnitName
		The name of the business unit you wish to assign the profile to.
	
	.PARAMETER ChangelogComment
		The comment you wish to be added to the changelog.
	
	.EXAMPLE
		PS C:\> Create-CapaProfile -CapaSDK $CapaSDK -Name 'My Profile' -Description 'My Profile Description' -Priority 1 -ChangelogComment 'Creating new profile'

	.EXAMPLE
		PS C:\> Create-CapaProfile -CapaSDK $CapaSDK -Name 'My Profile' -Description 'My Profile Description' -Priority 1 -ChangelogComment 'Creating new profile' -BusinessUnitName 'My Business Unit'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246572/Create+Profile
		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246582/Create+Profile+in+Business+Unit
#>
function Create-CapaProfile {
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
	
	if ($BusinessUnitId -eq '') {
		$value = $CapaSDK.CreateProfile($Name, $Description, $Priority, $ChangelogComment)
	} else {
		$value = $CapaSDK.CreateProfileInBusinessUnit($Name, $Description, $Priority, $ChangelogComment, $BusinessUnitId)
	}
	
	return $value
}


<#
	.SYNOPSIS
		Editing an existing Exchange Payload.
	
	.DESCRIPTION
		Editing an existing Exchange Payload in the specified profile.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER ProfileID
		The ID of the profile you wish to add the exchange payload to.
	
	.PARAMETER CurrentAccountName
		The account name of the exchange payload you wish to edit.
	
	.PARAMETER AccountName
		Name for the Exchange ActiveSync/Web Services Account.
	
	.PARAMETER DomainandUserName
		This string specifies the user name for this Exchange account. If missing, the devices prompts for it during profile installation.
		Format is  "<domain>\<username>"  e.g. "mydomain.com\$LoginName$"
	
	.PARAMETER Password
		Optional. The password of the account. Use only with encrypted profiles.
	
	.PARAMETER EmailAddress
		Specifies the full email address for the account. The owners (primary user) email address must be injected upon delivery to the device.
		If not present in the payload, the device prompts for this string during profile installation. In OS X, this key is required.
	
	.PARAMETER ExchangeActiveSyncHost
		Specifies the Exchange server host name (or IP address). In OS X, this key is required.
	
	.PARAMETER UseSSL
		Specifies whether the Exchange server uses SSL for authentication.
	
	.PARAMETER PastDaysofMailtoSync
		The number of past days of mail to syncronize. No limit = 0. Allowed values: 0,1,3,7,14,31.
	
	.PARAMETER AllowMove
		Optional. Default false. If set to true, messages may not be moved out of this email account into another account.
		Also prevents forwarding or replying from a different account than the message was originated from.
	
	.PARAMETER UseOnlyinMail
		Optional. Default false. If set to true, this account will not be available for sending mail in third party applications.
	
	.PARAMETER UseSMIME
		Optional. Default false. If set to true, this account supports S/MIME.
	
	.PARAMETER AllowRecentAddressSyncing
		If true, this account is excluded from address Recents syncing. This defaults to false.
	
	.PARAMETER Syncinterval
		How often the device will sync with the Exchange server. Allowed values: Automatic Push, Manually, 15 minutes, 30 minutes, 60 minutes.
	
	.PARAMETER SyncEmail
		Whether to synchronize calendar between the device and the server.
	
	.PARAMETER SyncContacts
		Whether to synchronize contacts between the device and the server.
	
	.PARAMETER SyncTasks
		Whether to synchronize tasks between the device and the server.
	
	.PARAMETER ChangelogComment
		Comment to add to the changelog when calling this function.
	
	.EXAMPLE
		PS C:\> Edit-CapaExchangePayload @(
			CapaSDK = $CapaSDK
			ProfileID = 1
			CurrentAccountName = "Test"
			AccountName = "Test"
			DomainandUserName = "Domain\Test"
			Password = "1234"
			EmailAddress = "Test@Test.com"
			ExchangeActiveSyncHost = "outlook.office365.com"
			UseSSL = $true
			PastDaysofMailtoSync = 7
			AllowMove = $true
			UseOnlyinMail = $false
			UseSMIME = $false
			AllowRecentAddressSyncing = $true
			syncinterval = "30 minutes"
			SyncEmail = $true
			SyncContacts = $true
			SyncTasks = $false
			ChangelogComment = "Editing Exchange Payload"
		)
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246594/Edit+Exchange+Payload
#>
function Edit-CapaExchangePayload {
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
		Edit an existing WiFi payload.
	
	.DESCRIPTION
		Edit an existing WiFi payload in the specified profile.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER ProfileID
		The ID of the profile you wish to edit.

	.PARAMETER CurrentNetworkName
		The network name (SSID) of the wifi payload you wish to edit.
	
	.PARAMETER NetworkName
		The name of the WiFi network the devices should join. This is a mandatory parameter.
	
	.PARAMETER HiddenNetwork
		Enable if target network is not open or broadcasting.
	
	.PARAMETER AutoJoin
		Automatically join this wireless network.
	
	.PARAMETER SecurityType
		The type of WiFi security used on the WiFi network. Options are: None, WEP, WPA and Any.
	
	.PARAMETER Password
		The password used to authenticate against the WiFi network. This setting is mandatory if securityType is WEP, WPA or Any.
	
	.PARAMETER ProxyType
		Configures proxy settings to be used with this network. Options are: Automatic, Manual, None.
	
	.PARAMETER ProxyServer
		The proxy server's network address. Mandatory if proxyType is Manual.
	
	.PARAMETER ProxyPort
		The proxy server's port. Mandatory if proxyType is Manual.
	
	.PARAMETER ProxyAuthentication
		The username used to authenticate to the proxy server. Mandatory if proxyType is Manual.
	
	.PARAMETER ProxyPassword
		The password used to authenticate to the proxy server. Mandatory if proxyType is Manual.
	
	.PARAMETER ProxyServerConfigURL
		AThe URL of the PAC file that defines the proxy configuration. Mandatory if proxyType is Automatic.
	
	.PARAMETER ChangelogComment
		Comment you wish to be added to the changelog.
	
	.EXAMPLE
				PS C:\> Edit-CapaWifiPayload @(
					CapaSDK = $CapaSDK
					ProfileID = 1
					CurrentNetworkName = "Test"
					NetworkName = "Test"
					HiddenNetwork = $false
					AutoJoin = $true
					SecurityType = "WEP"
					Password = "1234567890"
					ProxyType = "None"
					ProxyServer = ""
					ProxyPort = ""
					ProxyAuthentication = ""
					ProxyPassword = ""
					ProxyServerConfigURL = ""
					ChangelogComment = "Editing WiFi Payload"
				)
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246604/Edit+WiFi+Payload
#>
function Edit-CapaWifiPayload {
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
	
	if ($Password -eq '' -and $SecurityType -ne 'None') {
		Write-Error "Password cannot be NULL when choosing SecurityType: $SecurityType"
	} elseif ($ProxyType -eq 'Manual' -and $ProxyServer -eq '') {
		Write-Error "ProxyServer cannot be NULL when choosing ProxyType: $ProxyType"
	} elseif ($ProxyType -eq 'Manual' -and $ProxyPort -eq '') {
		Write-Error "ProxyPort cannot be NULL when choosing ProxyType: $ProxyType"
	} elseif ($ProxyType -eq 'Manual' -and $ProxyAuthentication -eq '') {
		Write-Error "ProxyAuthentication cannot be NULL when choosing ProxyType: $ProxyType"
	} elseif ($ProxyType -eq 'Manual' -and $ProxyPassword -eq '') {
		Write-Error "ProxyPassword cannot be NULL when choosing ProxyType: $ProxyType"
	} elseif ($ProxyType -eq 'Automatic' -and $ProxyServerConfigURL -eq '') {
		Write-Error "ProxyServerConfigURL cannot be NULL when choosing ProxyType: $ProxyType"
	} Else {
		$value = $CapaSDK.EditWifiPayload($ProfileID, $CurrentNetworkName, $NetworkName, $HiddenNetwork, $AutoJoin, $SecurityType, $Password, $ProxyType, $ProxyType, $ProxyServer, $ProxyPort, $ProxyAuthentication, $ProxyPassword, $ProxyServerConfigURL, $ChangelogComment)
		return $value
	}
}

<#
	.SYNOPSIS
		Get all the Device Applications.
	
	.DESCRIPTION
		Get all the Device Applications from the Default Management Point.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.EXAMPLE
		PS C:\> Get-CapaDeviceApplications -CapaSDK $CapaSDK
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246614/Get+Device+Applications
#>
function Get-CapaDeviceApplications {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetDeviceApplications()
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID          = $aItem[0];
			Name        = $aItem[1];
			Description = $aItem[2];
			Priority    = $aItem[3];
			Version     = $aItem[4];
			CMPID       = $aItem[5];
			GUID        = $aItem[6]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		Get all profiles.
	
	.DESCRIPTION
		Get all profiles from the Default Management Point.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.EXAMPLE
		PS C:\> Get-CapaProfiles -CapaSDK $CapaSDK
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246626/Get+Profiles
#>
function Get-CapaProfiles {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetProfiles()
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID          = $aItem[0];
			Name        = $aItem[1];
			Description = $aItem[2];
			Priority    = $aItem[3];
			Version     = $aItem[4];
			CMPID       = $aItem[5];
			GUID        = $aItem[6]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		Link an existing profile to a group.
	
	.DESCRIPTION
		LINK an existing profile to a group.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER ProfileId
		The ID of the profile.
	
	.PARAMETER GroupName
		The name of the Group.
	
	.PARAMETER GroupType
		The type of the Group.
	
	.PARAMETER BusinessUnitName
		The name of the Business Unit where the group is located. If en empty string is specified, the group will be found in Global.
	
	.PARAMETER ChangelogComment
		A comment that will be added to the changelog entry on the proifile and the group.
	
	.EXAMPLE
		PS C:\> Link-CapaProfileToGroup -CapaSDK $CapaSDK -ProfileId 1 -GroupName 'Test Group' -GroupType 'Static'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246638/Link+profile+to+group
#>
function Link-CapaProfileToGroup {
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