#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
UTILS_FILEPATH="${SCRIPT_DIR}/utils.sh"

# shellcheck source=build_files/utils.sh
source "${UTILS_FILEPATH}" && log DEBUG "${UTILS_FILEPATH} successfully loaded"

# Install dnf packages
# shellcheck source=build_files/packages.sh
source "${SCRIPT_DIR}/packages.sh"

# Cleanup
# source "${SCRIPT_DIR}/cleanup.sh"
