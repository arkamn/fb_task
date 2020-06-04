defmodule Controller do
  import Exred
  import Timestamp
  import URIparser

  def show(conv) do
    map =
      conv.params
      |> String.trim()
      |> String.replace("?", "")
      |> URI.decode_query()

    links = zrange_by_score(map["from"], map["to"])

    domains =
      Enum.map(links, fn x ->
        make_domain(x)
        |> Map.get(:authority)
      end)

    new_map = %{domains: []}
    json = %{new_map | domains: domains}
    json_enc = Poison.encode!(json)

    %{conv | status: 200, resp_body: json_enc}
  end

  def creat(conv) do
    map =
      conv.params
      |> Poison.Parser.parse!(%{})

    Enum.each(map["links"], fn link -> zadd(timestamp(), link) end)

    %{conv | status: 201, resp_body: "OK"}
  end
end
