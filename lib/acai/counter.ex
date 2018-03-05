defmodule Acai.Counter do
  use ServerInterface

  @table_name __MODULE__

  @impl ServerInterface
  def start_link(_) do
    GenServer.start_link(__MODULE__.Server, @table_name, name: __MODULE__)
  end

  def increment(name) do
    [v] = :ets.update_counter(@table_name, name, [{2, 1}], {:_, 0})
    v
  end
end
