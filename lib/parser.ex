defmodule Parser do
  defstruct method: "", path: "", version: "", params: %{}, status: nil

  def parse_incom_request(request) do
    [top, par_string] = String.split(request, "\n\n")
    [req_line | _head_lines] = String.split(top, "\n")
    [method, path, version] = String.split(req_line, " ")
    params = par_string

    %Parser{method: method, path: path, version: version, params: params}
    |> parse_params
  end

  defp parse_params(%Parser{method: "POST"} = conversion) do
    params = Poison.decode!(conversion.params)
    %{conversion | params: params}
  end

  defp parse_params(%Parser{method: "GET"} = conversion) do
    trim = String.trim(conversion.params)
    params = URI.decode_query(trim)
    %{conversion | params: params}
  end
end

# curl -XGET -H 'Content-Type: application/json' http://localhost:8999/visited_domains -d '?from=1545221231&to=1545217638'
get = """
GET /visited_domains HTTP/1.1
Host: localhost:8999
User-Agent: curl/7.43.0
Accept: */*
Content-Type: application/json
ontent-Length: 30

?from=1545221231&to=1545217638
"""

# curl -H 'Content-Type: application/json' -XPOST http://localhost:8999/visited_links -d '{"links": ["https://ya.ru","https://ya.ru?q=123","funbox.ru","https://stackoverflow.com/questions/11828270/how-to-exit-the-vim-editor"]}'
# curl -X POST -H "Content-Type: application/json" -d @/Users/arkamn/fb_task/tmp/links.json http://localhost:8999/visited_links
post = """
POST /visited_links HTTP/1.1
Host: localhost:8999
User-Agent: curl/7.43.0
Accept: */*
Content-Type: application/json
Content-Length: 136

{"links": ["https://ya.ru","https://ya.ru?q=123","funbox.ru","https://stackoverflow.com/questions/11828270/how-to-exit-the-vim-editor"]}
"""
