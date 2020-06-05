defmodule DBConnector do
  # import Exredis

  defstruct err: ""

  def set(key, val) do
    {:ok, client} = Exredis.start_link()
    client |> Exredis.query(["SET", key, val])
  end

  def timestamp() do
    Time.utc_now()
    |> Time.to_iso8601()
    |> String.replace(":", " ")
    |> String.replace(".", " ")
    |> String.split()
  end

  def json() do
    file =
      Path.expand("../tmp", __DIR__)
      |> Path.join("links.json")

    case File.read(file) do
      {:ok, content} ->
        map = Poison.Parser.parse!(content, %{})
        links = map["links"]
        Enum.each(links, fn link -> set(timestamp(), link) end)

      # :os.system_time(:milli_seconds)

      {:error, reason} ->
        %DBConnector{err: reason}
    end
  end
end
