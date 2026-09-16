# שינוי הרשאות לתיקייה או קובץ, רקורסיבי - שווה ערך משולב ל-chmod/chown
# Change permissions for a folder or file, recursive - combined equivalent of chmod/chown
param(
    [Parameter(Mandatory=$true)][string]$Path,
    [Parameter(Mandatory=$true)][string]$User,
    [ValidateSet("Read","Write","Modify","FullControl")][string]$Right = "Modify"
)
icacls $Path /grant "${User}:(OI)(CI)$Right" /T
Write-Host "Granted $Right on '$Path' to $User, recursive."
