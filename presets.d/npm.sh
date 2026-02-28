configure_npm() {
    ENV_PRESET_OPTS+=(
        --setenv XDG_CACHE_HOME "$SANDBOX_CACHE"
        --setenv NPM_CONFIG_CACHE "$SANDBOX_CACHE/npm"
        --setenv NPM_CONFIG_PREFIX "$HOME/.local/share/npm"
        --setenv PNPM_HOME "$HOME/.local/share/pnpm"
    )
    PATH_ADDITIONS+=("$HOME/.local/share/npm/bin")
    PATH_ADDITIONS+=("$HOME/.local/share/pnpm")
}
