function Renamer (
[Parameter(Mandatory=$true)] [String] $rootPath,
[Parameter(Mandatory=$false)] [String] $dstName,
[Parameter(Mandatory=$true)][AllowEmptyString()] [String] $sensTalkProtocolVersion,
[Parameter(Mandatory=$true)][AllowEmptyString()] [String] $dbServerName,
[Parameter(Mandatory=$true)][AllowEmptyString()] [String] $transceiverId,
[Parameter(Mandatory=$true)][AllowEmptyString()] [String] $listenPort
)
{
    Write-Host "Renamer is called $rootPath $dstName $sensTalkProtocolVersion $dbServerName $transceiverId"
     $srcPath="$rootPath\Transceiver"
     if (($dstPath.Length -gt 0) -And  (-Not (Test-Path $dstPath)))
     {
       $dstPath="$rootPath\$dstName"
        md -path $dstPath
     }
     
     if($dstPath.Length -gt 0)
     {
        Copy-Item -Recurse -Force -Path "$srcPath\*" -Destination $dstPath 
        Rename-Item -Path "$dstPath\Transceiver.exe" -NewName "$dstName.exe"
        Rename-Item -Path "$dstPath\Transceiver.exe.config" -NewName "$dstName.exe.config"
        $configFile="$dstPath\$dstName.exe.config"
     }
     else
     {
        $configFile="$srcPath\Transceiver.exe.config"
     }
    $xml = New-Object XML
    $xml.Load($configFile)

    $element =  $xml.SelectSingleNode("//configuration/appSettings/add")
    $nodes = $xml.SelectNodes("//configuration/appSettings/add");

    foreach($node in $nodes)
     {
       $key  = $node.Key
       if(($sensTalkProtocolVersion.Length -gt 0) -And  ($key -eq "SensTalkProtocolVersion"))
       {
          $node.SetAttribute("value", "$sensTalkProtocolVersion");
          continue;
        }

       if(($dbServerName.Length -gt 0) -And  ($key -eq "DbServerName"))
       {
          $node.SetAttribute("value", "$dbServerName");
          continue;
        }

       if(($transceiverId.Length -gt 0) -And  ($key -eq "TransceiverId"))
       {
          $node.SetAttribute("value", "$transceiverId");
          continue;
        }

       if(($listenPort.Length -gt 0) -And  ($key -eq "ListenPort"))
       {
          $node.SetAttribute("value", "$listenPort");
          continue;
        }
     }
    $xml.Save($configFile)
}

$_thisPath = (Resolve-Path .\).Path
$_transceiverPath="$_thisPath\Transceiver"

function RunCommand (
[Parameter(Mandatory=$true)] [Int] $executeMode
)
{
    Switch($executeMode) 
    {
        1
        {
            # 農工 192.168.117.146
            Renamer -rootPath "$_thisPath"  -dstName  "TransceiverV101" -sensTalkProtocolVersion "1" -transceiverId "6930afb2-d2f4-4377-93c9-2944ac1dc1af" -dbServerName "CoaGov" -listenPort "10021"
            Renamer -rootPath "$_thisPath"  -dstName  "TransceiverV102" -sensTalkProtocolVersion "1" -transceiverId "b686f7ab-994b-46b5-abdb-dbb1ba1f2e31" -dbServerName "CoaGov" -listenPort "10022"
            Renamer -rootPath "$_thisPath"  -dstName  "TransceiverV103" -sensTalkProtocolVersion "1" -transceiverId "3a4d1778-6ccf-4ed7-88f1-5029fb19c776" -dbServerName "CoaGov" -listenPort "10023"
            Renamer -rootPath "$_thisPath"  -dstName  "TransceiverV104" -sensTalkProtocolVersion "1" -transceiverId "f634a710-3930-4bb9-9ad1-ed7e9584026c" -dbServerName "CoaGov" -listenPort "10024"
            Renamer -rootPath "$_thisPath"  -dstName  "TransceiverV105" -sensTalkProtocolVersion "1" -transceiverId "1b3ab696-5730-4de2-a868-6ecdca4476cc" -dbServerName "CoaGov" -listenPort "10025"
            Renamer -rootPath "$_thisPath"  -dstName  "TransceiverV106" -sensTalkProtocolVersion "1" -transceiverId "176c490e-7218-4455-aa5d-4607132d3804" -dbServerName "CoaGov" -listenPort "10026"
            break;
        }
        2
        {
            # 農工 192.168.117.147
            Renamer -rootPath "$_thisPath"  -dstName  "TransceiverV1" -sensTalkProtocolVersion "1" -transceiverId "8dc2fcd5-9ea1-4017-9986-0c6134beb9b3" -dbServerName "CoaGov" -listenPort "10000"
            Renamer -rootPath "$_thisPath"  -dstName  "TransceiverV2" -sensTalkProtocolVersion "2" -transceiverId "42e07158-5d9d-4f78-80c6-252be0d4a984" -dbServerName "CoaGov" -listenPort "10001"
            break;
        }
        3
        {
            # 農工 192.168.117.148
            Renamer -rootPath "$_thisPath"  -dstName  "TransceiverV107" -sensTalkProtocolVersion "1" -transceiverId "c217cb60-5d4b-47c8-9f78-f0a083648b9b" -dbServerName "CoaGov" -listenPort "10027"
            Renamer -rootPath "$_thisPath"  -dstName  "TransceiverV108" -sensTalkProtocolVersion "1" -transceiverId "42fe87a2-3d76-4ac1-8046-92e7f73f69cb" -dbServerName "CoaGov" -listenPort "10028"
            Renamer -rootPath "$_thisPath"  -dstName  "TransceiverV109" -sensTalkProtocolVersion "1" -transceiverId "64e1f109-00fc-49c2-b86e-ef39732d1b40" -dbServerName "CoaGov" -listenPort "10029"
            Renamer -rootPath "$_thisPath"  -dstName  "TransceiverV110" -sensTalkProtocolVersion "1" -transceiverId "6a215d23-4e04-4489-9445-f2e24afdf4cd" -dbServerName "CoaGov" -listenPort "10030"
            Renamer -rootPath "$_thisPath"  -dstName  "TransceiverV112" -sensTalkProtocolVersion "1" -transceiverId "7f33c609-d759-49e0-89d8-430356dbb91c" -dbServerName "CoaGov" -listenPort "10032"
            break;
        }
        4
        {
            Renamer -rootPath "$_thisPath"  -sensTalkProtocolVersion "2" -transceiverId "42e07158-5d9d-4f78-80c6-252be0d4a984" -dbServerName "WRA" -listenPort "10000"
            break;
        }
        5
        {
            Renamer -rootPath "$_thisPath"  -sensTalkProtocolVersion "1" -transceiverId "8dc2fcd5-9ea1-4017-9986-0c6134beb9b3" -dbServerName "WRA" -listenPort "10000"
            break;
        }
        6
        {
            Renamer -rootPath "$_thisPath"  -sensTalkProtocolVersion "1" -transceiverId "f584506c-0c62-47b0-afd0-2bf21d1aefab" -dbServerName "WRA" -listenPort "10000"
            break;
        }
        7
        {
            Renamer -rootPath "$_thisPath"  -sensTalkProtocolVersion "2" -transceiverId "42e07158-5d9d-4f78-80c6-252be0d4a984" -dbServerName "竹北機房" -listenPort "10000"
            break;
        }
        Default
        {
            Write-Host "請輸入支援的值"
        }
    }
}

Write-Host "Please enter which cluster machine you want to run"
Write-Host "1 農工 192.168.117.146"
Write-Host "2 農工 192.168.117.147"
Write-Host "3 農工 192.168.117.148"
Write-Host "4 WRA 10.57.234.140"
Write-Host "5 WRA 10.57.234.141"
Write-Host "6 WRA 10.57.234.145"
Write-Host "7 竹北 192.168.116.147"
RunCommand
Write-Host "命令已經完成 Done"
