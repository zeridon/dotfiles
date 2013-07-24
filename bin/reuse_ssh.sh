#!/bin/bash

PID=`ps -ef | grep ssh-agent | grep zeridon | grep -v grep | awk {'print $2'}`
SSH_AGENT_PID=$PID
SSH_AUTH_SOCK="`ls -1 /tmp/keyring-*/ssh | tail -1`"

export SSH_AGENT_PID;
export SSH_AUTH_SOCK;
