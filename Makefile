ifneq ($(VERBOSE),$(empty))
	Q := $(empty)
else
	Q := @
endif

export TOP := $(realpath $(dir $(realpath $(firstword $(MAKEFILE_LIST)))))

.PHONY: lint
lint:
	$(Q)fd --glob '*.sh' --type f -u -a $(TOP) | xargs shellcheck -e SC2059 -x

.PHONY: test
test:
	$(Q)$(TOP)/bats/bats-core/bin/bats -r $(TOP)/tests

gh_test:
	$(Q)act pull_request
