defmodule Recurse do
  def loopy([head | tail]) do
    # [key, value] = [head, tail]
    IO.puts("#{head}")
    loopy(tail)
  end

  def loopy([]) do
    IO.puts("done..")
  end
end

# Recurse.loopy(["yandex.ru", "google.com", "yahoo.com"])
