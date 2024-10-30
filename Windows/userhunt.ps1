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

    # If no allowed keywords are found, disable the user
    if (-not $isAllowed) {
        Write-Host "Disabling user: $($user.SamAccountName)"
        # Uncomment the line below to actually disable the user
        Disable-ADAccount -Identity $user
    }
}

Write-Host "Script completed."

