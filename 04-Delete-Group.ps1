# מחיקת קבוצה מקומית
# Delete a local group
param([Parameter(Mandatory=$true)][string]$GroupName)
Remove-LocalGroup -Name $GroupName
Write-Host "Group '$GroupName' deleted."
