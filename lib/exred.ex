defmodule Exred do
  def set(key, val) do
    {:ok, client} = Exredis.start_link()
    client |> Exredis.query(["SET", key, val])
  end
end
