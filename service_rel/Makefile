.PHONY: reltool.config files clean

all: reltool.config files

reltool.config:
	$(eval VSN := $(shell git describe --always --tags | sed s/-/_/g))
	m4 -DRELVSN="${VSN}" reltool.config.in > reltool.config

files:
	$(MAKE) -C files LOG_DIR="$(LOG_DIR)"

clean:
	rm -f reltool.config
	$(MAKE) -C files clean
