defmodule Acai.FileLogger do
  def log(name, msg) do
    io_list = [
      pretty_shorttime(:erlang.system_time()),
      to_string(name),
      ": ",
      msg,
      "\n"
    ]

    File.write!("./logs/#{name}.log", io_list, [:append])
  end

  defp pretty_shorttime(time) do
    min = time |> div(1000 * 1000 * 1000 * 60) |> rem(60)
    seg = time |> div(1000 * 1000 * 1000) |> rem(60)
    millis = time |> div(1000 * 1000) |> rem(1000)
    :io_lib.format("~2..0B:~2..0B.~3..0B ", [min, seg, millis])
  end
end
