.PHONY: reltool.config clean

all: reltool.config

reltool.config: reltool.config.in
	$(eval VSN := $(shell git describe --always --tags | sed s/-/_/g))
	m4 -DRELVSN="${VSN}" reltool.config.in > reltool.config

clean:
	rm -f reltool.config
