<#

.SYNOPSIS
This is for Publishing nuget packge of Senslib. See Task #2417

.DESCRIPTION
The script will get latest code from TFS, build the projects and generate pkgs & publish to nuget server.
Go to "Variables.ps1" to change paths according to your environment.

.PARAMETER Version
    The target version of SensLib. For example, 3.0.2
    
.EXAMPLE 
./RunDeployer.ps1

#>

$ErrorActionPreference = "Stop"

. .\Utility.ps1
. .\Config.ps1
. .\TfsHelper.ps1
. .\NuGetManager.ps1


#check Msbuild, todo: also check other program paths are correct.
Validate-Paths

Write-Host "PowerShell version" $Host.Version
Write-Host "Started at: $timeStamp"
$StopWatch = new-object system.diagnostics.stopwatch
$StopWatch.Start()

#[1]- Download the latest version
Get-Senslink3 -Version 'latest'

#[1.1]- Build the solution
Build-Solution

#[2]-read the version.txt file, TFS version
$tfsVersion = Read-Versions

#[3]-get version from user.
$usrVersion = Read-Host "Current version=$tfsVersion. Enter target version's number ?"
$usrVersion = $usrVersion.Trim()

#[4]-Validate Version format and Value should < current
$valid =[Version] $usrVersion
Validate-UserInputVersion -inputVersion $usrVersion -current $tfsVersion
VersionGreaterOrEqual -firstVer $usrVersion -secondVr $tfsVersion

#[5] Update AssemblyInfo.cs files &Version.txt
Update-Vesions -fileVersion $usrVersion

#[6]- create lable and get realse notes. Also check in code. loc: TfsHelper.sp1
Create-Lable-ReleaseNotes-CheckIn $usrVersion $tfsVersion

Create-NugetPkg -nugetLibVersion $usrVersion

$timeStamp = $(((get-date)).ToString("yyyy-MM-ddT-hh_mm_ss"))
Write-Host "Finish at: $timeStamp"

$StopWatch.Stop()
$Minutes = $StopWatch.Elapsed.TotalMinutes
Write-Host "Elapsed.TotalMinutes = $Minutes"

Write-Host "Successfully, finished building and Publishing to Nuget..." -ForegroundColor Green
#>