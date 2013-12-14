# Echo Rebar Templates #

## How to use templates ##

To make the templates available, you need to clone the repo to your
`~/.rebar/templates` directory:

    mkdir -p ~/.rebar/templates
    git clone git@github.com:EchoTeam/rebar-templates.git ~/.rebar/templates
    
## Creating Erlang/OTP service layout

If you want to create a new directory layout for your new service you can do the following:

    $ mkdir <service_name>
    $ cd <service_name>
    $ rebar create template=service name=<service_name> description="Describe your service here."
    $ ./run.me.first.sh

This will generate the initial framework of an Erlang service that supports
Erlang/OTP releases.

Note: You need rebar installed in your system, or placed in `<service_name>` directory.

See more info on the service layout:
 * [Basic development workflow](service/DEV.md)
 * [Makefile targets](service/MAKE.md)
 * [Working with deps](service/DEPS.md)
