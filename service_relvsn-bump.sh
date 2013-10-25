#!/bin/bash 

# read version number from main application and set it to reltool.config

function abort {
  echo $1
  exit 1
}

DIR=`dirname "${BASH_SOURCE[0]}"`/../

# retrieving version from .app file and change disallowed (for rpm version) char '-' to '_'

VSN=`git describe --always --tags | sed s/-/_/g`

[ $? == 0 ] || abort "Cannot get current verion of main application $VSN"

PREV=`$DIR/bin/relvsn-get.erl`

[ $? == 0 ] || abort "Cannot get base verion of main application"

if [ x$VSN == x$PREV ] ; then
    echo "Current version and version of main app are same. Nothing to upgrade"
else    
    escript $DIR/bin/relvsn-set.erl $VSN
fi

