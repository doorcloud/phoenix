# Launching a [Phoenix](https://hexdocs.pm/phoenix) (Elixir) Application with Docker

This guide explains how to set up and launch a [Phoenix](https://hexdocs.pm/phoenix) (Elixir) application with Apache using Docker.

## Prerequisites

Before starting, ensure you have the following tools installed on your machine:

- [Docker](https://www.docker.com/products/docker-desktop)

## Dockerfile Content

This Dockerfile configures a container for a [Phoenix](https://hexdocs.pm/phoenix) (Elixir) application.

```Dockerfile
# Use the official Elixir image
FROM elixir:latest

# Install OS dependencies
RUN apt-get update && \
    apt-get install -y postgresql-client

# Create and set the working directory
WORKDIR /app

# Copy application files into the container
COPY . .

# Install application dependencies
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get

# Compile the application
RUN mix compile

# Expose the port used by the Phoenix application
EXPOSE 4000

# Run the Phoenix application
CMD ["mix", "phx.server"]

```
## Steps to Launch the Application

1. Build the Docker Image

To build the Docker image, use the following command in the directory containing the Dockerfile:

```
docker build -t door-phoenix .
```

2. Run the Container

Once the image is built, run a container from this image:

```
docker run -p 8080:4000 door-phoenix
```

3. Access the Application

Open your browser and go to the following URL to see your application running:

```
http://localhost:8080
```

## Publishing the Image on Docker Hub

1. Log In to Docker Hub

Before publishing your image, log in to Docker Hub with your Docker account:

```
docker login
```

2. Tag the Image

Tag the image you built with your Docker Hub username and the image name:

```
docker tag door-phoenix your_dockerhub_username/door-phoenix:latest
```
Replace your_dockerhub_username with your Docker Hub username.

3. Push the Image to Docker Hub

Push the tagged image to Docker Hub:

```
docker push your_dockerhub_username/door-phoenix:latest
```
