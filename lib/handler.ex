defmodule Handler do
  import Parser

  def handler(request) do
    request
    |> parser
    |> route
    |> response
  end

  @doc "Route function compare entrance data with clauses and the generate a new map for HTTP responce and status"

  def route(%Parser{method: "GET", path: "/visited_domains"} = conv) do
    %{conv | response: "/visited_links", status: 200}
  end

  # links=
  def route(%Parser{method: "POST", path: "/visited_links"} = conv) do
    %{conv | response: "Links was visited", status: 201}
  end

  def route(%Parser{path: path} = conv) do
    %{conv | response: "No path: #{path} here!", status: 404}
  end

  @doc "Prepare to a response"
  def response(conv) do
    """
    #{conv.response} #{status_reason(conv.status)}
    """
  end

  defp status_reason(code) do
    %{
      200 => "OK",
      404 => "Not Found"
    }[code]
  end
end

# GET /path
# params

# POST /path
# params
