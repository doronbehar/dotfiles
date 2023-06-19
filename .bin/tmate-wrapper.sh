#!/bin/sh

# ~/.tmate.session is stored in my ~/.ssh/tmate.conf as well - secretly - not git tracked
# ~/.tmate-api.key is given by the web app.
tmate -n $(cat ~/.tmate.session) -k $(cat ~/.tmate-api.key) -a ~/.ssh/authorized_keys
