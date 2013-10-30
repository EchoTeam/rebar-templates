# Rebar templates #

## How to use templates ##

To make the templates available, you need to clone the repo to your `~/.rebar/templates` directory:

    git clone git@github.com:EchoTeam/rebar-templates.git ~/.rebar/templates
    
## Examples

### Creating Erlang/OTP service layout

If you want to create a new directory layout for your new service you can do the following:

    $ mkdir service_name
    $ cd service_name
    $ rebar create template=service name=service_name description="Describe your service here."
    $ ./run.me.first.sh

This will generate the initial framework of a service that supports Erlang/OTP releases done through [otp-release-scripts](https://github.com/EchoTeam/otp-release-scripts).

Note: You need rebar installed in your system, or placed in `service_name` directory.
