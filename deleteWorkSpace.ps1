
$ErrorActionPreference = "Stop"

. .\Utility.ps1
. .\Config.ps1
. .\TfsHelper.ps1
. .\NuGetManager.ps1

#delete the workspace to avoid error when used in diff PC.
&$tfs vc workspace -delete Deployment