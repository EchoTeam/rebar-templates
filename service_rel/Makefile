.PHONY: reltool.config files

all: reltool.config files

reltool.config:
	$(eval VSN := $(shell git describe --always --tags | sed s/-/_/g))
	m4 -DRELVSN="${VSN}" -DDEPS_DIR="$(DEPS_DIR)" reltool.config.in > reltool.config

files:
	$(MAKE) -C files LOG_DIR="$(LOG_DIR)"
