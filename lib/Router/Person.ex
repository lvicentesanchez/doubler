defmodule Router.Person do

    alias Data.Person, as: P
    import Plug.Conn
    import Poison

    use Plug.Router

    plug :match
    plug :dispatch

    match "/", via: :post do
        { :ok, body, conn } = read_body(conn, [])
        { status, body } =
            case decode(body, as: Data.Person) do
                { :ok, %P{name: name, age: age} } when not is_nil(name) and not is_nil(age) ->
                    { 200, encode!(%P{name: name, age: age*2}, []) }
                _ ->
                    { 400, "bad request" }
            end
        send_resp(conn, status, body)
    end

    match _ do
        send_resp(conn, 404, "oops")
    end

end
