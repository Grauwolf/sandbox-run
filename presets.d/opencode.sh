configure_opencode() {
    local sandbox="$SANDBOX_ROOT/sandboxes/$PROJECT_HASH/opencode"

    mkdir -p "$sandbox"
    touch "$sandbox/auth.json"

    mkdir -p ~/.config/opencode
    mkdir -p ~/.local/share/opencode
    [ -f ~/.local/share/opencode/auth.json ] || touch ~/.local/share/opencode/auth.json

    RW_BINDS+=("$HOME/.config/opencode")
    SANDBOX_BINDS+=("$sandbox:$HOME/.local/share/opencode")
    SHARED_BINDS+=("$HOME/.local/share/opencode/auth.json")
}
