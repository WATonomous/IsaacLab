#!/usr/bin/env bash

unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS

export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/tmp/runtime-root}"
mkdir -p "${XDG_RUNTIME_DIR}"
chmod 700 "${XDG_RUNTIME_DIR}"

# Keep the desktop minimal to reduce remote rendering overhead.
pcmanfm --desktop >/tmp/pcmanfm.log 2>&1 &
xterm >/tmp/xterm.log 2>&1 &
exec openbox-session >/tmp/openbox-session.log 2>&1
