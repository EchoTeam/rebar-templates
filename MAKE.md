# Makefile targets

## make get-deps

Downloads all deps of the project using rebar.config.lock.

## make update-deps

Updates deps repositories using rebar.config.lock.

## make update-lock

Generates new rebar.config.lock by re-downloading all deps. It is possible to only update specific deps using `apps` option:

    make update-lock apps=lager,lager_syslog

[More info about rebar.config.lock]()

## make compile

Compiles the project. The same as just `make` or `make all`.
Compilation is performed by running `rebar compile` on each application/dependency. So it is crucial for all deps to make sure that all the code (including ports) is compiled with `rebar compile`. Use rebar hooks to achieve this.

## make clean

Clean the project. Make sure that all deps are cleaned with `rebar clean`. Use rebar hooks if needed.

## make test

Runs eunit tests of the project using `rebar eunit`.

## make target

Generates a complete Erlang release target system and place the files into `rel/{service_name}` directory.

## make run

Generates a release target system and runs the project. For development environment only.
