defmodule Doorphoenix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DoorphoenixWeb.Telemetry,
      # Doorphoenix.Repo,
      {DNSCluster, query: Application.get_env(:doorphoenix, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Doorphoenix.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Doorphoenix.Finch},
      # Start a worker by calling: Doorphoenix.Worker.start_link(arg)
      # {Doorphoenix.Worker, arg},
      # Start to serve requests, typically the last entry
      DoorphoenixWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Doorphoenix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DoorphoenixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
