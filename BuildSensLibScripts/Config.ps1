﻿#---------------------------------------
#------------1-MsBuild------------------
#---------------------------------------
#VS 2019 enterprise
#$msbuild_2019 ='C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\MSBuild\Current\Bin\MSBuild.exe'
#VS 2019 Community uncomment line below.
$msbuild_2019 ='C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe'

#--------------------------------------
#------------2-TFS (DevOps)------------
#--------------------------------------
$tfs = "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\TF.exe"
#label prefix in TFS for the SensLib. For example, the result will be "Senslib-3.0.2"
$lblPrefix ='SensLib-'
$pdbTarget="net46"

#---------------------------------------
#------------3-Nuget--------------------
#---------------------------------------
$nuget ="nuget_cli\nuget.exe"
#$nugetServer = "http://issue.anasystem.com.tw:5555/"
$nugetServer = "http://192.168.12.67:5000/"
#====Notes:
#https://docs.microsoft.com/en-us/nuget/consume-packages/install-use-packages-nuget-cli
#$nuget ="C:\nuget.exe"



#---------------------------------------
#------4-SensLib Master or Branch-------
#---------------------------------------
#Important: no slash at the end!
$slnPath="$/Developing/SensCore/DFWLibs/SensLib/3.x.x-Ovf-2643-S2"
$LibPrefixName="abouzeid"
#optinal, this will be added after the version number. For example 3.0.8-suffixVal
$suffixVal=''

#*********************************************************************************************
#                  not mandatory configuration 
#*********************************************************************************************
#the location to store nuget packages before publish
$pkgsLoc ="$thisPath\pkgs"
$seslink3Sln = "$senslinkRoot\SensLib.sln"
$senslinkRoot="$thisPath\SensLib"
$thisPath = (Resolve-Path .\).Path

#[ProjectNam]="ProjectPath"
$lib_packages =@{

    "Senslink.BusinessLayer"="$senslinkRoot\Senslink.BusinessLayer\";  
    "Senslink.Client"="$senslinkRoot\Senslink.Client\";
    "Senslink.Client.Mqtt"="$senslinkRoot\Senslink.Client.Mqtt\";   
    "Senslink.Common"="$senslinkRoot\Senslink.Common\";
    
    "Senslink.CoreObjects"="$senslinkRoot\Senslink.CoreObjects\";  
    "Senslink.DatabaseProvider"="$senslinkRoot\Senslink.DatabaseProvider\";
    "Senslink.Language"="$senslinkRoot\Senslink.Language\";
    "Senslink.Mqtt"="$senslinkRoot\Senslink.Mqtt\";
    
    "Senslink.Opc"="$senslinkRoot\Senslink.Opc\";  
    "Senslink.SensTalk"="$senslinkRoot\Senslink.SensTalk\";
    
    }
    
    
function Validate-Paths()
{
    if (-not (Test-Path -Path $msbuild_2019)) {
    throw 'The MsBuild for VS 2019 does not exist, please check Config.ps1 file.'
    } 
    
     if (-not (Test-Path -Path $tfs)) {
    throw 'The TF.exe path does not exist, please check Config.ps1 file.'
    } 
    
      if (-not (Test-Path -Path $nuget)) {
    throw 'The nuget.exe path does not exist, please check Config.ps1 file.'
    } 
}
