defmodule Handler do
  import Parser
  import Exred
  import Timestamp

  def handler(request) do
    request
    |> parse_incom_request
    |> route
    # TODO: emplement a controller function
    |> response
  end

  @doc "Route function compare entrance data with clauses and the generate a new map for HTTP responce and status"

  def route(%Parser{method: "GET", path: "/"} = conv) do
    map =
      conv.params
      |> String.trim()
      |> String.replace("?", "")
      |> URI.decode_query()

    list = zrange_by_score(map["from"], map["to"])
    # IO.puts("from #{map["from"]} to #{map["to"]}")
    # IO.puts(list)
    # zrange_by_score(conv.params["?from"], conv.params["to"])
    %{conv | status: 200, resp_body: "ok"}
  end

  def route(%Parser{method: "POST", path: "/visited_links"} = conv) do
    map = Poison.Parser.parse!(conv.params, %{})
    links = map["links"]
    Enum.each(links, fn link -> zadd(timestamp(), link) end)
    %{conv | status: 201, resp_body: "OK"}
  end

  def route(%Parser{method: _, path: path} = conv) do
    %{conv | status: 404, resp_body: "No path #{path} here!"}
  end

  @doc "Prepare to a response"
  def response(conv) do
    """
    #{conv.version} #{conv.resp_body} #{status_reason(conv.status)}
    """
  end

  defp status_reason(code) do
    %{
      200 => "OK",
      201 => "Created",
      404 => "Not Found"
    }[code]
  end
end

# GET /path
# params

# POST /path
# params
