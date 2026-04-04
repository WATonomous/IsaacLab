#!/usr/bin/env bash

set -euo pipefail

VNC_DISPLAY="${VNC_DISPLAY:-1}"
DISPLAY_NUM=":${VNC_DISPLAY}"
DISPLAY_WIDTH="${DISPLAY_WIDTH:-1280}"
DISPLAY_HEIGHT="${DISPLAY_HEIGHT:-720}"
DISPLAY_DEPTH="${DISPLAY_DEPTH:-24}"
VNC_PORT="${VNC_PORT:-5900}"
VNC_GEOMETRY="${DISPLAY_WIDTH}x${DISPLAY_HEIGHT}"
VNC_XSTARTUP="${ISAACLAB_PATH}/docker/turbovnc-xstartup.sh"
VNC_PASSWD_DIR="${DOCKER_USER_HOME}/.vnc"
VNC_LOG_FILE="${VNC_PASSWD_DIR}/$(hostname)${DISPLAY_NUM}.log"

mkdir -p "${VNC_PASSWD_DIR}"
chmod 700 "${VNC_PASSWD_DIR}"

# TurboVNC refuses to start if stale lock files exist from a previous run.
vncserver -kill "${DISPLAY_NUM}" >/dev/null 2>&1 || true
rm -rf "/tmp/.X${VNC_DISPLAY}-lock" "/tmp/.X11-unix/X${VNC_DISPLAY}"

/opt/TurboVNC/bin/vncserver "${DISPLAY_NUM}" \
    -SecurityTypes None \
    -rfbport "${VNC_PORT}" \
    -geometry "${VNC_GEOMETRY}" \
    -depth "${DISPLAY_DEPTH}" \
    -xstartup "${VNC_XSTARTUP}"

# Keep the container alive while still surfacing VNC session logs.
touch "${VNC_LOG_FILE}"
exec tail -F "${VNC_LOG_FILE}"
