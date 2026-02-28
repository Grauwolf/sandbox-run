configure_cargo() {
    ENV_PRESET_OPTS+=(
        --setenv CARGO_HOME "$HOME/.local/share/cargo"
    )
    PATH_ADDITIONS+=("$HOME/.local/share/cargo/bin")
}
