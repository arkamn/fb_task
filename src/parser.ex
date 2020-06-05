defmodule Parser do
  defstruct method: "",
            path: "",
            params: %{},
            response: "",
            status: nil

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

    %Parser{
      method: String.upcase(method),
      path: path,
      params: parsed_params
    }
  end

  def parse_params(params) do
    params
    |> String.trim()
    |> URI.decode_query()
  end
end
