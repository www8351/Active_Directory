# הוספת משתמש לקבוצה מקומית
# Add a user to a local group
param(
    [Parameter(Mandatory=$true)][string]$Username,
    [Parameter(Mandatory=$true)][string]$GroupName
)
Add-LocalGroupMember -Group $GroupName -Member $Username
Write-Host "User '$Username' added to group '$GroupName'."
Write-Host "Verify with: Get-LocalGroupMember -Group $GroupName"
