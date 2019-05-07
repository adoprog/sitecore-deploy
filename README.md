# Sitecore Deploy

<img src="/images/extension-icon.png" align="left" height="100" width="100" >

This extension aims to simplify repeatable deployments of your pull request, etc. builds to the DEV/QA environments. It only supports XP0 configuration as of now and therefore is not suitable for production deployes.

You still need to install SIF on a target machine, as well as make sure you have a proper Solr version, etc.

`Register-PSRepository -Name SitecoreGallery -SourceLocation https://sitecore.myget.org/F/sc-powershell/api/v2
Install-Module SitecoreInstallFramework`

Also, you need to install all prerequisites via `Install-SitecoreConfiguration -Path .\prerequisites.json`

If you're using SQL 2017, make sure to install https://www.microsoft.com/en-us/download/details.aspx?id=55114

Here's the sample guide on setting up Sitecore manually: https://buoctrenmay.com/2019/04/06/sitecore-xp-9-1-update-1-step-by-step-install-guide-on-your-machine/

<img src="/images/screenshot.png">
