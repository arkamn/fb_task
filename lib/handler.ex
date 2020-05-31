defmodule Handler do
  def handler(request) do
    request
    |> parser
    |> route
    |> response
  end

  @doc "Parser function accepts at the entrance the string request and ther make transformation to a new map"
  def parser(request) do
    [method, path] =
      request
      |> String.split("\n")
      |> List.first()
      |> String.split(" ")

    [_, params] =
      request
      |> String.split("\n")

    parsed_params = parse_params(params)

    # At the exit we have a new map {method, path, responce, status}
    %{
      method: String.upcase(method),
      path: path,
      params: parsed_params,
      response: "",
      status: nil
    }
  end

  def parse_params(params) do
    params
    |> String.trim()
    |> URI.decode_query()
  end

  @doc "Route function compare entrance data with clauses and the generate a new map for HTTP responce and status"
  def route(conv) do
    route(conv, conv.method, conv.path)
  end

  def route(conv, "GET", "/visited_domains") do
    %{conv | response: "/visited_links", status: 200}
  end

  # links=
  def route(conv, "POST", "/visited_links") do
    %{conv | response: "Links was visited", status: 201}
  end

  def route(conv, _, path) do
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
