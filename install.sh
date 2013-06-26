#! /usr/bin/env bash

version=$(ruby -e "require './lib/Rsquared/version.rb'" -e "puts Rsquared::VERSION")
echo $version

gem build Rsquared.gemspec
gem install Rsquared-0.0.1.gem

