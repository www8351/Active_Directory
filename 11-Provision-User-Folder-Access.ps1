# תרחיש מלא: יצירת משתמש, יצירת/הוספה לקבוצה, והרשאות לתיקייה משותפת
# Full scenario: create user, create/add to group, set permissions on a shared folder
param(
    [Parameter(Mandatory=$true)][string]$Username,
    [Parameter(Mandatory=$true)][string]$GroupName,
    [Parameter(Mandatory=$true)][string]$FolderPath,
    [securestring]$Password = (ConvertTo-SecureString "ChangeMe123!" -AsPlainText -Force)
)
if (-not (Get-LocalUser -Name $Username -ErrorAction SilentlyContinue)) {
    New-LocalUser -Name $Username -Password $Password | Out-Null
}
if (-not (Get-LocalGroup -Name $GroupName -ErrorAction SilentlyContinue)) {
    New-LocalGroup -Name $GroupName | Out-Null
}
Add-LocalGroupMember -Group $GroupName -Member $Username
New-Item -ItemType Directory -Force -Path $FolderPath | Out-Null
icacls $FolderPath /grant "${GroupName}:(OI)(CI)M" /T

Write-Host "Done. '$Username' is in '$GroupName' with Modify access to '$FolderPath'."
Write-Host "Default password is 'ChangeMe123!' unless -Password was passed, change it on first login."
