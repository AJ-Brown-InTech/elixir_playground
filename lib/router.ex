defmodule ElixirPlayground.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "ok")
  end

  match _ do
    send_resp(conn, 404, "Error: Not found.")
  end

end
