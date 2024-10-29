defmodule LiveCommerce.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    topologies = Application.get_env(:libcluster, :topologies) || []

    children = [
      LiveCommerceWeb.Telemetry,
      LiveCommerce.Repo,
      {DNSCluster, query: Application.get_env(:live_commerce, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: System.get_env("APP_PUBSUB") |> String.to_atom()},
      {Cluster.Supervisor, [topologies, [name: LiveCommerce.ClusterSupervisor]]},
      # Start the Finch HTTP client for sending emails
      {Finch, name: LiveCommerce.Finch},
      # Start a worker by calling: LiveCommerce.Worker.start_link(arg)
      # {LiveCommerce.Worker, arg},
      # Start to serve requests, typically the last entry
      LiveCommerceWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveCommerce.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveCommerceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
