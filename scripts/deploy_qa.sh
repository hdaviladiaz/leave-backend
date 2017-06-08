#!/bin/bash
heroku maintenance:on --app "leave-ui-qa"
heroku git:remote -a "leave-ui-qa"
pwd
git remote -v
git push -f heroku master
heroku maintenance:off --app "leave-ui-qa"
