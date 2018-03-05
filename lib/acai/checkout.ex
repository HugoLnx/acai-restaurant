defmodule Acai.Checkout do
  use ServerInterface

  @impl ServerInterface
  def child_spec(opts) do
    Supervisor.child_spec(
      %{
        id: :"checkout_#{opts[:name]}",
        start: {__MODULE__, :start_link, [opts]}
      },
      []
    )
  end

  @impl ServerInterface
  def start_link(opts) do
    ConsumerSupervisor.start_link(
      __MODULE__.Supervisor,
      [name: opts[:name], producers: opts[:subscribe_to]],
      name: opts[:name]
    )
  end
end
