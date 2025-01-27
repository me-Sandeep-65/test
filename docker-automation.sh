#!/bin/bash

# Set the Docker image name
IMAGE_NAME="fyle-app"
CONTAINER_NAME="fyle-app-container"

# Build the Docker image
echo "Building Docker image..."
docker build -t $IMAGE_NAME .

# Stop any running containers with the same name (if any)
echo "Stopping any running containers with the name $CONTAINER_NAME..."
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

# Run the Docker container
echo "Starting Docker container..."
docker run -d --name $CONTAINER_NAME -p 8000:7755 $IMAGE_NAME

# run tests after starting the container
echo "Running tests..."
docker exec -it $CONTAINER_NAME pytest -vvv -s tests/

# Check if any test failed (non-zero exit code indicates failure)
if [[ $? -ne 0 ]]; then
    echo "Tests failed. Stopping the Docker container..."
    docker stop $CONTAINER_NAME
    exit 1  # Exit with a non-zero status to indicate failure
else
    echo "All tests passed. The server will keep running."
fi
