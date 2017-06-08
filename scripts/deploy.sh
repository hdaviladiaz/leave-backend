#!/bin/bash
heroku maintenance:on --app "$1"
git remote rm heroku
heroku git:remote -a "$1"
git push -f heroku master
heroku maintenance:off --app "$1"
