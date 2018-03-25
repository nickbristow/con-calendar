deploy:
	git push heroku master

compile:
	bundle exec rake assets:precompile