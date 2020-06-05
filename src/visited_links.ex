defmodule VisitedLinks do
  alias Links

  def list_links do
    [
      %Links{id: 1, link: "https://ya.ru"},
      %Links{id: 2, link: "https://ya.ru?q=123"},
      %Links{id: 3, link: "funbox.ru"},
      %Links{
        id: 4,
        link: "https://stackoverflow.com/questions/11828270/how-to-exit-the-vim-editor"
      }
    ]
  end
end
