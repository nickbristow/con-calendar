FROM mattsp1290/alpine-rails:5.0.6
ENV RUBY_VER 2.7.1
ENV DOCKER true
ENV DEVISE_SECRET_KEY "my secret"

# Install needed packages
RUN apk --update --upgrade add postgresql-dev
# Cleanup
RUN rm -rf /var/cache/apk/* && \
    rm -rf /usr/lib/lib/ruby/gems/*/cache/*


# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
RUN mkdir -p /app 
WORKDIR /app

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY Gemfile Gemfile.lock ./ 
RUN gem install bundler && bundle install --jobs 20 --retry 5 --without development test

# Set Rails to run in production
ENV RAILS_ENV production 
ENV RACK_ENV production

# Copy the main application.
COPY . ./

# Precompile Rails assets
RUN bundle exec rake assets:precompile

# Start puma
CMD bundle exec puma -C config/puma.rb
