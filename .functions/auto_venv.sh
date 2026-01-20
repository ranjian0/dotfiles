#!/usr/bin/env zsh

# Auto-activate Python virtual environments on directory change
# Supports: .venv, venv, .env, env

autoload -U add-zsh-hook

_auto_venv() {
    local venv_names=(".venv" "venv")
    local venv_found=""
    local venv_path=""

    for venv in "${venv_names[@]}"; do
        if [[ -d "$PWD/$venv" && -f "$PWD/$venv/bin/activate" ]]; then
            venv_found="$venv"
            venv_path="$PWD/$venv"
            break
        fi
    done

    if [[ -n "$venv_found" ]]; then
        if [[ "$VIRTUAL_ENV" != "$venv_path" ]]; then
            if [[ -n "$VIRTUAL_ENV" ]]; then
                deactivate 2>/dev/null
            fi
            source "$venv_path/bin/activate"
        fi
    else
        if [[ -n "$VIRTUAL_ENV" ]]; then
            deactivate 2>/dev/null
        fi
    fi
}

add-zsh-hook chpwd _auto_venv
_auto_venv
