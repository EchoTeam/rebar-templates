.PHONY: sys.config clean

all: sys.config

sys.config: sys.config.in
	m4 -DLOG_DIR="$(LOG_DIR)" sys.config.in > sys.config

clean:
	rm -f sys.config
