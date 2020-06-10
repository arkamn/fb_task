defmodule(TimestampTest) do
  use ExUnit.Case
  doctest Timestamp
  import Timestamp, only: [timestamp: 0]

  test "Make a timestamp" do
    timestamp = timestamp()
    assert is_integer(timestamp)
  end
end
