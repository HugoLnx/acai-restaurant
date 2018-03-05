defmodule Acai.Counter.Server do
  use GenServer

  def init(table_name) do
    :ets.new(table_name, [:named_table, :set, :public])
    {:ok, nil}
  end
end
