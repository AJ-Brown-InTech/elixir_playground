defmodule ElixirPlayground.Application do

  use Application
  require Logger

 def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: ElixirPlayground.Router, options: [port: 6969]}
    ]
    opts = [strategy: :one_for_one, name: Example.Supervisor]

    Logger.info("Starting application...")

    Supervisor.start_link(children, opts)
  end
end
