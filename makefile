# Set some vars
VERSION=1.0.0
TICK=\033[32m✔\033[39m
DATE=$(shell date +"%H:%M - %d/%m/%y")
$NL="\r"

# Build STAN CLI From Source
make:
	@echo "#! /bin/sh" > stan
	@echo "${NL}" >> stan
	@echo "######################################" >> stan
	@echo "#### STAN Command Line Interface #####" >> stan
	@echo "########### VERSION ${VERSION} ############" >> stan
	@echo "######## DATE ${DATE} #######" >> stan
	@echo "######################################" >> stan
	@echo "${NL}" >> stan
	@cat src/set-vars.sh >> stan
	@echo "${NL}" >> stan
	@cat src/functions.sh >> stan
	@echo "${NL}" >> stan
	@cat src/init.sh >> stan
	@echo "${NL}" >> stan
	@cat src/init-remote.sh >> stan
	@echo "${NL}" >> stan
	@cat src/install.sh >> stan
	@echo "${NL}" >> stan
	@cat src/clone.sh >> stan

	@echo "STAN CLI build complete ${DATE} ${TICK}"
