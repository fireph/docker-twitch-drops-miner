#!/bin/sh

# Keep PyInstaller's bundled libraries out of the system browser.
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH_ORIG:-}"

# Docker's default restrictions prevent Chrome from creating sandbox namespaces.
exec /opt/google/chrome/google-chrome --no-sandbox "$@"
