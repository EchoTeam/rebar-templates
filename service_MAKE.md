# Makefile targets

## Intro

Many targets extensively use [rebar](https://github.com/rebar/rebar).
By default, the targets try to find system-wide rebar to use. If you
want to use a specific version of rebar or do not have rebar installed,
you can place rebar to the project root directory. All targets will
automatically use that local rebar binary.

## make get-deps

Downloads all deps of the project using rebar.config.lock.

## make update-deps

Updates deps repositories using rebar.config.lock.

## make update-lock

Generates new rebar.config.lock by re-downloading all deps. It is possible
to only update specific deps using `apps` option:

    make update-lock apps=lager,lager_syslog

[More info about rebar.config.lock]()

## make compile

Compiles the project. The same as just `make` or `make all`. Compilation is
performed by running `rebar compile` on each application/dependency.
So it is crucial for all deps to make sure that all the code (including ports)
is compiled with `rebar compile`. Use rebar hooks to achieve this.

## make clean

Clean the project. Make sure that all deps are cleaned with `rebar clean`.
Use rebar hooks if needed.

## make test

Runs eunit tests of the project using `rebar eunit`.

## make target

Generates a complete Erlang release target system and place the files
into `rel/{service_name}` directory.

## make run

Generates a release target system and runs the project.
For development environment only.
You can set `ECHO_DEPS_DIR` environment variable to specify external deps
directory. If the variable is defined, `make run` will be using this directory
to work with deps and not the one inside the project (`deps` directory).
It is useful when you are actively developing some deps. Do not change
`deps` directory inside the project manually. The directory may be wiped out
at any monent.

You can use [make ext-deps](#make-ext-deps) to create an external deps
directory for the first time.

## make upgrade

Generates an Erlang release upgrade upon what is currently in
`rel/{service_name}` directory. For development environment only.
A use case might be as shown below:
 * `make target` (it will generate `rel/{service_name}` directory)
 * checkout a specific past git revision
 * `make upgrade`

You can find the upgrade in `rel/{service_name}_{relvsn}.tar.gz

## make upgrade-from

Generates an Erlang release upgrade of the current git HEAD upon a specific
git revision. For development environment only. It is a shortcut for
the use case described in the prvious section. It is better to commit all
changes before using this. Example:

    make upgrade-from rev=my_branch

## make ext-deps

Creates an external deps directory by downloading all current deps of
the project into it. It can be useful to initially create the directory.
The external dep directory can be useful when using [make run](#make-run).
