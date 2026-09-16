# שינוי הגדרות משתמש: שם מלא, תיאור, נעילה או פתיחה של החשבון
# Modify user settings: full name, description, disable or enable the account
param(
    [Parameter(Mandatory=$true)][string]$Username,
    [string]$FullName,
    [string]$Description,
    [switch]$Disable,
    [switch]$Enable
)
if ($FullName)    { Set-LocalUser -Name $Username -FullName $FullName }
if ($Description) { Set-LocalUser -Name $Username -Description $Description }
if ($Disable)     { Disable-LocalUser -Name $Username }
if ($Enable)      { Enable-LocalUser -Name $Username }
Write-Host "User '$Username' updated."
