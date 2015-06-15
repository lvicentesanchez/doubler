defmodule Main do
    use Application
    
    require Logger

    def start(_type, _args) do
        port = String.to_integer(System.get_env("PORT") || "4000")
        {:ok, _} = Plug.Adapters.Cowboy.http(Router.Person, [], port: port)
        Logger.info("Application started!", [])
        opts = [
          strategy: :one_for_one,
          name: Main.Supervisor
        ]
        Supervisor.start_link([], opts)
        Logger.info("Supervisor started!", [])
    end
end
