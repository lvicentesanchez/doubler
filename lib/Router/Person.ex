defmodule Router.Person do
    
    import Plug.Conn
    import Poison

    use Plug.Router

    plug :match
    plug :dispatch

    match "/", via: :post do
        { :ok, body, conn } = read_body(conn, [])
        person = decode!(body, as: Data.Person)
        { :ok, response } = encode(%{person | age: person.age*2}, [])
        send_resp(conn, 200, response)
    end

    match _ do
        send_resp(conn, 404, "oops")
    end

end

