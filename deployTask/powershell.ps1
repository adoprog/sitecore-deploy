Trace-VstsEnteringInvocation $MyInvocation
Write-Host "InvocationName:" $MyInvocation.InvocationName
Write-Host "Path:" $MyInvocation.MyCommand.Path

$sitecoreVersion = Get-VstsInput -Name sitecoreVersion -Require
$ScriptPath = Split-Path $MyInvocation.MyCommand.Path

& "$ScriptPath\$sitecoreVersion\task.ps1"


