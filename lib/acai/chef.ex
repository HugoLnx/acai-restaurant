defmodule Acai.Chef do
  def child_spec(opts) do
    Supervisor.child_spec(
      %{
        id: :"chef_#{opts[:name]}",
        start: {__MODULE__, :start_link, [opts]}
      },
      []
    )
  end

  def start_link(opts) do
    GenStage.start_link(
      __MODULE__.Server,
      [name: opts[:name], producers: opts[:subscribe_to]],
      name: opts[:name]
    )
  end
end
