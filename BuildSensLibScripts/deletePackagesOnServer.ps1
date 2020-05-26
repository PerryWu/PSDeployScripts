#TO DO;
$ErrorActionPreference = "Stop"

. .\Utility.ps1
. .\Config.ps1
. .\TfsHelper.ps1
. .\NuGetManager.ps1

#possible input is the versin of the packages in SensLib
&$nuget delete SensLib.Opc 3.0.9 -noprompt -source http://192.168.12.67:5000/