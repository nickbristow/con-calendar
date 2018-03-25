deploy:
	git push heroku master

compile:
	bundle exec rake assets:precompile

reset_pk:
	bex rails c
	ActiveRecord::Base.connection.tables.each { |t|     ActiveRecord::Base.connection.reset_pk_sequence!(t) }