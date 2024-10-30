# List of allowed keywords
$allowedRoles = @("representative", "senator", "attache", "ambassador", "foreignaffairs", "intelofficer", "delegate", "advisor", "lobbyist", "aidworker")

# Get all domain users
$allUsers = Get-ADUser -Filter * -Properties SamAccountName

foreach ($user in $allUsers) {
    # Check if any of the allowed keywords are in the SamAccountName
    $isAllowed = $false
    foreach ($role in $allowedRoles) {
        if ($user.SamAccountName -match $role) {
            $isAllowed = $true
            break
        }
    }

    # If no allowed keywords are found, delete the user
    if (-not $isAllowed) {
        Write-Host "Deleting user: $($user.SamAccountName)"
        Remove-ADUser -Identity $user -Confirm:$false
    }
}

Write-Host "Script completed."

