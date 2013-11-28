# Basic development workflow

### Creating an initial framework of your future service:

    $ mkdir {service_name}
    $ cd {service_name}
    $ rebar create template=service name={service_name} description="Describe your service here."
    $ ./run.me.first.sh

See also [README.md](README.md).

### Cloning and running a fresh repo:

    $ git clone {url-to-the-repo}
    $ cd {service-name}
    $ make get-deps
    $ make run

### Changing code

    $ make run
    $ vim deps/{your-app}/src/{your-module}.erl

All changed modules will be automatically compiled and loaded to Erlang VM using
[sync](https://github.com/rustyio/sync).
See also [make run](service_MAKE.md#make-run).

### Creating appup files

    $ cd {your-app}
    $ vim src/*.erl # meening you change your code in some way
    $ OLD_REV=`git rev-parse HEAD` # meening your just now the current rev
    $ git commit
    $ genappup $OLD_REV

or

    $ cd {your-app}
    $ git co -b {your-branch}
    $ vim src/*.erl # meening you change your code in some way
    $ git commit
    $ genappup master

After `genappup` is run there will be a new file src/{your-app}.appup.src.
You should revise it, change manually if needed and commit.
At compile time, this file will be automatically copied to ebin/{your-app}.app
(Erlang/OTP releases require the appup file to be there).

Sometimes you will need the appup file for a third-party application. If the owners do not use
Erlang/OTP releases, most likely there won't be an appup file in the repo.
In this case, you can still run `genappup` against the foreign repo and move
the generated {foreign-app}.appup.src file to your root project src directory.
Your root src dir can look like this:

    ebin/
    deps/
    src/
        {foreign-app1}.appup.src
        {foreign-app2}.appup.src
    priv/

Those files, at compile time, will be place to corresponding applications ebin directories.

See also
[genappup](https://github.com/EchoTeam/genappup) and
[Appup Cookbook](http://www.erlang.org/doc/design_principles/appup_cookbook.html).

### Cheking how target system building works:

    $ git commit
    $ make target

### Cheking how upgrade building works:

    $ OLD_REV=`git rev-parse HEAD`
    $ git commit
    $ make upgrade-from=$OLD_REV




See also [Makefile targets](service_MAKE.md).
