defmodule Acai.Stock do
  use ServerInterface

  @impl ServerInterface
  def child_spec(opts) do
    Supervisor.child_spec(
      %{
        id: :"stock_#{opts[:name]}",
        start: {__MODULE__, :start_link, [[name: opts[:name]]]}
      },
      []
    )
  end

  @impl ServerInterface
  def start_link(opts) do
    GenStage.start_link(__MODULE__.Server, opts[:name], name: opts[:name])
  end
end
