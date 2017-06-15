#!/bin/bash
set -e
heroku maintenance:on --app "$APP_BACKEND-$APP_ENV"
heroku git:remote --remote heroku --ssh-git "$APP_BACKEND-$APP_ENV"
vault auth -method=cert -client-cert=/home/go/vault-certs/gocd-agent.crt -client-key=/home/go/vault-certs/gocd-agent.key
heroku config:set TOKEN_JIGSAW=$(vault read --field=value secret/jigsaw)
git push -f heroku master
heroku maintenance:off --app "$APP_BACKEND-$APP_ENV"
