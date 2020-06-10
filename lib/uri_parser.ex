defmodule URIparser do
  @doc """
  The function retrieves the domain name from the link passed to it

  ## Example
      iex> domain = URIparser.make_domain("http://yandex.ru")
 """
  def make_domain(uri) do
    case URI.parse(uri) do
      %URI{authority: nil} -> URI.parse("http://#{uri}")
      %URI{authority: _} -> URI.parse(uri)
    end
  end
end
