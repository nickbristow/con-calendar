# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
require 'fileutils'

Rails.application.load_tasks

namespace 'docker' do
  task :build do
    sh %{ docker build -t nickbristow/con-calendar:latest . }
  end
end

namespace 'heroku' do
  task :console do
    sh %{ heroku run rails console }
  end

  task :deploy do
    sh %{ git push heroku master }
  end

  task :migrate do
    sh %{ heroku run rake db:migrate }
    sh %{ heroku restart }
  end
end

namespace 'pg' do
  task :up do
    sh %{ docker-compose -f docker-compose.pg.yml up -d }
  end

  task :down do
    sh %{ docker-compose -f docker-compose.pg.yml down }
  end
end

namespace 'pk' do
  task :reset do
    ActiveRecord::Base.connection.tables.each { |t|     ActiveRecord::Base.connection.reset_pk_sequence!(t) }
  end
end

task :compile do
  sh %{ bundle exec rake assets:precompile }
end