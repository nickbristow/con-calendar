default:
	print 'type make deploy; make compile; make migrate_heroku; make reset_pk;'

run:
	bundle exec rails s

deploy:
	git push heroku master

compile:
	bundle exec rake assets:precompile

migrate_heroku:
	heroku run rake db:migrate
	heroku restart

reset_pk:
	bundle exec rails c
	ActiveRecord::Base.connection.tables.each { |t|     ActiveRecord::Base.connection.reset_pk_sequence!(t) }

heroku_console:
	heroku run rails console

build:
	docker build -t nickbristow/con-calendar:latest .

pg:
	docker-compose -f docker-compose.pg.yml up -d