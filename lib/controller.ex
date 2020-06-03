defmodule Controller do
  import Exred
  import Timestamp

  defstruct domains: "domains:", list: ""

  def show(conv) do
    map =
      conv.params
      |> String.trim()
      |> String.replace("?", "")
      |> URI.decode_query()

    list = zrange_by_score(map["from"], map["to"])
    %{conv | list: list, resp_body: list, status: 201}
  end

  def creat(conv) do
    map =
      conv.params
      |> Poison.Parser.parse!(%{})

    Enum.each(map["links"], fn link -> zadd(timestamp(), link) end)

    %{conv | status: 201, resp_body: "OK"}
  end
end
