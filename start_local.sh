#!/bin/bash

# Start Redis server
echo "Starting Redis..."
redis-server &

# Start Sidekiq
echo "Starting Sidekiq..."
bundle exec sidekiq &

# Start Rails server
echo "Starting Rails server..."
bundle exec rails server


# Run this script to automatically set up for local
# ./start_local.sh
