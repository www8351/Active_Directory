# שינוי בעלים לתיקייה או קובץ
# Change owner for a folder or file
param(
    [Parameter(Mandatory=$true)][string]$Path,
    [Parameter(Mandatory=$true)][string]$Owner
)
$acl = Get-Acl $Path
$acl.SetOwner([System.Security.Principal.NTAccount]$Owner)
Set-Acl -Path $Path -AclObject $acl
Write-Host "Owner of '$Path' set to $Owner"
