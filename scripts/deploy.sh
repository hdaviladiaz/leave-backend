#!/bin/bash
heroku maintenance:on --app "$1"
heroku git:remote -a "$1"
git push -f heroku master
heroku maintenance:off --app "$1"
