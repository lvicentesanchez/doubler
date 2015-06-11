defmodule Router.Person do
    import Data.Person

    use Plug.Router

    plug :match
    plug :dispatch

    match "/", via: :post do
        { :ok, body, conn } = Plug.Conn.read_body(conn, [])
        person = Poison.decode!(body, as: Data.Person)
        send_resp(conn, 200, Poison.Encoder.encode(%{person | age: person.age*2}, []))
    end

    match _ do
        send_resp(conn, 404, "oops")
    end
end
