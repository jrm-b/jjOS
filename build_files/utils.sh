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

trap '
    if [[ $BASH_COMMAND != echo* && $BASH_COMMAND != log* ]]; then
        log DEBUG "$BASH_COMMAND"
    fi
' DEBUG

PS4=''
exec {BASH_XTRACEFD}> >(set +x; while IFS= read -r line; do log TRACE "$line"; done)

set -euox pipefail
