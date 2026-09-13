setup() {
  source "${TOP}"/tests/common.sh
  common_setup

  source "${TOP}"/src/log.sh
}

@test "can call log_init with valid argument" {
  for log_level in "${!LOG_LEVELS[@]}"; do
    run set_max_log_level "${log_level//LOG/}"
    assert_success
    assert_equal "$MAX_LOG_LEVEL" "$log_level"
  done
}

@test "cannot call log_init with invalid argument" {
  run set_max_log_level "hej"
  assert_failure
}


@test "cannot call log_init with empty argument" {
  run set_max_log_level ""
  assert_failure
}

@test "can log with valid number of arguments" {
  run log "This is a log message"
  assert_success

  assert_success
}

@test "log level configuration functions properly" {
  run set_max_log_level "DEBUG"
  local level=""

  for level in "${!LOG_LEVELS[@]}"; do
    echo "$level"
    run log_"$level" "This is a log message"
    assert_success
    assert_output --partial "$level"
  done
}

@test "_stat type identifies a pipe as a pipe" {
  run bash -c "source '${TOP}/src/util.sh'; echo hi | _stat type /dev/fd/0"
  assert_success
  assert_output --regexp "[Ff]ifo"
}

@test "_stat type identifies a regular file as a regular file" {
  run bash -c "source '${TOP}/src/util.sh'; _stat type '${TOP}/README.md'"
  assert_success
  assert_output --regexp "[Rr]egular"
}
