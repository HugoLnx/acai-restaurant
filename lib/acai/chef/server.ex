defmodule Acai.Chef.Server do
  use GenStage

  import Acai.FileLogger, only: [log: 2]

  def init(opts) do
    Acai.Tracer.register(opts[:name])
    {:producer_consumer, %{name: opts[:name], produced: 0}, [subscribe_to: opts[:producers]]}
  end

  def handle_events(pulps, _from, %{name: name, produced: produced} = state) do
    log(name, "Receiving #{pulps |> Enum.map(& &1.id) |> Enum.join(",")} and producing acais...")

    acais =
      for pulp <- pulps do
        Process.sleep(Acai.Application.cost(name))
        acai = Acai.new(pulp)
        log(name, " => #{inspect(acai)}")
        acai
      end

    log(name, "Finished producing. Total: #{produced + length(acais)}")
    {:noreply, acais, %{state | produced: produced + length(acais)}}
  end
end
