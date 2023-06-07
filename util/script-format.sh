#!/bin/bash

# For *.script files

die() {
    echo "$@" >&2
    exit 1
}

fn="$1"
[ -e "$fn" ] || die "$fn does not exist"
# fn=`basename "$f"`
# need to install
recode cp1251..utf8 "$fn"
# GNU sed
sed -i '$a\\n-- vim:ft=lua fenc=utf-8' "$fn"
# 120 too much
sed -i -E 's/^(-{80}).*/\1/' "$fn"
# not-lua comments in some scripts
sed -i -E 's!^//([^/])!--\1!' "$fn"
sed -i -E 's!^/\*\*$!--[[!' "$fn"
sed -i -E 's!^/\*\*/$!--]]!' "$fn"
# need to compile and install
lua-format -i "$fn"
