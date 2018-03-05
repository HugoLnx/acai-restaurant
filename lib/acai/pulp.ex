defmodule Acai.Pulp do
  defstruct ~w[id quality produced_by]a

  def new(producer_name) do
    %__MODULE__{
      id: :"pulp#{:erlang.unique_integer([:positive])}",
      quality: :rand.uniform(70) + 5,
      produced_by: producer_name
    }
  end
end
