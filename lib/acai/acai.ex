defmodule Acai do
  defstruct ~w[id flavor pulp]a

  def new(%Acai.Pulp{quality: quality} = pulp) do
    %__MODULE__{
      id: :"acai#{:erlang.unique_integer([:positive])}",
      flavor: quality + :rand.uniform(100 - quality),
      pulp: pulp
    }
  end
end
