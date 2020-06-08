defmodule(URIparserTest) do
  use ExUnit.Case
  import URIparser, only: [make_domain: 1]

  test "Make a domain name from URI" do
    domain = make_domain("https://funbox.ru/contacts")
    assert domain.authority == "funbox.ru"

    domain = make_domain("funbox.ru")
    assert domain.authority == "funbox.ru"

    domain = make_domain("www.funbox.ru")
    assert domain.authority == "www.funbox.ru"
  end
end
