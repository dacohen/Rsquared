#! /usr/bin/env bash

version=$(ruby -e "require 'rubygems'" -e "require 'rsquared'" -e "puts Rsquared::VERSION")

gem build Rsquared.gemspec
gem install Rsquared-"$version".gem

