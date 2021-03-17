#!/usr/bin/env bash


path="$HOME/workspace/shell_tools/rails_app/yohanwms"
mkdir -p $path

cd $path

#clona a aplicação
git clone git@gitlab.com:yohanwms/yohanwms.git .
#builda o container
docker-compose build
#bundle install
docker-compose run --rm web bundle install


read -p "\n\nDeseja criar database.yml? Y/n: " has_db_file
if [ $has_db_file != "n" ]
then
 read -p "\n\nNome do banco: " db_name
 db_file="config/database.yml"
 db_yml="
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  host: postgres
  user: postgres
  password: mypassword
development:
  <<: *default
  database: $db_name
test:
  <<: *default
  database: '$db_name'_test
"

  echo $db_yml >> $db_file
fi 

#cria o banco
$ docker-compose run --rm web bundle exec rails db:create
#executa migrations
docker-compose run --rm web bundle exec rails db:migrate

echo "\n\n Instalado com sucesso";

