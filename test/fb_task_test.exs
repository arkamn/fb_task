defmodule FbTaskTest do
  use ExUnit.Case
  doctest FbTask

  test "greets the world" do
    assert FbTask.hello() == :world
  end
end
