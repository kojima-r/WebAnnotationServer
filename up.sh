redis-server
bundle exec sidekiq -q sidekiq
bundle exec rails server -b 0.0.0.0
bundle exec sidekiq -q sidekiq
