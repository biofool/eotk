#!/bin/sh -x

# platform-independent lib.sh
cd `dirname $0` || exit 1
opt_dir=`pwd`
. ./lib.sh || exit 1

# platform dependencies
shared_deps="
curl
gcc
libevent-devel
openssl-devel
pcre-devel
"

# build-essential
# curl
# dirmngr
# libssl1.1
# make
# perl
# zlib1g-dev

sudo yum groupinstall 'Development Tools'
sudo yum -y install $shared_deps || exit 1

# build openresty
SetupOpenRestyVars || exit 1
CustomiseVars || exit 1
SetupForBuild || exit 1
ConfigureOpenResty || exit 1
BuildAndCleanup || exit 1

# build tor
SetupTorVars || exit 1
CustomiseVars || exit 1
SetupForBuild || exit 1
ConfigureTor || exit 1
BuildAndCleanup || exit 1

# done
exit 0
