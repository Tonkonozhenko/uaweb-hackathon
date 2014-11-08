#!/usr/bin/env bash

sudo apt-get install nodejs libxslt-dev libxml2-dev libpq-dev postgresql postgresql-contrib -y

sudo -u postgres psql <<EOF
alter user postgres with password 'postgres';
EOF

gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3

curl -sSL https://get.rvm.io | bash -s stable

source /usr/local/rvm/scripts/rvm

sudo /usr/local/rvm/bin/rvm requirements

rvm install 2.1.4
rvm use 2.1.4@uwc --create

cd /vagrant
bundle install
bundle exec rake db:create db:migrate db:seed
RAILS_ENV=development bundle exec rails s
