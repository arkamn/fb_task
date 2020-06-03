defmodule Handler do
  import Parser
  import Exred
  import Timestamp

  def handler(request) do
    request
    |> parse_incom_request
    |> route
    |> response
  end

  @doc "Route function compare entrance data with clauses and the generate a new map for HTTP responce and status"

  def route(%Parser{method: "GET", path: "/"} = conv) do
    %{conv | status: 200, resp_body: "Hello!"}
  end

  def route(%Parser{method: "POST", path: "/visited_links"} = conv) do
    map = Poison.Parser.parse!(conv.params, %{})
    links = map["links"]
    Enum.each(links, fn link -> set(timestamp(), link) end)
    %{conv | status: 201, resp_body: "OK"}
  end

  def route(%Parser{method: _, path: path} = conv) do
    %{conv | status: 404, resp_body: "No path #{path} here!"}
  end

  @doc "Prepare to a response"
  def response(conv) do
    """
    #{conv.version} #{conv.resp_body} #{status_reason(conv.status)}
    #{conv.params}
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
