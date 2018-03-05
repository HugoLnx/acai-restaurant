defmodule Acai.Checkout.Task do
  use Task

  import Acai.FileLogger, only: [log: 2]

  def start_link([name], acai) do
    Task.start_link(__MODULE__, :run, [name, acai])
  end

  def run(name, acai) do
    Process.sleep(Acai.Application.cost(name))
    v = Acai.Counter.increment(name)
    log(name, "#{name} sold #{inspect(acai)} (total: #{v})")
  end
end
