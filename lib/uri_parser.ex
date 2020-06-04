defmodule URIparser do
  def make_domain(uri) do
    case URI.parse(uri) do
      %URI{authority: nil} -> URI.parse("http://#{uri}")
      %URI{authority: _} -> URI.parse(uri)
    end
  end
end
