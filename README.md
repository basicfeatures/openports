# openports.no

Attempt to make the [OpenBSD package system](https://www.openbsd.org/faq/ports/ports.html) more easily accessible through reactive UIs and basic social networking.

    pkg_add ruby zsh

Make Bundler install gems locally:

    bundle config set path $HOME/.bundle/

Install Rails:

    gem install --user-install rails -- --use-system-libraries

    echo "path+=($HOME/.local/share/gem/ruby/3.0/bin)" >> ~/.zprofile
    source ~/.zprofile

    echo "alias rails='rails30'" >> ~/.zshrc
    source ~/.zshrc

Install gems from `Gemfile`:

    bundle install

    echo "path+=($HOME/.gem/ruby/3.0/bin)" >> ~/.zprofile
    source ~/.zprofile

Install JS package manager Yarn:

    npm install yarn
    echo "path+=($HOME/openports/node_modules/yarn/bin)" >> ~/.zprofile
    source ~/.zprofile

Set up database:

    rails db:drop db:create db:migrate

Import latest ports from `ftp.usa.openbsd.org`:

    rails import:ports

JS, CSS, images and fonts:

    rails javascript:clobber javascript:build
    rails css:clobber css:build
    rails assets:clobber assets:precompile

Misc cleanup:

    rails tmp:clear log:clear

Import latest ports from `ftp.usa.openbsd.org`:

    rails import:ports

