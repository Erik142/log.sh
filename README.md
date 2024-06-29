# log.sh

log.sh is a minimal log framework for bash scripts. It gives the user colored printouts of log messages with the option of setting the highest log level that should be printed out. It has been designed with scripts in mind, therefore the log messages are printed to stderr instead of stdout, ensuring that the user can print log messages inside of functions that are returning values without corrupting the returned values.

## Installation

Simply clone this git repository and store it somewhere centrally, or add it as a submodule if including it in a larger bash project:

```sh
git submodule add https://github.com/Erik142/log.sh.git
```

From within the top-level bash script in your bash project, source log.sh:

```bash
source <path to log.sh>/src/log.sh
```

## Usage

log.sh includes several logging functions to print log messages:

```bash
log_err "My log message"
log_warn "My log message"
log_info "My log message"
log_verbose "My log message"
log_debug "My log message"
log "My log message" # Same as log_info
```

The highest printable log level can be set using:

```bash
log_set_max_level <log level>
```

where valid log levels are:

```bash
ERROR
WARNING
INFO
VERBOSE
DEBUG
```

The default configuration allows log messages up to, and including, INFO, to be printed.

See the [examples](examples/) directory for example implementations, or check out the [jorp.sh](https://github.com/Erik142/jorp.sh) project for a "real" implementation of a project that is using log.sh!
