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

    # SOLUTION: https://stackoverflow.com/questions/62195250/put-the-data-in-the-list-with-elixir-pipeine-and-enum/62195567#62195567
  end

  def creat(conv) do
    map =
      conv.params
      |> Poison.Parser.parse!(%{})

    start_time = Time.utc_now()
    Enum.each(map["links"], fn link -> zadd(timestamp(), link) end)

    %{conv | status: 201, resp_body: "Links created and saved in DB from #{start_time}"}
  end
end
