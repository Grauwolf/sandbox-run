configure_claude() {
    local sandbox="$SANDBOX_ROOT/sandboxes/$PROJECT_HASH/claude"

    # Create sandbox directories
    mkdir -p "$sandbox"/{agents,cache,commands,plugins}
    touch "$sandbox/settings.json"

    # Ensure host directories exist for overlays
    mkdir -p ~/.claude/{agents,cache,commands,plugins}
    [ -f ~/.claude/settings.json ] || touch ~/.claude/settings.json
    [ -f ~/.claude.json ] || touch ~/.claude.json

    RW_BINDS+=("$HOME/.claude.json")
    SANDBOX_BINDS+=("$sandbox:$HOME/.claude")
    SHARED_BINDS+=(
        "$HOME/.claude/agents"
        "$HOME/.claude/cache"
        "$HOME/.claude/commands"
        "$HOME/.claude/plugins"
        "$HOME/.claude/skills"
        "$HOME/.claude/.credentials.json"
        "$HOME/.claude/settings.json"
    )
}
