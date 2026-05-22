#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
UTILS_FILEPATH="${SCRIPT_DIR}/utils.sh"

# shellcheck source=build_files/utils.sh
source "${UTILS_FILEPATH}" && log DEBUG "${UTILS_FILEPATH} successfully loaded"

# Install dnf packages
# shellcheck source=build_files/packages.sh
source "${SCRIPT_DIR}/packages.sh"

# Enable VSCode extensions autoinstall on first user session
if systemctl --global enable vscode-extensions.service; then
	log INFO "Systemd vscode-extensions.service enabled"
else
	log ERROR "Cannot enable vscode-extensions.service"
	exit 1
fi

# Cleanup
# shellcheck source=build_files/cleanup.sh
source "${SCRIPT_DIR}/cleanup.sh"
