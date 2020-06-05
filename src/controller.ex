defmodule Controller do
  import Exredis
  import DBConnector

  @templates_path Path.expand("../templates", __DIR__)

  def index(conv) do
    links =
      VisitedLinks.list_links()
      |> Enum.map(fn call -> "<li>#{call.id} - #{call.link}<li>" end)

    %{conv | response: "string?", status: 200}
  end

  def show(conv, id) do
    %{
      conv
      | response: "Visited domains #{id} from #{conv.params["?from"]} to #{conv.params["to"]}",
        status: 200
    }
  end

  def create_pos(conv) do
    Enum.each(conv, fn link -> set(timestamp(), link) end)
    %{conv | status: 201, resp_body: "Links saved into data base!"}
  end
end
