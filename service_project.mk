.PHONY: all compile test clean target upgrade generate bump_version
.PHONY: update_lock get_deps update_deps

REBAR_BIN := $(shell which rebar 2>/dev/null || echo -n "")
ifndef REBAR_BIN
	REBAR_BIN := $(abspath ./)/rel/../rebar # "rel/../" is a workaround for rebar bug
endif
REBAR_FREEDOM := $(REBAR_BIN) -C rebar.config
REBAR_LOCKED  := $(REBAR_BIN) -C rebar.config.lock
REBAR := $(REBAR_FREEDOM)

all: compile

compile:
	$(REBAR) compile
	
update_lock:
	rm -rf deps
	$(REBAR_FREEDOM) get-deps
	$(REBAR_FREEDOM) lock-deps skip_deps=true keep_first=lager

get_deps:
	$(REBAR_LOCKED) get-deps skip_deps=true

update_deps: get_deps
	$(REBAR_LOCKED) update-deps skip_deps=true

bump_version:
	bin/relvsn-bump.sh

generate: update_deps compile bump_version
	$(eval relvsn := $(shell bin/relvsn-get.erl))
	cd rel; $(REBAR_BIN) generate -f
	cp rel/$(SERVICE_NAME)/releases/$(relvsn)/$(SERVICE_NAME).boot rel/$(SERVICE_NAME)/releases/$(relvsn)/start.boot #workaround for rebar bug
	echo $(relvsn) > rel/$(SERVICE_NAME)/relvsn

clean:
	$(REBAR) clean

test:
	$(REBAR) eunit skip_deps=meck,lager

# make target system
target: clean generate

appup: 
	@[ -f rel/$(SERVICE_NAME)/relvsn ] || (echo "Run 'make target' first" && exit 1)
	$(eval prev_vsn := $(shell cat rel/$(SERVICE_NAME)/relvsn))
	-rm -rf rel/$(SERVICE_NAME)_$(prev_vsn)
	mv rel/$(SERVICE_NAME) rel/$(SERVICE_NAME)_$(prev_vsn)
	$(MAKE) generate
	$(REBAR) generate-appups previous_release=$(SERVICE_NAME)_$(prev_vsn)	

# generates upgrade
upgrade:
	@[ -f rel/$(SERVICE_NAME)/relvsn ] || (echo "Run 'make target' first" && exit 1)
	$(eval prev_vsn := $(shell cat rel/$(SERVICE_NAME)/relvsn))
	-rm -rf rel/$(SERVICE_NAME)_$(prev_vsn)
	mv rel/$(SERVICE_NAME) rel/$(SERVICE_NAME)_$(prev_vsn)
	$(MAKE) generate
	cd rel; $(REBAR_BIN) generate-upgrade previous_release=$(SERVICE_NAME)_$(prev_vsn)

upgrade_from: clean
	$(eval cur_rev := $(shell git rev-parse --abbrev-ref HEAD))
	git checkout $(rev)
	$(MAKE) target
	git checkout $(cur_rev)
	$(MAKE) upgrade
