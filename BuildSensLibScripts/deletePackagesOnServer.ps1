param([string]$pkgNamePrefix ,[string] $version)

. .\Utility.ps1
. .\Config.ps1
. .\TfsHelper.ps1
. .\NuGetManager.ps1


    #possible input is the versin of the packages in SensLib
    &$nuget delete "$pkgNamePrefix.Opc" "$version" -noprompt -source http://192.168.12.67:5000/

    &$nuget delete "$pkgNamePrefix.BusinessLayer" "$version" -noprompt -source http://192.168.12.67:5000/

    &$nuget delete "$pkgNamePrefix.Client" "$version" -noprompt -source http://192.168.12.67:5000/
 
    &$nuget delete "$pkgNamePrefix.Mqtt" "$version" -noprompt -source http://192.168.12.67:5000/
    
    &$nuget delete "$pkgNamePrefix.Common" "$version" -noprompt -source http://192.168.12.67:5000/
    
    &$nuget delete "$pkgNamePrefix.CoreObjects" "$version" -noprompt -source http://192.168.12.67:5000/ 
        
    &$nuget delete "$pkgNamePrefix.DatabaseProvider" "$version" -noprompt -source http://192.168.12.67:5000/

    &$nuget delete "$pkgNamePrefix.Language" "$version" -noprompt -source http://192.168.12.67:5000/

    &$nuget delete "$pkgNamePrefix.Client.Mqtt" "$version" -noprompt -source http://192.168.12.67:5000/
    
    &$nuget delete "$pkgNamePrefix.SensTalk" "$version" -noprompt -source http://192.168.12.67:5000/
    