#!/usr/bin/env bash
#
# Simple script wrapping reprepro for local packages

BASEDIR='/mnt/nfs.lan/www/apt.getoto.net'

reprepro -Vb ${BASEDIR} $*
