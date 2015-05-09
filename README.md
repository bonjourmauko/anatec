# Anatec's code test

[![Build Status](https://travis-ci.org/maukoquiroga/anatec.svg?branch=master)](https://travis-ci.org/maukoquiroga/anatec)
[![Dependency Status](https://gemnasium.com/maukoquiroga/anatec.svg)](https://gemnasium.com/maukoquiroga/anatec)
[![Coverage Status](https://coveralls.io/repos/maukoquiroga/anatec/badge.svg)](https://coveralls.io/r/maukoquiroga/anatec)
[![Code Climate](https://codeclimate.com/github/maukoquiroga/anatec/badges/gpa.svg)](https://codeclimate.com/github/maukoquiroga/anatec)
[![Inline docs](http://inch-ci.org/github/maukoquiroga/anatec.svg?branch=master)](http://inch-ci.org/github/maukoquiroga/anatec)

## Installation

    $ git clone git@github.com:maukoquiroga/anatec.git
    $ cd anatec
    $ bundle
    $ bundle exec rake db:setup
    $ bundle exec rake db:populate
    $ bundle exec foreman start

  Note: Don't forget to setup your ```database.yml``` file.

## Usage

  Visit ```localhost:5000``` and signup or signin with email ```jean[1..20]@serian.fr``` and password ```password```.

## Tests

    $ bundle exec rspec
