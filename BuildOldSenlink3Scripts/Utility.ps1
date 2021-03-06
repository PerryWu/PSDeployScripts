. .\Variables.ps1
#Param (
#[string]$projectRoot="D:\SourceControl_2019\Senslink 3.0"
#)
#Write-Host $name

function Deploy-Web () {
Write-Host "Start building WebApplications ..."

     foreach ($app in $web_apps.GetEnumerator())
     {       
     Write-Host   "$($app.Value)$($app.Name).csproj"
            
        &$msbuild "$($app.Value)$($app.Name).csproj"  /target:Clean /target:Build               
        
        $dest="$destination\Web\$($app.Name)"
        $src="$($app.Value)\bin\*"
       
        if (-Not (Test-Path $dest))
        {
            md -path $dest
        }         
        
        Copy-Item -Recurse -Force -Path $src -Destination $dest 
        
        Write-Host "Copy Web to Destination is Completed.."                
    }
}

function Deploy-Console(){

    foreach ($app in $console_apps.GetEnumerator())
     {                
        &$msbuild "$($app.Value)$($app.Name).csproj"  /target:Clean /target:Build               
        
        $dest="$destination\Console\$($app.Name)"
        $src="$($app.Value)\bin\Debug\*"
       
        if (-Not (Test-Path $dest))
        {
            md -path $dest
        }         
        
        Copy-Item -Recurse -Force -Path $src -Destination $dest 
        Write-Host "Copy Console to Destination is Completed.."                
    }
}