Trace-VstsEnteringInvocation $MyInvocation

$prefix = Get-VstsInput -Name prefix -Require
$sitecoreAdminPassword = Get-VstsInput -Name sitecoreAdminPassword -Require
$scInstallRoot = Get-VstsInput -Name scInstallRoot -Require
$solrUrl = Get-VstsInput -Name solrUrl -Require
$solrRoot = Get-VstsInput -Name solrRoot -Require
$solrService = Get-VstsInput -Name solrService -Require
$sqlServer = Get-VstsInput -Name sqlServer -Require
$sqlAdminUser = Get-VstsInput -Name sqlAdminUser -Require
$sqlAdminPassword = Get-VstsInput -Name sqlAdminPassword -Require

Write-Host "prefix $prefix"
Write-Host "sitecoreAdminPassword $sitecoreAdminPassword"
Write-Host "scInstallRoot $scInstallRoot"
Write-Host "solrUrl $solrUrl"
Write-Host "solrRoot $solrRoot"
Write-Host "solrService $solrService"
Write-Host "sqlServer $sqlServer"
Write-Host "sqlAdminUser $sqlAdminUser"
Write-Host "sqlAdminPassword $sqlAdminPassword"

Register-PSRepository -Name SitecoreGallery -SourceLocation https://sitecore.myget.org/F/sc-powershell/api/v2 -InstallationPolicy Trusted
Install-Module SitecoreInstallFramework -Force
Update-Module SitecoreInstallFramework

$XConnectSiteName = "$prefix.xconnect"
# The Sitecore site instance name.
$SitecoreSiteName = "$prefix.sc"
# Identity Server site name
$IdentityServerSiteName = "$prefix.identityserver"
# The Path to the license file
$LicenseFile = "$SCInstallRoot\license.xml"
# The path to the XConnect Package to Deploy.
$XConnectPackage = (Get-ChildItem "$SCInstallRoot\Sitecore 9.1.0 rev. * (OnPrem)_xp0xconnect.scwdp.zip").FullName
# The path to the Sitecore Package to Deploy.
$SitecorePackage = (Get-ChildItem "$SCInstallRoot\Sitecore 9.1.0 rev. * (OnPrem)_single.scwdp.zip").FullName
# The path to the Identity Server Package to Deploy.
$IdentityServerPackage = (Get-ChildItem "$SCInstallRoot\Sitecore.IdentityServer 2.0.0 rev. * (OnPrem)_identityserver.scwdp.zip").FullName
# The Identity Server password recovery URL, this should be the URL of the CM Instance
$PasswordRecoveryUrl = "http://$SitecoreSiteName"
# The URL of the Identity Server
$SitecoreIdentityAuthority = "https://$IdentityServerSiteName"
# The URL of the XconnectService
$XConnectCollectionService = "https://$XConnectSiteName"
# The random string key used for establishing connection with IdentityService. This will be regenerated if left on the default.
$ClientSecret = "SIF-Default"
# Pipe-separated list of instances (URIs) that are allowed to login via Sitecore Identity.
$AllowedCorsOrigins = "http://$SitecoreSiteName"
