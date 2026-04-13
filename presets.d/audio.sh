# Audio runtime access for sandboxed apps (PipeWire/PulseAudio)
configure_audio() {
    local runtime_dir="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
    local pipewire_socket="$runtime_dir/pipewire-0"
    local pulse_dir="$runtime_dir/pulse"
    local enabled=0

    # PipeWire native socket
    if [[ -S "$pipewire_socket" ]]; then
        RW_BINDS+=("$pipewire_socket")
        enabled=1
    fi

    # PulseAudio compatibility socket (often provided by PipeWire)
    if [[ -d "$pulse_dir" ]]; then
        RW_BINDS+=("$pulse_dir")
        ENV_PRESET_OPTS+=(
            --setenv PULSE_RUNTIME_PATH "$pulse_dir"
            --setenv PULSE_SERVER "unix:$pulse_dir/native"
        )
        enabled=1
    fi

    if [[ "$enabled" -eq 1 ]]; then
        yell "Audio enabled (PipeWire/PulseAudio)"
    else
        yell "No PipeWire/PulseAudio runtime sockets found, audio disabled"
    fi
}
