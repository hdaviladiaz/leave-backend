#!/bin/bash
bundle config path ~/.vendor/bundle
bundle install
rake test:unit
