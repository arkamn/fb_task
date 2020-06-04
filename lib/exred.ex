defmodule Exred do
  def zadd(key, val) do
    {:ok, client} = Exredis.start_link()
    client |> Exredis.query(["ZADD", "time", key, val])
  end

  def zrange_by_score(from, to) do
    {:ok, client} = Exredis.start_link()
    client |> Exredis.query(["ZRANGEBYSCORE", "time", from, to])
  end
end
