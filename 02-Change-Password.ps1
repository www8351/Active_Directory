# שינוי סיסמה למשתמש מקומי קיים
# Change password for an existing local user
param(
    [Parameter(Mandatory=$true)][string]$Username,
    [Parameter(Mandatory=$true)][securestring]$Password
)
Set-LocalUser -Name $Username -Password $Password
Write-Host "Password updated for '$Username'."
