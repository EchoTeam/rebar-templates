.PHONY: sys.config

all: sys.config

sys.config: sys.config.in
	m4 -DLOG_DIR="$(LOG_DIR)" sys.config.in > sys.config
