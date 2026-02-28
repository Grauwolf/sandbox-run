configure_python() {
    ENV_PRESET_OPTS+=(
        --setenv UV_CACHE_DIR "$SANDBOX_CACHE/uv"
        --setenv PIP_CACHE_DIR "$SANDBOX_CACHE/pip"
    )
}
