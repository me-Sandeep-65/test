#!/bin/bash

# Wait for the app server to start before running tests
echo "Waiting for the app server to start..."
until curl -s http://app:7755; do
  echo "Waiting for server to become available..."
  sleep 2
done

# Run the tests
echo "Running tests..."
pytest -vvv -s tests/

# Capture the test result
if [[ $? -ne 0 ]]; then
  echo "Tests failed. Stopping the Docker container..."
  docker stop fyle-app-container
  exit 1  # Exit with an error if tests fail
else
  echo "All tests passed. The server will keep running."
fi
