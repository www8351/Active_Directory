# מחיקת משתמש מקומי
# Delete a local user
param([Parameter(Mandatory=$true)][string]$Username)
Remove-LocalUser -Name $Username
Write-Host "User '$Username' deleted."
Write-Host "Note: the profile folder C:\Users\$Username is NOT removed automatically."
