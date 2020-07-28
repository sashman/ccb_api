defmodule CcbApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      CcbApi.Repo,
      # Start the Telemetry supervisor
      CcbApiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: CcbApi.PubSub},
      # Start the Endpoint (http/https)
      CcbApiWeb.Endpoint,
      CcbApi.Vault
      # Start a worker by calling: CcbApi.Worker.start_link(arg)
      # {CcbApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CcbApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    CcbApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
