#!/bin/sh

rm -f nvim.log && nvim --startuptime nvim.log "$@" -c ':q' && sed -e 's/: / /' nvim.log | sort -k 2,2 > nvim-sorted.log && nvim nvim-sorted.log && rm -f nvim.log nvim-sorted.log

