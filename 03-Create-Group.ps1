# יצירת קבוצה מקומית חדשה
# Create a new local group
param([Parameter(Mandatory=$true)][string]$GroupName)
New-LocalGroup -Name $GroupName
Write-Host "Group '$GroupName' created."
