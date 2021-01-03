#SHELL := /bin/sh

# import env variables
# you can change the default filename with `make env_file="config_special.env" build`
env_file ?= .env
ifneq ("$(wildcard $(env_file))", "")
	include $(env_file)
	export $(shell sed 's/=.*//' $(env_file))
endif


TPUT := $(shell [ -n "$$TERM" ] && [ "$$TERM" != "dumb" ] && echo 'tput' || echo 'tput -Tvt100')

BOLD := "$$([ -t 0 ] && $(TPUT) bold)"
NORMAL := "$$([ -t 0 ] && $(TPUT) sgr0)"
GREEN := "$$([ -t 0 ] && $(TPUT) setaf 2)"
ASK_CONFIRMATION := "read -p 'Are you sure? (y/n) ' REPLY && export REPLY"
ASK_CONFIRMATION := $$(eval $(ASK_CONFIRMATION); while echo $$REPLY | grep -vEq '^[YyNn]$$'; do eval $(ASK_CONFIRMATION); done; echo $$REPLY | grep -iq 'y')

GIT_BRANCH ?= "origin/master"

.PHONY: help
help: ## Will print this help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: update
update: ## Will update config and restart klipper
	@echo "\n${BOLD}Fetching config..${NORMAL} 🛠"; \
	git fetch -p &&	git reset --hard ${GIT_BRANCH};

	@echo "\n${BOLD}Restart klipper..${NORMAL} 🐬" && \
	sudo service klipper restart && \
	sleep 4 && \
	echo "\n${BOLD}Restart firmware..${NORMAL} 🤖" && \
	echo FIRMWARE_RESTART >> /tmp/printer;

	@echo "\n${BOLD}All ${GREEN}done${NORMAL}"