#!/usr/bin/env bash

this_script_dir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

. "${this_script_dir}/../src/log.sh"

function debug_func() {
  log_debug "debug from function"
}

function print_all() {
  log "Hello log!"
  log_err "Hello err!"
  log_warn "Hello warn!"
  log_info "Hello info!"
  log_verbose "Hello verbose!"
  log_debug "Hello debug!"
  debug_func
}

log "max_log_level: INFO"
print_all
echo ""

set_max_log_level DEBUG
log "max_log_level: DEBUG"
print_all
