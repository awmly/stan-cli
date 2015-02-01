# Set some vars
VERSION=1.0.0
TICK=\033[32m✔\033[39m
DATE=$(shell date +"%H:%M - %d/%m/%y")
$NL="\r"

# Build STAN CLI From Source
global:
	@echo "#! /bin/sh" > stan
	@echo "${NL}" >> stan
	@echo "######################################" >> stan
	@echo "#### STAN Command Line Interface #####" >> stan
	@echo "############ GLOBAL BIN ##############" >> stan
	@echo "########### VERSION ${VERSION} ############" >> stan
	@echo "######## DATE ${DATE} #######" >> stan
	@echo "######################################" >> stan
	@echo "${NL}" >> stan
	@cat src/vars-global.sh >> stan
	@echo "${NL}" >> stan
	@cat src/functions.sh >> stan
	@echo "${NL}" >> stan
	@cat src/init.sh >> stan
	@echo "${NL}" >> stan
	@cat src/install.sh >> stan
	@echo "${NL}" >> stan
	@cat src/remote.sh >> stan
	@echo "${NL}" >> stan
	@cat src/clone.sh >> stan
	@echo "${NL}" >> stan
	@cat src/update.sh >> stan
	@echo "${NL}" >> stan
	@cat src/local.sh >> stan

	@echo "STAN CLI build complete ${DATE} ${TICK}"

# Build STAN CLI From Source
local:
	@echo "#! /bin/sh" > stan-cli
	@echo "${NL}" >> stan-cli
	@echo "######################################" >> stan-cli
	@echo "#### STAN Command Line Interface #####" >> stan-cli
	@echo "############# LOCAL BIN ##############" >> stan
	@echo "########### VERSION ${VERSION} ############" >> stan-cli
	@echo "######## DATE ${DATE} #######" >> stan-cli
	@echo "######################################" >> stan-cli
	@echo "${NL}" >> stan-cli
	@cat src/vars-local.sh >> stan-cli
	@echo "${NL}" >> stan-cli
	@cat src/functions.sh >> stan-cli
	@echo "${NL}" >> stan-cli
	@cat src/upload.sh >> stan-cli

	@echo "STAN CLI build complete ${DATE} ${TICK}"


.PHONY: global local
