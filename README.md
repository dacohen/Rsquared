# Rsquared

A full featured Ruby statistics library with assumption verification to make using statistics easy, 
even with no background.

[![Build Status](https://travis-ci.org/dacohen/Rsquared.png)](https://travis-ci.org/dacohen/Rsquared)

## Installation

Add this line to your application's Gemfile:

    gem 'Rsquared'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install Rsquared

## Usage

You can run a statistical test, with assumption checking by supplying an array of numerical data points:
    >> ttest = Rsquared::TTest.new(data)
    >> ttest.statistic #=> Float
    >> ttest.significant? #=> Boolean

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
