# יצירת משתמש מקומי חדש
# Create a new local user
param(
    [Parameter(Mandatory=$true)][string]$Username,
    [Parameter(Mandatory=$true)][securestring]$Password
)
New-LocalUser -Name $Username -Password $Password -FullName $Username -Description "Created by admin script"
Write-Host "User '$Username' created."
Write-Host "Note: the profile folder C:\Users\$Username is created automatically on first logon, not now."
