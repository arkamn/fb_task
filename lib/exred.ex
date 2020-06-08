defmodule Exred do
  @moduledoc """
  Redis database features
  """

  @doc """
  The function for save data to db with "time" key
  """
  def zadd(key, val) do
    {:ok, client} = Exredis.start_link()
    client |> Exredis.query(["ZADD", "time", key, val])
  end

  @doc """
  The function for read range of data from db with "time" key
  """
  def zrange_by_score(from, to) do
    {:ok, client} = Exredis.start_link()
    client |> Exredis.query(["ZRANGEBYSCORE", "time", from, to])
  end
end
