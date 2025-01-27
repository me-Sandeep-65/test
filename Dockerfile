# Using Python 3.8 base image
FROM python:3.8-slim

# Install curl
RUN apt-get update && apt-get install -y curl

# Setting  working directory
WORKDIR /app

# Copy the requirements.txt first to take advantage of Docker caching
COPY requirements.txt /app/

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . /app/

# Expose the port that Gunicorn will run on
EXPOSE 7755

# Set the environment variable for Flask
ENV FLASK_APP=core/server.py

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the default command to execute the run.sh script
CMD ["/app/run.sh"]
# CMD ["ls", "/app"]

