#!/usr/bin/env bash
#
# Simple script wrapping reprepro for local packages

BASEDIR='/opt/reprepro'

reprepro -Vb ${BASEDIR} $*
