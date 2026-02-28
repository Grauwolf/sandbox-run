# Docker socket access (proxy preferred, direct socket as fallback)
# SECURITY NOTE: Docker socket access is effectively root on host.
# For better isolation, run a socket proxy (tecnativa/docker-socket-proxy):
#   docker run -d -v /var/run/docker.sock:/var/run/docker.sock:ro \
#       -e CONTAINERS=1 -e EXEC=1 -e POST=1 -p 127.0.0.1:2375:2375 \
#       tecnativa/docker-socket-proxy
configure_docker() {
    local proxy_host="tcp://127.0.0.1:2375"

    if command -v curl >/dev/null 2>&1 && curl -s --connect-timeout 1 "http://127.0.0.1:2375/_ping" >/dev/null 2>&1; then
        yell "Docker socket proxy detected, using $proxy_host"
        ENV_PRESET_OPTS+=(--setenv DOCKER_HOST "$proxy_host")
    else
        yell "Docker socket proxy not available, mounting socket directly"
        RW_BINDS+=(/run/docker.sock)
    fi
}
