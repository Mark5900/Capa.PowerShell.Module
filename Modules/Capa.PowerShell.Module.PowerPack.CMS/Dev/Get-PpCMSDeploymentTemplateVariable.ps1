# TODO: #291 Update Get-Help for Get-PpCMSDeploymentTemplateVariable
<#
	.SYNOPSIS
		Returns a variable from the deployment template linked to the current client

	.DESCRIPTION
		Returns a variable from the deployment template from which the client was installed. Alternatively, the
		template is fetched from the business unit that the client was linked to at installation time.

	.PARAMETER Section
		The name of the section in the template

	.PARAMETER Variable
		The name of the variable to return

	.PARAMETER MustExist
		True if the variable must exist, defaults is false

	.EXAMPLE
		$value = Get-PpCMSDeploymentTemplateVariable -Variable "title" -MustExist $true
		Job_WriteLog -Text "Title: $value"

	.EXAMPLE
		$value = Get-PpCMSDeploymentTemplateVariable -Section "domain" -Variable "joinDomain" -MustExist $true
		Job_WriteLog -Text "Join domain: $value"

	.NOTES
		Example configutation:
		{
			"operatingSystem": {
				"ImageId": 13,
				"diskConfigId": 1,
				"localAdmin": "true",
				"password": "15aarest"
			},
			"domain": {
				"joinDomain": "CAPADEMO.LOCAL",
				"domainName": "CAPADEMO.LOCAL",
				"domainUserName": "ciinst",
				"domainUserPassword": "dftgyhuj",
				"computerObjectOU": "OU=Computers,OU=Lazise,OU=Dev2,DC=CAPADEMO,DC=local"},
			"title": "Default",
			"customValues": [{
				"key": "a",
				"value": "1"
			}]
		}

#>
function Get-PpCMSDeploymentTemplateVariable {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $false)]
		[string]$Section = '',
		[Parameter(Mandatory = $true)]
		[string]$Variable,
		[Parameter(Mandatory = $false)]
		[bool]$MustExist = $false
	)

	return CMS_GetDeploymentTemplateVariable -section $Section -variable $Variable -mustexist $MustExist
}