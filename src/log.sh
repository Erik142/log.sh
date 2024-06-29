#!/usr/bin/env bash

LOG_SH_SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" || exit; pwd)"
export LOG_SH_SCRIPT_DIR

if [ -z "$log_initialized" ]; then
    # shellcheck source-path=SCRIPTDIR
    source "${LOG_SH_SCRIPT_DIR}/log_level.sh"
    # shellcheck source-path=SCRIPTDIR
    source "${LOG_SH_SCRIPT_DIR}/log_format.sh"
    # shellcheck source-path=SCRIPTDIR
    source "${LOG_SH_SCRIPT_DIR}/util.sh"

    log_initialized="yes"
fi


function log_init() {
    max_log_level="$1"

    if [ -n "$max_log_level" ]; then
        if [ -n "${LOG_LEVELS[$max_log_level]}" ]; then
            MAX_LOG_LEVEL="$max_log_level"
        else
            log "$LOG_ERROR" "'$max_log_level' is not a valid log level"
            exit 1
        fi
    fi
}

function _log() {
    local log_level="$2"
    local func_name_index=${FUNCNAME_INDEXES[-1]}
    local line_number_index=${BASH_LINENO_INDEXES[-1]}

    local log_level="$2"
    _get_log_message "$@" "$func_name_index" "$line_number_index"
    printf "$(_get_log_format "$log_level")" "${LOG_MESSAGE[@]}" >&2

    unset "FUNCNAME_INDEXES[-1]"
    unset "BASH_LINENO_INDEXES[-1]"
}

function log_err() {
    _set_func_name_index
    _set_line_number_index

    _log "$1" "$LOG_ERROR"
}

function log_warn() {
    _set_func_name_index
    _set_line_number_index

    _log "$1" "$LOG_WARNING"
}

function log_info() {
    _set_func_name_index
    _set_line_number_index

    _log "$1" "$LOG_INFO"
}

function log_verbose() {
    _set_func_name_index
    _set_line_number_index

    _log "$1" "$LOG_VERBOSE"
}

function log_debug() {
    _set_func_name_index
    _set_line_number_index

    _log "$1" "$LOG_DEBUG"
}

function log() {
    _set_func_name_index
    _set_line_number_index

    _log "$1" "$LOG_INFO"
}
