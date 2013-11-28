# Basic development workflow

### Creating an initial framework of your future service:

    $ mkdir <service_name>
    $ cd <service_name>
    $ rebar create template=service name=<service_name> description="Describe your service here."
    $ ./run.me.first.sh

See also [README.md](README.md).

### Cloning and running a fresh repo:

    $ git clone <url-to-the-repo>
    $ cd <service-name>
    $ make get-deps
    $ make run

### Changing code

    $ make run
    $ vim deps/<your-app>/src/<your-module>.erl

All changed modules will be automatically compiled and loaded to Erlang VM using
[sync](https://github.com/rustyio/sync).
See also [make run](service_MAKE.md#make-run).

### Cheking how target system building works:

    $ git commit
    $ make target

### Cheking how upgrade building works:

    $ OLD_REV=`git rev-parse HEAD`
    $ git commit
    $ make upgrade-from=$OLD_REV




See also [Makefile targets](service_MAKE.md).
