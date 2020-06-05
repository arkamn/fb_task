defmodule Request do
  def req_parser(request) do
    request
    # |> link_spliter
    |> uri_parser
    |> red_client_set
  end

  def link_spliter(request) do
    request
    |> String.split(",")
  end

  def uri_parser(link) do
    domain = URI.parse(link)
    domain.authority
  end

  def red_client_set(link) do
    Exred.set(link)
  end
end

# "https://ya.ru, https://ya.ru?q=123 ,funbox.ru, https://stackoverflow.com/questions/11828270/how-to-exit-the-vim-editor"

# 1..length(list) |> Stream.zip(list) |> Enum.into(%{})
