#!/bin/bash

# List of allowed keywords
allowed_roles=("president" "vicepresident" "defenseminister" "secretary" "general" "admiral" "judge" "bodyguard" "cabinetofficial" "treasurer")

# Get a list of all local users (UID >= 1000 generally denotes non-system users)
local_users=$(getent passwd | awk -F: '$3 >= 1000 {print $1}')

for user in $local_users; do
    # Flag to track if the user is allowed
    is_allowed=false

    # Check if the username contains any of the allowed keywords
    for role in "${allowed_roles[@]}"; do
        if [[ "$user" == *"$role"* ]]; then
            is_allowed=true
            break
        fi
    done

    # If the user is not allowed, disable (lock) the user account
    if [ "$is_allowed" = false ]; then
        echo "Disabling (locking) user: $user"
        sudo usermod -L "$user"
    fi
done

echo "Script completed."

