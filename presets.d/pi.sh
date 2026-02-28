configure_pi() {
    # Ensure host directories exist for overlays
    mkdir -p ~/.pi
    RW_BINDS+=("$HOME/.pi")
}
