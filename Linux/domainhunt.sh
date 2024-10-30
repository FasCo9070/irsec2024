#!/bin/bash

# List of allowed keywords
allowed_roles=("representative" "senator" "attache" "ambassador" "foreignaffairs" "intelofficer" "delegate" "advisor" "lobbyist" "aidworker")

# Get a list of all domain users (assuming domain users have a UID >= 1000)
domain_users=$(getent passwd | awk -F: '$3 >= 1000 {print $1}')

for user in $domain_users; do
    # Flag to track if the user is allowed
    is_allowed=false

    # Check if username contains any of the allowed keywords
    for role in "${allowed_roles[@]}"; do
        if [[ "$user" == *"$role"* ]]; then
            is_allowed=true
            break
        fi
    done

    # If the user is not allowed, delete them
    if [ "$is_allowed" = false ]; then
        echo "Deleting user: $user"
        sudo usermod -L "$user"
    fi
done

echo "Script completed."

