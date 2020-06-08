defmodule Conv do
  @moduledoc """
  HTTP status codes
  """
  def full_status(conv) do
    "#{conv.status} #{status_reason(conv.status)}"
  end

  defp status_reason(code) do
    %{
      200 => "OK",
      201 => "Created",
      400 => "Bad Request",
      404 => "Not Found"
    }[code]
  end
end
