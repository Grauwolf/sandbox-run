configure_go() {
    ENV_PRESET_OPTS+=(
        --setenv GOMODCACHE "$SANDBOX_CACHE/go/mod"
        --setenv GOPATH "$HOME/.local/share/go"
        --setenv GOBIN "$HOME/.local/bin"
    )
}
