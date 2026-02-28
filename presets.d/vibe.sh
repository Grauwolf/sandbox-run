configure_vibe() {
    local sandbox="$SANDBOX_ROOT/sandboxes/$PROJECT_HASH/vibe"

    # Create per-project sandbox directories
    mkdir -p "$sandbox"/logs
    touch "$sandbox/vibehistory"

    # Ensure host files exist for shared binds
    mkdir -p ~/.vibe/logs
    [ -f ~/.vibe/.env ] || touch ~/.vibe/.env
    [ -f ~/.vibe/config.toml ] || touch ~/.vibe/config.toml
    [ -f ~/.vibe/update_cache.json ] || touch ~/.vibe/update_cache.json
    [ -f ~/.vibe/trusted_folders.toml ] || touch ~/.vibe/trusted_folders.toml
    [ -f ~/.vibe/vibe.log ] || touch ~/.vibe/vibe.log

    # Bind per-project sandbox to ~/.vibe
    SANDBOX_BINDS+=("$sandbox:$HOME/.vibe")

    # Overlay shared files on top
    SHARED_BINDS+=(
        "$HOME/.vibe/.env"
        "$HOME/.vibe/config.toml"
        "$HOME/.vibe/update_cache.json"
        "$HOME/.vibe/trusted_folders.toml"
        "$HOME/.vibe/vibe.log"
    )
}
