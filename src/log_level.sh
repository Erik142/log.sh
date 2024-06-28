#!/usr/bin/env bash

LOG_ERROR="ERROR"
LOG_WARNING="WARNING"
LOG_INFO="INFO"
LOG_VERBOSE="VERBOSE"
LOG_DEBUG="DEBUG"

COLOR_DEFAULT="\033[0m"
COLOR_RED="\033[1;31m"
COLOR_YELLOW="\033[1;33m"
COLOR_BLUE="\033[1;34m"
COLOR_BOLD="\033[1m"

COLOR_ERROR="$COLOR_RED"
COLOR_WARNING="$COLOR_YELLOW"
COLOR_INFO="$COLOR_BOLD"
COLOR_VERBOSE="$COLOR_BOLD"
COLOR_DEBUG="$COLOR_BLUE"

export COLOR_ERROR
export COLOR_WARNING
export COLOR_INFO
export COLOR_VERBOSE
export COLOR_DEBUG

FORMATTING_BOLD="\033[1m"
FORMATTING_NORMAL="\033[0m"

if [ -z "$log_level_initialized" ]; then
    declare -rA LOG_LEVELS=(["$LOG_ERROR"]=0 ["$LOG_WARNING"]=1 ["$LOG_INFO"]=3 ["$LOG_VERBOSE"]=4 ["$LOG_DEBUG"]=5)

    DEFAULT_LOG_LEVEL="INFO"
    MAX_LOG_LEVEL="$DEFAULT_LOG_LEVEL"

    export LOG_LEVELS
    export LOG_LEVEL_FUNCS
    export DEFAULT_LOG_LEVEL
    export MAX_LOG_LEVEL

    log_level_initialized="yes"
fi

function log_level_color() {
    case "$1" in
        "$LOG_ERROR")
            echo "${COLOR_RED}${1}${COLOR_DEFAULT}"
            ;;
        "$LOG_WARNING")
            echo "${COLOR_YELLOW}${1}${COLOR_DEFAULT}"
            ;;
        "$LOG_DEBUG")
            echo "${COLOR_BLUE}${1}${COLOR_DEFAULT}"
            ;;
        *)
            echo "${FORMATTING_BOLD}${1}${FORMATTING_NORMAL}"
    esac
}
