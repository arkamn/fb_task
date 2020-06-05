defmodule IntoDb do
  def make_time_stamp() do
    time = Time.utc_now()
    hour = string_transform(time.hour)
    minute = string_transform(time.hour)
    second = string_transform(time.second)
    "#{hour}#{minute}#{second}"
  end

  def string_transform(val) do
    str = Integer.to_string(val)

    if String.length(str) < 2 do
      "#{0}#{str}"
    else
      str
    end
  end
end
