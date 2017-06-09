#!/bin/bash
heroku maintenance:on --app "$1"
git remote rm heroku
heroku git:remote -a "$1"
vault auth -method=cert -client-cert=/home/go/vault-certs/gocd-agent.crt -client-key=/home/go/vault-certs/gocd-agent.key
heroku config:set TOKEN_JIGSAW = vault read --field=value secret/jigsaw
git push -f heroku master
heroku maintenance:off --app "$1"
