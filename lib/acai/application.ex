defmodule Acai.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      Acai.Tracer,
      Acai.Counter,
      {Acai.Stock, [name: :stock]},
      {Acai.Chef,
       [
         name: :chef,
         subscribe_to: [
           {:stock, min_demand: 7, max_demand: 11}
         ]
       ]},
      {Acai.Checkout,
       [
         name: :checkout,
         subscribe_to: [
           {:chef, min_demand: 13, max_demand: 23}
         ]
       ]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :rest_for_one, name: Acai.Supervisor]
    result = Supervisor.start_link(children, opts)

    if duration() > 0 do
      Task.async(fn ->
        Process.sleep(duration())
        Application.stop(:acai)
      end)
    end

    result
  end

  def duration do
    Application.get_env(:acai, :duration)
  end

  def cost(name) do
    Application.get_env(:acai, :costs_in_millis)[name]
  end
end
