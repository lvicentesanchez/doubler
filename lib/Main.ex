defmodule Main do
    def main(_args) do
        port = String.to_integer( System.get_env("PORT") || "4000" )
        {:ok, _} = Plug.Adapters.Cowboy.http Router.Person, [], port: port
        :timer.sleep(:infinity)
    end
end
