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
