defmodule(ParserPostTest) do
  use ExUnit.Case
  import Parser, only: [parse_incom_request: 1]

  test "POST parsed struct" do
    request = """
    POST /visited_links HTTP/1.1\r
    Host: localhost:8999\r
    User-Agent: curl/7.43.0\r
    Accept: */*\r
    Content-Type: application/json\r
    Content-Length: 136\r
    \r
    {"links": ["https://ya.ru","https://ya.ru?q=123","funbox.ru","https://stackoverflow.com/questions/11828270/how-to-exit-the-vim-editor"]}
    """

    response = parse_incom_request(request)

    assert response ==
             %Parser{
               domains: [],
               method: "POST",
               params:
                 "{\"links\": [\"https://ya.ru\",\"https://ya.ru?q=123\",\"funbox.ru\",\"https://stackoverflow.com/questions/11828270/how-to-exit-the-vim-editor\"]}\n",
               path: "/visited_links",
               resp_body: "",
               status: nil,
               version: "HTTP/1.1"
             }
  end
end
