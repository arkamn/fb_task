defmodule Parser do
  defstruct method: "",
            path: "",
            version: "",
            params: %{},
            resp_body: "",
            domains: [],
            status: nil

  def parse_incom_request(request) do
    [top, par_string] = String.split(request, "\r\n\r\n")
    [req_line | _head_lines] = String.split(top, "\r\n")
    [method, path, version] = String.split(req_line, " ")
    params = par_string
    %Parser{method: method, path: path, version: version, params: params}
  end
end

# << Templates of requests fot testing >>
# POST request (to create array of links from a local file)
# curl -X POST -H "Content-Type: application/json" -d @/Users/arkamn/fb_task/tmp/links.json http://localhost:8999/visited_links

# POST request (to creat array of links from a shell)
# curl -H 'Content-Type: application/x-www-form-urlencoded' -XPOST http://localhost:8999/visited_links -d [{"links": ["https://ya.ru", "https://ya.ru?q=123"]}]

# GET request (to get a visited domains jsor response)
# curl -XGET -H 'Content-Type: application/json' http://localhost:8999/visited_domains -d '?from=1545221231&to=1545217638'
