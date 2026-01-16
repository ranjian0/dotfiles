#!/usr/bin/env bash

# The "Smart" Bitwarden Wrapper
function secret() {
    # 1. Check if we already have a valid session
    if [ -z "$BW_SESSION" ]; then
        echo "🔒 Vault locked. Unlocking..."
        # Unlock and export the session ID to the current shell
        export BW_SESSION=$(bw unlock --raw)
    fi

    # 2. Check if the session is actually valid (in case it expired)
    bw status | grep -q '"status":"unlocked"'
    if [ $? -ne 0 ]; then
        echo "⌛ Session expired. Re-authenticating..."
        export BW_SESSION=$(bw unlock --raw)
    fi

    # 3. If you passed arguments, run the command. 
    #    If not, just tell the user the session is active.
    if [ -n "$1" ]; then
        # This allows you to do: secret get item "Netflix"
        bw "$@"
    else
        echo "✅ Vault is open and ready."
    fi
}