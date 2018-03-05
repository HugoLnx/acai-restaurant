defmodule Acai.Checkout.Supervisor do
  use ConsumerSupervisor

  def init(opts) do
    Acai.Tracer.register(opts[:name])
    children = [{Acai.Checkout.Task, [opts[:name]]}]
    ConsumerSupervisor.init(children, subscribe_to: opts[:producers], strategy: :one_for_one)
  end
end
