defmodule Acai.Stock.Server do
  use GenStage

  import Acai.FileLogger, only: [log: 2]

  def init(name) do
    Acai.Tracer.register(name)
    {:producer, %{name: name, produced: 0}}
  end

  def handle_demand(demand, %{name: name, produced: produced} = state) do
    log(name, "Producing #{demand} pulps...")

    pulps =
      for _ <- 1..demand do
        Process.sleep(Acai.Application.cost(name))
        pulp = Acai.Pulp.new(name)
        log(name, " => #{inspect(pulp)}")
        pulp
      end

    log(name, "Finished producing. Total: #{produced + demand}")
    {:noreply, pulps, %{state | produced: produced + demand}}
  end
end
