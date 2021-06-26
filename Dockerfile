FROM ruby:2.6.7
ARG RAILS_ENV
ARG RAILS_MASTER_KEY

RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client vim
ENV EDITOR vim
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app


# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000


# Start the main process.
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
