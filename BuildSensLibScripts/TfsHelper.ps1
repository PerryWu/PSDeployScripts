. .\Config.ps1

function Get-Senslink3 ( [Parameter(Mandatory=$true)] [String] $Version)
{
Write-Host $Version
Write-Host "Getting current Workspaces, please wait ...."

$OutputVariable = (& $tfs vc workspaces /collection:http://tfs2015:8080/tfs/AnaSystemRD/) | Out-String
Write-Host  $OutputVariable

if ($OutputVariable -like '*Deployment*')
    {
        Write-Host  "The used workspace is Deployment."
    }
    else
    {
            Write-Host  "Creating a new workspace named Deployment ...."
            #1- Create a seperate workspace
            &$tfs vc workspace -new Deployment /comment:"used for Deploying Applications" -collection:http://tfs2015:8080/tfs/AnaSystemRD
    }
    
#2- Create a mapping    
$pathFolders = $slnPath.split('/')
$lstIndex = ($pathFolders.length - 1)
$branchName = $pathFolders[$lstIndex]

    & $tfs vc workfold "$/Developing/SensCore/DFWLibs/SensLib/$branchName" "$thisPath\SensLib" /collection:http://tfs2015:8080/tfs/AnaSystemRD/ /workspace:"Deployment"
    
#3- Get specifc label code
    Write-Host  "Getting the latest version, please wait....."
    if ($Version -eq "latest")
    { 
        #& $tfs get -recursive "$thisPath\Senslink 3.0" /v:WDeployment
        & $tfs get /recursive "$thisPath\SensLib" /force
    }
    else
    {
        & $tfs get -recursive /v:"L$Version"
    }
    
#Useful Commands
    #&$tfs vc workspace -delete Deployment
}

function Create-Lable-ReleaseNotes-CheckIn ( [Parameter(Mandatory=$true)] [String] $Version,[String] $prevVersion)
{

Write-Host $Version

# /format:detailed  /noprompt


$notes = -join($thisPath,"\notes\RealseNotes-$Version.txt")

#create folder named notes if not exist
$notesFoler = "$thisPath\notes"
If(!(test-path $notesFoler))
{
      New-Item -ItemType Directory -Force -Path $notesFoler
}

$lbl ="$lblPrefix$Version".Trim()
$prevLbl ="$lblPrefix$prevVersion".Trim()

# delete label /format:detailed
#& $tfs label /delete "$lbl" 

& $tfs label "$lbl" $slnPath /recursive /noprompt
Write-Host "Created label $lbl"

Write-host "Notes from prev $prevLbl to new $lbl"

#$prevNotes = & $tfs history /collection:http://tfs2015:8080/tfs/AnaSystemRD/ "$slnPath" /v:"L$prevLbl" /noprompt /recursive 

& $tfs history /collection:http://tfs2015:8080/tfs/AnaSystemRD/ "$slnPath" /noprompt /recursive /v:"L$prevLbl~L$lbl" /format:detailed   | Out-File -Force -FilePath $notes -Encoding Unicode

$checkIn_Result = &$tfs checkin "$slnPath" /recursive /comment:"Updated SensLib Version $lbl. I am a script! " /noprompt

Write-Host "checked-in new version changes result: $checkIn_Result"

}