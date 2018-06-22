#!/bin/sh
xlock -mode blank -startCmd "ssh-add -D; gpg-connect-agent reloadagent /bye"
