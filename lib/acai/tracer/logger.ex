defmodule Acai.Tracer.Logger do
  import Acai.FileLogger

  def log_supervisor_spawn_message(%{
        spawned: task_pid,
        from: spawner,
        message: {_mod, [_name, acai]}
      }) do
    log_formatted(spawner, {:task, task_pid}, acai.id)
  end

  def log_supervisor_spawn_message(_), do: nil

  def log_genstage_message(%{to: receiver, from: sender, message: events}) when is_list(events) do
    msg = {:snt, length(events)}
    log_formatted(sender, receiver, msg)
  end

  def log_genstage_message(%{to: receiver, from: sender, message: message}) do
    log_formatted(sender, receiver, message)
  end

  def log_genstage_message(_), do: nil

  defp log_formatted(sender, receiver, message) do
    log(:trace, [
      inspect(sender) |> String.pad_trailing(11),
      "=> ",
      inspect(receiver) |> String.pad_trailing(26),
      inspect(message)
    ])
  end
end
