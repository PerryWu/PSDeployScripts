$thisPath = (Resolve-Path .\).Path

#1- MsBuild and projects locations
$msbuild ='C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe'

#2- tf location
$tfs = "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\TF.exe"

#3- nuget cml
#https://docs.microsoft.com/en-us/nuget/consume-packages/install-use-packages-nuget-cli
$nuget ="C:\bin\nuget.exe"

$senslinkRoot="$thisPath\Senslink 3.0"
$destination="$thisPath\To Deploy"
$seslink3Sln = "$senslinkRoot\Senslink 3.0.sln"

#key=[name].csproj and the value = location
$console_apps = @{    
    "DatabaseWriter"="$senslinkRoot\Applications\DatabaseWriter\"; 
    "OneVariableFormulaTransfer"="$senslinkRoot\Applications\OneVariableFormula\OneVariableFormulaTransfer\";
    "Transceiver"="$senslinkRoot\Applications\Transceiver\";
    "TsrService"="$senslinkRoot\Applications\SenslinkTsrManager\TsrService\";
    "AlarmCheck"="$senslinkRoot\Applications\AlarmCenter\AlarmCheck\";
    "AlarmSender"="$senslinkRoot\Applications\AlarmCenter\AlarmSender\";
    "ExternalMqttPacketHub"="$senslinkRoot\Applications\LoRaPacketCollector\";
    "ExternalMqttPacketServer"="$senslinkRoot\Applications\ExternalMqttPacketServer\";
    "InfoChangeLogger"="$senslinkRoot\InfoChangeLogger\";
    }

$web_apps=@{
   "Senslink.Web.UserApis"="$senslinkRoot\Web\UserWebApis\";  
    "WebAdmin"="$senslinkRoot\Web\WebAdmin\";
    "Senslink.OgcSensorThingsRestApi"="$senslinkRoot\Web\Senslink.OgcSensorThingsRestApi\";
    "Senslink.Web.OAuth2"="$senslinkRoot\Web\SenslinkOAuth2Server\";
    "Senslink.Web.DatabaseProviderApis"="$senslinkRoot\Web\DatabaseProviderWebApis\";
    }
    
