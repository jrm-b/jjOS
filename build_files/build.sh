#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
UTILS_FILEPATH="${SCRIPT_DIR}/utils.sh"

source "${UTILS_FILEPATH}" && log DEBUG "${UTILS_FILEPATH} successfully loaded"

# Install dnf packages
source "${SCRIPT_DIR}/packages.sh"

# Cleanup
# source "${SCRIPT_DIR}/cleanup.sh"