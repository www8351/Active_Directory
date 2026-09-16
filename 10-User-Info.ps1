# לוח מידע: המשתמש הנוכחי, קבוצות, סשנים מחוברים, רשימת משתמשים מקומיים
# Info dashboard: current user, groups, logged-in sessions, local users list
Write-Host "== whoami =="
whoami
Write-Host "`n== whoami /groups (equivalent to Linux 'id') =="
whoami /groups
Write-Host "`n== quser (currently logged on, equivalent to 'who'/'w') =="
quser 2>$null
Write-Host "`n== Local users =="
Get-LocalUser | Select-Object Name, Enabled, LastLogon
