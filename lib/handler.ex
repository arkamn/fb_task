defmodule Handler do
  import Parser

  def handler(request) do
    request
    |> parse_incom_request
    |> route_to_controller
    |> send_response

    # TODO: Configure the socket response
  end

  @doc "Route function compare entrance request data with clauses and then generate a new map for HTTP responce body and status"

  def route_to_controller(%Parser{method: "GET", path: "/"} = conv) do
    %{conv | status: 200, resp_body: "Hello!\n"}
  end

  def route_to_controller(%Parser{method: "GET", path: "/visited_domains"} = conv) do
    Controller.show(conv)
  end

  def route_to_controller(%Parser{method: "POST", path: "/visited_links"} = conv) do
    Controller.creat(conv)
  end

  def route_to_controller(%Parser{method: _, path: path} = conv) do
    %{conv | status: 404, resp_body: "No path #{path} here!\n"}
  end

  def send_response(%Parser{} = conv) do
    """
    \n\nHTTP/1.1 #{Conv.full_status(conv)}
    \rContent-Type: application/json
    \rContent-Length: #{String.length(conv.resp_body)}

    \r#{conv.resp_body}\n
    """
  end
end
