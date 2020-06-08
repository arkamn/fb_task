defmodule(RedisConTest) do
  use ExUnit.Case

  test "Redis DB connection test" do
    proc = Exredis.start_link()

    assert elem(proc, 0) == :ok
  end
end
