Trace-VstsEnteringInvocation $MyInvocation

$mode = "install"
$prefix = "s911ci"
$sitecoreAdminPassword = "b"
$installDirectory = "C:\websites\"
$scInstallRoot = "C:\sc911_install"
$solrUrl = "https://localhost:721/solr"
$solrRoot = "C:\solr\solr-7.2.1"
$solrService = "Solr-7.2.1"
$sqlServer = ".\SQLEXPRESS"
$sqlAdminUser = "sa"
$sqlAdminPassword = "Password12345"

$mode = Get-VstsInput -Name mode -Require
$prefix = Get-VstsInput -Name prefix -Require
$sitecoreAdminPassword = Get-VstsInput -Name sitecoreAdminPassword -Require
$installDirectory = Get-VstsInput -Name scInstallDirectory -Require
$scInstallRoot = Get-VstsInput -Name scInstallRoot -Require
$solrUrl = Get-VstsInput -Name solrUrl -Require
$solrRoot = Get-VstsInput -Name solrRoot -Require
$solrService = Get-VstsInput -Name solrService -Require
$sqlServer = Get-VstsInput -Name sqlServer -Require
$sqlAdminUser = Get-VstsInput -Name sqlAdminUser -Require
$sqlAdminPassword = Get-VstsInput -Name sqlAdminPassword -Require

Write-Host "prefix $prefix"
Write-Host "mode $mode"
Write-Host "sitecoreAdminPassword $sitecoreAdminPassword"
Write-Host "installDirectory $installDirectory"
Write-Host "scInstallRoot $scInstallRoot"
Write-Host "solrUrl $solrUrl"
Write-Host "solrRoot $solrRoot"
Write-Host "solrService $solrService"
Write-Host "sqlServer $sqlServer"
Write-Host "sqlAdminUser $sqlAdminUser"
Write-Host "sqlAdminPassword $sqlAdminPassword"

$XConnectSiteName = "$prefix.xconnect"
$SitecoreSiteName = "$prefix.sc"
$IdentityServerSiteName = "$prefix.identityserver"
$LicenseFile = "$scInstallRoot\license.xml"
$XConnectPackage = (Get-ChildItem "$scInstallRoot\Sitecore 9* rev. * (OnPrem)_xp0xconnect.scwdp.zip").FullName
$SitecorePackage = (Get-ChildItem "$scInstallRoot\Sitecore 9* rev. * (OnPrem)_single.scwdp.zip").FullName
$IdentityServerPackage = (Get-ChildItem "$scInstallRoot\Sitecore.IdentityServer * rev. * (OnPrem)_identityserver.scwdp.zip").FullName
$PasswordRecoveryUrl = "http://$SitecoreSiteName"
$SitecoreIdentityAuthority = "https://$IdentityServerSiteName"
$XConnectCollectionService = "https://$XConnectSiteName"
$ClientSecret = "SIF-Default"
$AllowedCorsOrigins = "http://$SitecoreSiteName"

# Install XP0 via combined partials file.
$singleDeveloperParams = @{
    Path = "$scInstallRoot\XP0-SingleDeveloper.json"
	InstallDirectory = $installDirectory
    SqlServer = $sqlServer
    SqlAdminUser = $sqlAdminUser
    SqlAdminPassword = $sqlAdminPassword
    SitecoreAdminPassword = $sitecoreAdminPassword
    SolrUrl = $solrUrl
    SolrRoot = $solrRoot
    SolrService = $solrService
    Prefix = $prefix
    XConnectCertificateName = $XConnectSiteName
    IdentityServerCertificateName = $IdentityServerSiteName
    IdentityServerSiteName = $IdentityServerSiteName
    LicenseFile = $LicenseFile
    XConnectPackage = $XConnectPackage
    SitecorePackage = $SitecorePackage
    IdentityServerPackage = $IdentityServerPackage
    XConnectSiteName = $XConnectSiteName
    SitecoreSitename = $SitecoreSiteName
    PasswordRecoveryUrl = $PasswordRecoveryUrl
    SitecoreIdentityAuthority = $SitecoreIdentityAuthority
    XConnectCollectionService = $XConnectCollectionService
    ClientSecret = $ClientSecret
    AllowedCorsOrigins = $AllowedCorsOrigins
}

Import-Module SitecoreInstallFramework
Push-Location $SCInstallRoot

if($mode -eq "install"){
    Write-Host "Running Install-SitecoreConfiguration"
    Install-SitecoreConfiguration @singleDeveloperParams *>&1 | Tee-Object XP0-SingleDeveloper.log
}
else {
    Write-Host "Running Uninstall-SitecoreConfiguration"
    Uninstall-SitecoreConfiguration @singleDeveloperParams *>&1 | Tee-Object XP0-SingleDeveloper-Uninstall.log
}

Pop-Location
