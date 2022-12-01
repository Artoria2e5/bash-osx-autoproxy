#!/bin/bash
# Auto configure bash proxy env based on system preferences
# Sukka (https://skk.moe)
# Artoria2e5 (bash 3 translation)
__OSX_AUTOPROXY_SELF=${BASH_SOURCE[0]}

# bash 3 compat. dumbass version of a declare -A
# and we don't have declare -n, great
__osx_autoproxy_set() {
    # assume no \n after $2 lol
    local key=$1 val=$(printf %q "$2")
    eval "__OSX_AUTOPROXY_DICT_$key=$val"
}
__osx_autoproxy_get() {
    eval "printf '%s\n' __OSX_AUTOPROXY_DICT_$1"
}
__osx_autoproxy_has () {
    # forgive my debts 
    eval "[ -n ${__OSX_AUTOPROXY_DICT_$1+x} ]"
}


# Parse the output of scutil --proxy
__OSX_AUTOPROXY_SCUTIL_PROXY=$(scutil --proxy)
while read -r field sep value <<< "$__OSX_AUTOPROXY_SCUTIL_PROXY"; do
    if [[ sep != : ]]; then continue; fi
    __osx_autoproxy_set field value
done

# yeah why not
for proto in HTTP HTTPS FTPS SOCKS; do
    if (( $(__osx_autoproxy_get ${proto}Enabled) )); then
        __osx_autoproxy_set
            '${proto}String'
            "$(__osx_autoproxy_get ${proto}Proxy):$(__osx_autoproxy_get ${proto}Port)"
    fi
done

# this keyboard hurts. let's get lazier
__osx_autoproxy_export() {
    local to_export=$1 value=$2
    unset $to_export
    eval "to_export=$(printf %q "$2")"
    export $to_export
}
__osx_autoproxy_assign() {
    local key=$1 to_export
    shift
    if !__osx_autoproxy_has $key; then return; fi
    local val="$(__osx_autoproxy_get $key)"
    for to_export; do
        __osx_autoproxy_export $to_export "$val"
    done
}

__osx_autoproxy_assign HTTPString http_proxy HTTP_PROXY
__osx_autoproxy_assign HTTPSString https_proxy HTTPS_PROXY
__osx_autoproxy_assign FTPSString ftp_proxy FTP_PROXY
__osx_autoproxy_assign SOCKSString socks_proxy SOCKS_PROXY

if __osx_autoproxy_has SOCKSString; then
    __osx_autoproxy_export all_proxy "$(__osx_autoproxy_get SOCKSString)"
    export ALL_PROXY="${all_proxy}"
elif __osx_autoproxy_has HTTPString; then
    __osx_autoproxy_export all_proxy "$(__osx_autoproxy_get HTTPString)"
    export ALL_PROXY="${all_proxy}"
fi

__osx_autoproxy_reload() {
    source $__OSX_AUTOPROXY_SELF
}
