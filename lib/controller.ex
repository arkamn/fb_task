defmodule Controller do
  @moduledoc """
  Basic HTTP controller functions
  """

  @doc """
  The "show" function takes to the input the parameter string of the form 
  "?from=1545221231&to=1545217638", where "from" is the initial time stamp, 
  "to" is the final time stamp. Time stamps are used to query the range of 
  data from the database. After extraction, the data is converted to json 
  format using the Poison library.
  """
  def show(conv) do
    map =
      conv.params
      |> String.trim()
      |> String.replace("?", "")
      |> URI.decode_query()

    # %{"from" => "131121000000", "to" => "131200000000"}

    if Map.keys(map) == ["from", "to"] do
      # if request's parameters "from" and "to" is correct
      links = Exred.zrange_by_score(map["from"], map["to"])

      domains =
        Enum.map(links, fn x ->
          URIparser.make_domain(x)
          |> Map.get(:authority)
        end)

      # SOLUTION: https://stackoverflow.com/questions/62195250/
      # put-the-data-in-the-list-with-elixir-pipeine-and-enum/62195567#62195567
      new_map = %{domains: []}
      json = %{new_map | domains: domains}
      json_enc = Poison.encode!(json)

      %{conv | status: 200, resp_body: json_enc}
    else
      # else if is wrong
      %{conv | status: 400, resp_body: "Сheck request!\n"}
    end
  end

  @doc """
  The "creat" function takes an array of data of the type {"links"} as 
  input: ["http://first.ru", "https://second.ru", "third.ru", 
  "https://fourth.com/path"]} and stores in a database
  """
  def creat(conv) do
    map =
      conv.params
      |> Poison.Parser.parse!(%{})

    start_time = Time.utc_now()
    Enum.each(map["links"], fn link -> Exred.zadd(Timestamp.timestamp(), link) end)

    %{conv | status: 201, resp_body: "Links created and saved in DB from #{start_time}"}
  end

  @doc """
  The function "error" returns error 404 if it is specified incorrectly
  """
  def error(conv) do
    %{conv | status: 404, resp_body: "No path here!\n"}
  end
end
