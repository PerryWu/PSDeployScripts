param ([Parameter(Mandatory=$true)] [String] $Version ) #Senslink3.0 version or use latest
<#

.SYNOPSIS
This is for depolyment of Senslink 3.0 Console&Web Applications

.DESCRIPTION
The script will get code from TFS, build the projects and copy required propjects to "To Deploy" folder.
Go to "Variables.ps1" to change paths according to your environment.

.PARAMETER Version
    Either latest or specific label version like (Senslink3.0-V1.0.6)
    
.EXAMPLE 
./RunDeployer.ps1 -Version latest

#>
$ErrorActionPreference = "Stop"

. .\Utility.ps1
. .\Variables.ps1
. .\DownloadFilesFromTFS.ps1

#1- Download specific version of Senslink3.0   Senslink3.0-V1.0.6
Get-Senslink3 -Version $Version

#2- Build the Solution
Write-Host "Solution Location"
    Write-Host $seslink3Sln
    &$nuget restore $seslink3Sln
    #&$msbuild $seslink3Sln  /t:Rebuild /p:Configuration=Release /p:Platform="Any CPU"        
    
#3- Deploy prgrams
    Deploy-Console
    Deploy-Web

Write-Host "Finished building and Copying projects ..."
Write-Host "PowerShell" $Host.Version

$timeStamp = $(((get-date)).ToString("yyyy-MM-ddT-hh_mm_ss"))
Write-Host "Finish time: $timeStamp"