## Anatec's code test

### Installation

    $ git clone git@github.com:maukoquiroga/anatec.git
    $ cd anatec
    $ bundle
    $ bundle exec rake db:setup
    $ bundle exec rake db:populate
    $ bundle exec foreman start

  Note: Don't forget to setup your ```database.yml``` file.

### Usage

  Visit ```localhost:5000``` and signup or signin with email ```jean[1..20]@serian.fr``` and password ```password```.

### Tests

    $ bundle exec rspec
