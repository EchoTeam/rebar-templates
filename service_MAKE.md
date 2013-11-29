# Makefile targets


## Intro

Many targets extensively use [rebar](https://github.com/rebar/rebar).
A specific rebar version is included into the project codebase.
If you remove rebar from the project, the Makefile targets will try
to find system wide rebar. But it is not recommended to do so.
Rebar is a rapidly changing project and often becomes incompatible with
plugins. Your rebar may appear not working as you expected at some point.


## make or make all or make compile

Compiles the project. Compilation is performed by running `rebar compile`
on each application/dependency.
So it is crucial for all deps to make sure that all the code (including ports)
is compiled with `rebar compile`. Use rebar hooks to achieve this.


## make get-deps

Downloads all deps of the project using rebar.config.lock. See more
about it in [Working with deps](service_DEPS.md).


## make update-deps

Updates deps repositories using rebar.config.lock.


## make update-lock

Generates new rebar.config.lock by re-downloading all deps.
It is recommended that you git commit and push code in all deps
before running it.
It is possible to only update specific deps using `apps` option:

    $ make update-lock apps=lager,lager_syslog

In the last case you will be asked if you want to continue because partial
update-lock works though removing deps specified.

[More info about rebar.config.lock](service_DEPS.md)


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


## make upgrade

Generates an Erlang release upgrade upon what is currently in
`rel/{service_name}` directory. For development environment only.
A use case might be as shown below:

    $ make target # it will generate rel/{service_name} directory
    $ git checkout {an_older_rev} # checking out a specific past git revision
    $ make upgrade

You can find the upgrade in `rel/{service_name}_{relvsn}.tar.gz


## make upgrade-from

Generates an Erlang release upgrade of the current git HEAD upon a specific
git revision. For development environment only. It is a shortcut for
the use case described in the prvious section. It is better to commit all
changes before using this. Example:

    $ git co -b {my_branch}
    $ working...
    $ git commit .
    $ make upgrade-from rev=master
