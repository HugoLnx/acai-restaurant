defmodule ServerInterface do
  @callback child_spec(arg :: [] | [...]) :: Supervisor.child_spec()

  defmacro __using__(opts) do
    quote do
      @behaviour ServerInterface

      def child_spec(arg) do
        Supervisor.child_spec(
          %{
            id: __MODULE__,
            start: {__MODULE__, :start_link, [arg]}
          },
          unquote(opts)
        )
      end

      defoverridable child_spec: 1
    end
  end
end
