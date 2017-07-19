defmodule Router.Person do

    alias  Data.Person, as: P
    import Plug.Conn
    import Poison

    use Plug.Router

    plug :match
    plug :dispatch

    match "/", via: :post do
        { :ok, body, conn } = read_body(conn, [])
        { status, body } =
            case decode(body, as: %P{}) do
                { :ok, %P{ name: name, age: age } } ->
                    if  Vex.valid?(%P{ name: name, age: age }) do
                        { 200, encode!(%P{name: name, age: age*2}, []) }
                    else
                        { 400, "bad request "}
                    end
                {:error, error } ->
                    { 500, error }
            end
        send_resp(conn, status, body)
    end

    match _ do
        send_resp(conn, 404, "oops")
    end

end
