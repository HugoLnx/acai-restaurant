defmodule Acai.FileLogger do
  def log(name, msg) do
    path = "./logs/"

    dir_exists?(path)
    |> verify_dir()
    |> write_to_file(name, msg)
  end

  defp dir_exists?(path) do
    if File.dir?(path) do
      {true, path}
    else
      {false, path}
    end
  end

  defp verify_dir({true, path}) do
    path
  end

  defp verify_dir({false, path}) do
    with :ok <- File.mkdir(path) do
      path
    end
  end

  defp write_to_file(path, name, msg) do
    filename = "#{name}.log"

    io_list = [
      pretty_shorttime(:erlang.system_time()),
      to_string(name),
      ": ",
      msg,
      "\n"
    ]

    File.write!(path <> filename, io_list, [:append])
  end

  defp pretty_shorttime(time) do
    min = time |> div(1000 * 1000 * 1000 * 60) |> rem(60)
    seg = time |> div(1000 * 1000 * 1000) |> rem(60)
    millis = time |> div(1000 * 1000) |> rem(1000)
    :io_lib.format("~2..0B:~2..0B.~3..0B ", [min, seg, millis])
  end
end
