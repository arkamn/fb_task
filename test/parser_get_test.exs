defmodule(ParserGetTest) do
  use ExUnit.Case
  import Parser, only: [parse_incom_request: 1]

  test "GET parsed struct" do
    request = """
    GET /visited_domains HTTP/1.1\r
    Host: localhost:8999\r
    User-Agent: curl/7.43.0\r
    Accept: */*\r
    Content-Type: application/json\r
    ontent-Length: 30\r
    \r
    ?from=1545221231&to=1545217638
    """

    response = parse_incom_request(request)

    assert response ==
             %Parser{
               domains: [],
               method: "GET",
               params: "?from=1545221231&to=1545217638\n",
               path: "/visited_domains",
               resp_body: "",
               status: nil,
               version: "HTTP/1.1"
             }
  end
end
