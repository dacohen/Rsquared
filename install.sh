#! /usr/bin/env bash

version=$(ruby -e "require './lib/Rsquared/version.rb'" -e "puts Rsquared::VERSION")

bundle install
gem build Rsquared.gemspec
gem install Rsquared-"$version".gem

