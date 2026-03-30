# Wayland display access for GUI applications (Chromium, etc.)
configure_wayland() {
    local runtime_dir="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
    local wayland_socket="${WAYLAND_DISPLAY:-wayland-0}"
    local socket_path="$runtime_dir/$wayland_socket"

    if [[ ! -S "$socket_path" ]]; then
        yell "Wayland socket not found at $socket_path, GUI disabled"
        return
    fi

    # Bind Wayland socket
    RW_BINDS+=("$socket_path")

    # GPU access for hardware acceleration (device nodes need --dev-bind)
    if [[ -d /dev/dri ]]; then
        SANDBOX_RUN_BWRAP_ARGS+=" --dev-bind /dev/dri /dev/dri"
    fi
    # NVIDIA devices if present
    for dev in /dev/nvidia*; do
        [[ -e "$dev" ]] && SANDBOX_RUN_BWRAP_ARGS+=" --dev-bind $dev $dev"
    done

    # Pass through display-related environment
    ENV_PRESET_OPTS+=(
        --setenv WAYLAND_DISPLAY "$wayland_socket"
        --setenv XDG_RUNTIME_DIR "$runtime_dir"
        --setenv XDG_SESSION_TYPE "wayland"
    )

    # Portal permissions for file dialogs, screen sharing, etc.
    # These go through the D-Bus proxy (started later)
    DBUS_TALK_NAMES+=(
        "org.freedesktop.portal.Desktop"
        "org.freedesktop.portal.FileChooser"
        "org.freedesktop.portal.OpenURI"
        "org.freedesktop.portal.Screenshot"
    )

    # Disable --new-session to allow job control in bash
    DISABLE_NEW_SESSION=1

    # Fonts: /etc/fonts (fontconfig config), caches, and user font dirs
    RO_BINDS+=(
        /etc/fonts
        /var/cache/fontconfig
        "$HOME/.local/share/fonts"
        "$HOME/.fonts"
    )

    yell "Wayland display enabled ($socket_path)"
}
