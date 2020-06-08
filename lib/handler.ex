defmodule Handler do
  def handler(request) do
    request
    |> Parser.parse_incom_request()
    |> route_to_controller
    |> prepare_response
  end

  @doc "Route function compare entrance request data with clauses and then 
  call the Controller's module functions"

  def route_to_controller(%Parser{method: "GET", path: "/visited_domains"} = conv) do
    Controller.show(conv)
  end

  def route_to_controller(%Parser{method: "POST", path: "/visited_links"} = conv) do
    Controller.creat(conv)
  end

  def route_to_controller(%Parser{method: _method, path: _path} = conv) do
    Controller.error(conv)
  end

  @doc """
  Template of HTTP response
  """
  def prepare_response(%Parser{} = conv) do
    """
    \n\nHTTP/1.1 #{Conv.full_status(conv)}
    \rContent-Type: application/json
    \rContent-Length: #{String.length(conv.resp_body)}

    \r#{conv.resp_body}\n
    """
  end
end
