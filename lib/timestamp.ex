defmodule Timestamp do
  @doc """
  Function returns a timestamp
  """
  @spec timestamp() :: integer()

  def timestamp() do
    Time.utc_now()
    |> Time.to_iso8601()
    |> String.replace(":", " ")
    |> String.replace(".", " ")
    |> String.replace(" ", "")
    |> String.to_integer()
  end
end
