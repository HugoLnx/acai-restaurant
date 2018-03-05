defmodule Acai.Tracer do
  @tracer_name :tracer

  def child_spec(opts) do
    Supervisor.child_spec(
      %{
        id: __MODULE__,
        start: {__MODULE__, :start_link, [[]]}
      },
      []
    )
  end

  def start_link(_) do
    GenServer.start_link(__MODULE__.Server, nil, name: @tracer_name)
  end

  def register(process_name) do
    {:ok, {_process_name, pid}} = GenServer.call(@tracer_name, {:register, process_name})
    tracer_pid = Process.whereis(@tracer_name)
    :erlang.trace(pid, true, [:receive, :procs, :timestamp, {:tracer, tracer_pid}])
  end
end
