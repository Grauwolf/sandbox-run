configure_forgejo() {
    mkdir -p ~/.local/share/forgejo-cli
    RW_BINDS+=("$HOME/.local/share/forgejo-cli")
}
