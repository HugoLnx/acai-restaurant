defmodule Acai.Stock do
  def child_spec(opts) do
    Supervisor.child_spec(
      %{
        id: :"stock_#{opts[:name]}",
        start: {__MODULE__, :start_link, [[name: opts[:name]]]}
      },
      []
    )
  end

  def start_link(opts) do
    GenStage.start_link(__MODULE__.Server, opts[:name], name: opts[:name])
  end
end
