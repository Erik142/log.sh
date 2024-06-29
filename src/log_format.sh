#!/usr/bin/env bash

if [ -z "$log_format_initialized" ]; then
    # shellcheck source-path=SCRIPTDIR
    source "${LOG_SH_SCRIPT_DIR}/log_level.sh"
    # shellcheck source-path=SCRIPTDIR
    source "${LOG_SH_SCRIPT_DIR}/util.sh"

    LOG_LEVEL_WIDTH=12
    LOG_METADATA_WIDTH=15
    LOG_METADATA_DEBUG_WIDTH=$((LOG_METADATA_WIDTH + 20))

    export LOG_MESSAGE=()

    log_format_initialized="yes"
fi

function log_filename_path() {
    local abs_path

    if [[ "$1" == "main" ]]; then
        abs_path="${BASH_SOURCE[-1]}"
    else
        abs_path="$(shopt -s extdebug; declare -Ff "$1" | cut -d" " -f3-; shopt -u extdebug)"
    fi
    basename "$abs_path"
}

function _get_default_log_format() {
    printf "%s" "%b%-${LOG_LEVEL_WIDTH}s%b %s\n"
}

function _get_debug_log_format() {
    printf "%s" "%b%-${LOG_LEVEL_WIDTH}s%b %-${LOG_METADATA_DEBUG_WIDTH}s %s\n"
}

function _get_log_format() {
    if [[ "${LOG_LEVELS["$1"]}" -le "${LOG_LEVELS["$MAX_LOG_LEVEL"]}" ]]; then
        if [ "$MAX_LOG_LEVEL" == "$LOG_DEBUG" ]; then 
            _get_debug_log_format "$1"
        else
            _get_default_log_format "$1"
        fi
    fi
}

function _set_log_level() {
    local log_level="$1"
    declare color=COLOR_$log_level

    LOG_MESSAGE+=("${!color}")
    LOG_MESSAGE+=("[$log_level]")
    LOG_MESSAGE+=("$COLOR_DEFAULT")
}

function _get_default_log_message() {
    local message="$1"
    local log_level="$2"

    LOG_MESSAGE=()
    _set_log_level "$log_level"

    LOG_MESSAGE+=("$1")
}

function _get_debug_log_message() {
    local message="$1"
    local log_level="$2"
    local func_name_index="$3"
    local line_number_index="$4"
    local curr_func_name_index
    local curr_line_number_index

    curr_func_name_index="$(_get_func_name_index)"
    curr_line_number_index="$(_get_line_number_index)"

    func_name_index=$((curr_func_name_index - func_name_index))
    line_number_index=$((curr_line_number_index - line_number_index))

    LOG_MESSAGE=()
    _set_log_level "$log_level"

    LOG_MESSAGE+=("$(log_filename_path "${FUNCNAME[$func_name_index]}") - <${FUNCNAME["$func_name_index"]}: ${BASH_LINENO["$line_number_index"]}>")
    LOG_MESSAGE+=("$message")
}

function _get_log_message() {
    if [[ "${LOG_LEVELS["$1"]}" -le "${LOG_LEVELS["$MAX_LOG_LEVEL"]}" ]]; then
        if [ "$MAX_LOG_LEVEL" == "$LOG_DEBUG" ]; then 
            _get_debug_log_message "$@"
        else
            _get_default_log_message "$@"
        fi
    fi
}
