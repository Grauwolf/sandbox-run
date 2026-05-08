# tmux socket access for controlling host tmux from inside sandbox
# Optional override:
#   SANDBOX_RUN_TMUX_SOCKET=/path/to/socket
configure_tmux() {
    local socket_path="${SANDBOX_RUN_TMUX_SOCKET:-}"
    local socket_dir
    local -a candidates

    # TMUX format: /path/to/socket,client_pid,session_id
    if [[ -z "$socket_path" && -n "${TMUX:-}" ]]; then
        socket_path="${TMUX%%,*}"
    fi

    candidates=(
        "/run/tmux/$UID_NUM/default"
        "${TMUX_TMPDIR:-/tmp}/tmux-$UID_NUM/default"
        "/tmp/tmux-$UID_NUM/default"
    )

    # Auto-detect by existing socket, otherwise use first candidate
    if [[ -z "$socket_path" ]]; then
        for candidate in "${candidates[@]}"; do
            if [[ -S "$candidate" ]]; then
                socket_path="$candidate"
                break
            fi
        done
        [[ -z "$socket_path" ]] && socket_path="${candidates[0]}"
    fi

    if [[ "$socket_path" == */ ]]; then
        socket_path="${socket_path%/}"
    fi

    if [[ "$socket_path" != /* ]]; then
        yell "tmux preset: socket path must be absolute ('$socket_path'), falling back to ${candidates[0]}"
        socket_path="${candidates[0]}"
    fi

    # If the override points at a directory, treat it as the tmux socket dir.
    if [[ -d "$socket_path" ]]; then
        socket_dir="$socket_path"
        socket_path="$socket_dir/default"
    else
        socket_dir="$(dirname "$socket_path")"
    fi

    # Bind only the resolved tmux socket directory.
    RW_BINDS+=("$socket_dir")

    # Expose resolved socket path to the sandbox for explicit tmux -S usage
    ENV_PRESET_OPTS+=(--setenv SANDBOX_RUN_TMUX_SOCKET "$socket_path")

    if [[ -S "$socket_path" ]]; then
        yell "tmux socket enabled ($socket_path)"
    else
        yell "tmux socket directory enabled ($socket_dir)"
    fi
}
