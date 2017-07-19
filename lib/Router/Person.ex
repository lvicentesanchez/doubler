defmodule Router.Person do

    alias  Data.Person, as: P
    import Plug.Conn
    import Poison

    use Plug.Router

    plug :match
    plug :dispatch

    match "/", via: :post do
        { status, body } =
            with { :ok, body, _ } <- read_body(conn, []),
                 { :ok, user } <- decode(body, as: %P{}),
                 { :ok, _ } <- Vex.validate(user) do
                { 200, encode!(%{ user | age: user.age * 2 }, []) }
            else
                { :error, _ } -> { 400, "bad request" }
            end
        send_resp(conn, status, body)
    end

    match _ do
        send_resp(conn, 404, "oops")
    end

end
