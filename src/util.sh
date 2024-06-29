#!/usr/bin/env bash

if [ -z "$util_initialized" ]; then
    FUNCNAME_INDEXES=()
    export FUNCNAME_INDEXES

    BASH_LINENO_INDEXES=()
    export BASH_LINENO_INDEXES

    export util_initialized="yes"
fi

function _get_func_name_index() {
    index=${#FUNCNAME[@]}
    index=$((index-2))

    if (( index < 0 )); then
        index=0
    fi
    echo "$index"
}

function _get_line_number_index() {
    index=${#BASH_LINENO[@]}
    index=$((index-1))

    if (( index < 0 )); then
        index=0
    fi
    echo "$index"
}

function _set_func_name_index() {
    local func_name_index

    func_name_index="$(_get_func_name_index)"
    func_name_index=$((func_name_index - 2))

    FUNCNAME_INDEXES+=("$func_name_index")
}

function _set_line_number_index() {
    local line_number_index
    line_number_index="$(_get_line_number_index)"
    line_number_index=$((line_number_index - 1))

    BASH_LINENO_INDEXES+=("$line_number_index")
}
