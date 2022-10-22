.DEFAULT_GOAL := all
OPAM_BIN := $(shell /opt/local/bin/opam var bin)

include .env

.PHONY: printvars
printvars:
	@echo '$(sort $(.VARIABLES))'

.PHONY: all
all: $(wildcard *.c) $(wildcard *.h)
	@echo 'OPAM_BIN = $(OPAM_BIN)'
	$(OPAM_BIN)/dune build
