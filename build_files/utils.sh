#!/bin/bash


log() {
    local level level_color
    case "${1:-}" in
        INFO)  level="INFO";  level_color='\033[0;36m'; shift ;;
        WARN)  level="WARN";  level_color='\033[0;33m'; shift ;;
        ERROR) level="ERROR"; level_color='\033[0;31m'; shift ;;
        DEBUG) level="DEBUG"; level_color='\033[0;90m'; shift ;;
        TRACE) level="TRACE"; level_color='\033[0;35m'; shift ;;
        *)     level="INFO";  level_color='\033[0;36m'        ;;
    esac
    printf '[%s] '"${level_color}"'%s\033[0m %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$level" "$*"
}

copr_install_isolated() {
    if [[ $# -lt 1 || -z "$1" ]]; then
        log ERROR "Missing COPR repository target for copr_install_isolated"
        exit 1
    fi

    local copr_name="$1"
    shift
    local packages=("$@")

    if [[ ${#packages[@]} -eq 0 ]]; then
        log ERROR "No packages specified for copr_install_isolated"
        return 1
    fi

    repo_id="copr:copr.fedorainfracloud.org:${copr_name//\//:}"
    
    log INFO "Installing ${packages[*]} from COPR $copr_name (isolated)"

    if ! command -v dnf5 &>/dev/null; then
        log ERROR "Missing dnf5 dependency for copr_install_isolated"
        return 1
    fi 

    dnf5 -y copr enable "$copr_name"
    dnf5 -y copr disable "$copr_name"
    dnf5 -y install --enablerepo="$repo_id" "${packages[@]}"

    log INFO "Installed ${packages[*]} from $copr_name"
}

trap '
    if [[ $BASH_COMMAND != echo* && $BASH_COMMAND != log* ]]; then
        log DEBUG "$BASH_COMMAND"
    fi
' DEBUG

PS4=''
exec {BASH_XTRACEFD}> >(set +x; while IFS= read -r line; do log TRACE "$line"; done)

set -euox pipefail
