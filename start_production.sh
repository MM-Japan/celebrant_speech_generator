#!/bin/bash

# Set Rails environment to production
export RAILS_ENV=production

# Start Redis server
echo "Starting Redis..."
redis-server --daemonize yes

# Start Sidekiq
echo "Starting Sidekiq..."
cd /var/www/celebrant_speech_generator
bundle exec sidekiq -d -L log/sidekiq.log

echo "All services started for production."
