#!/bin/bash
bundle config path ~/.vendor/bundle
bundle install
rake db:setup
rake test:unit
