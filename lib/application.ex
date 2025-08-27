defmodule ElixirPlayground.Application do

  use Application
  require Logger

 def start(_type, _args) do

    Logger.info("Elixir Playground is starting")
  
  # set env vars
    port = get_env("PORT", "4000") |> String.to_integer()

    children = [
      {Plug.Cowboy, scheme: :http, plug: ElixirPlayground.Router, options: [port: port]}
    ]
    opts = [strategy: :one_for_one, name: Example.Supervisor]

    Logger.info("Starting application on port #{port}...")

    Supervisor.start_link(children, opts)
  end

  def get_env(var, default) do
      case System.get_env(var) do
        nil -> default
        "" -> default
         value -> value 
      end
  end
 
end
