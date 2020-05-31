defmodule Controller do
  def index(conv) do
    %{
      conv
      | response: "Visited domains from #{conv.params["?from"]} to #{conv.params["to"]}",
        status: 200
    }
  end

  def show(conv, id) do
    %{
      conv
      | response: "Visited domains #{id} from #{conv.params["?from"]} to #{conv.params["to"]}",
        status: 200
    }
  end

  # links=
  def create(conv, params) do
    %{conv | response: "Links was visited", status: 201}
  end
end
