defmodule Acai.Tracer do
  use ServerInterface

  @impl ServerInterface
  def start_link(arg) do
    GenServer.start_link(__MODULE__.Server, arg, name: __MODULE__)
  end

  def register(process_name) do
    {:ok, {_process_name, pid}} = GenServer.call(__MODULE__, {:register, process_name})
    tracer_pid = Process.whereis(__MODULE__)
    :erlang.trace(pid, true, [:receive, :procs, :timestamp, {:tracer, tracer_pid}])
  end
end
