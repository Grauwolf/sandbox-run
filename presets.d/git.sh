configure_git() {
    RO_BINDS+=("${XDG_CONFIG_HOME:-$HOME/.config}/git")
    RO_BINDS+=("$HOME/.gitconfig")
}
