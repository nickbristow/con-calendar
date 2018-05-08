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

reset_pk:
	bex rails c
	ActiveRecord::Base.connection.tables.each { |t|     ActiveRecord::Base.connection.reset_pk_sequence!(t) }

heroku_console:
	heroku run rails console