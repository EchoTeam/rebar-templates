#!/bin/bash
#
# project.sh is the public API for the project and can be invoked by the tools
# like otp-release-scripts.
#
# Commands that are required to be implemented:
#  - make-target
#  - make-upgrade <previous-target-path>
#  - show-project-name
#  - show-build-config
#  - show-relvsn

set -e

ROOT_DIR=$(cd ${0%/*} && pwd)

SERVICE_NAME="{{name}}"

command=$1

case $1 in
    make-target)
        make -C ${ROOT_DIR} target
        ;;
    make-upgrade)
        # $2 is a path relative to ${ROOT_DIR}/rel/
        make -C ${ROOT_DIR} generate-upgrade previous_release="$2"
        ;;
    show-project-name)
        echo -n ${SERVICE_NAME}
        ;;
    show-build-config)
        cat ${ROOT_DIR}/rel/${SERVICE_NAME}/build.config
        ;;
    show-relvsn)
        ${ROOT_DIR}/bin/relvsn.erl
        ;;
    *)
        echo "No known command specified."
        exit 1
        ;;
esac
