defmodule Acai.Tracer.Server do
  use GenServer

  def init(_) do
    {:ok, %{processes: %{}}}
  end

  def handle_call({:register, process_name}, _from, %{processes: processes} = state) do
    pid = Process.whereis(process_name)

    {:reply, {:ok, {process_name, pid}},
     %{state | processes: Map.put(processes, pid, process_name)}}
  end

  def handle_info(
        {:trace_ts, spawner_pid, :spawn, spawned_pid,
         {_, _, [_, _, _, _, [_, {task_module, _, args}]]}, _timestamp},
        %{processes: processes} = state
      ) do
    Acai.Tracer.Logger.log_supervisor_spawn_message(%{
      spawned: spawned_pid,
      from: processes[spawner_pid],
      message: {task_module, args}
    })

    {:noreply, state}
  end

  def handle_info(
        {:trace_ts, pid, _tracing_type,
         {_message_namespace, {message_sender_pid, _monitor}, message}, _timestamp},
        %{processes: processes} = state
      ) do
    Acai.Tracer.Logger.log_genstage_message(%{
      from: processes[message_sender_pid],
      to: processes[pid],
      message: message
    })

    {:noreply, state}
  end

  def handle_info(_msg, state) do
    # IO.inspect(msg)
    {:noreply, state}
  end
end
