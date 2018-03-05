<h1 align="center">Açaí Restaurant</h1>

<p align="center">
  <img alt="Açaí Restaurant" src="https://github.com/hugolnx/acai-restaurant/blob/master/assets/acai.png?raw=true" width="128">
</p>

<p align="center">
  A simple application using GenStage that trace process messages for studying purposes.
</p>

## Stages Overview
```
    [ Stock ]
     producer
       ||
       ||
       ||  (pulps)
       ||
       ||
       \/
     [Chef]
producer-consumer
       ||
       ||
       ||  (acais)
       ||
       ||
       \/
   [Checkout]
ConsumerSupervisor
       ||
       ||
       ||  (spawn)
       ||
       ||
       \/
 [Checkout.Task]
      Task
```

## Tracing Logs
### logs/trace.log
Contains high level details of the communication between the stages.

Example:
```
15:50.768 trace: :chef      => :stock                    {:subscribe, nil, [min_demand: 3, max_demand: 5]}
15:50.768 trace: :chef      => :stock                    {:ask, 5}
15:50.769 trace: :checkout  => :chef                     {:subscribe, nil, [min_demand: 0, max_demand: 2]}
15:50.769 trace: :checkout  => :chef                     {:ask, 2}
15:52.031 trace: :stock     => :chef                     {:snt, 5}
15:53.037 trace: :chef      => :checkout                 {:snt, 2}
15:53.038 trace: :chef      => :stock                    {:ask, 2}
15:53.039 trace: :checkout  => {:task, #PID<0.255.0>}    :acai1029
15:53.039 trace: :checkout  => {:task, #PID<0.256.0>}    :acai1093
15:53.543 trace: :stock     => :chef                     {:snt, 2}
15:54.039 trace: :checkout  => :chef                     {:ask, 1}
15:54.040 trace: :checkout  => :chef                     {:ask, 1}
15:54.043 trace: :chef      => :stock                    {:ask, 2}
15:54.547 trace: :chef      => :checkout                 {:snt, 1}
15:54.547 trace: :checkout  => {:task, #PID<0.280.0>}    :acai1125
15:54.548 trace: :chef      => :checkout                 {:snt, 1}
15:54.548 trace: :checkout  => {:task, #PID<0.281.0>}    :acai2626
15:54.549 trace: :stock     => :chef                     {:snt, 2}
15:55.549 trace: :checkout  => :chef                     {:ask, 1}
15:55.550 trace: :chef      => :checkout                 {:snt, 1}
15:55.550 trace: :checkout  => {:task, #PID<0.290.0>}    :acai2690
15:55.551 trace: :checkout  => :chef                     {:ask, 1}
15:56.551 trace: :checkout  => :chef                     {:ask, 1}
15:56.553 trace: :chef      => :checkout                 {:snt, 1}
15:56.554 trace: :chef      => :stock                    {:ask, 3}
15:56.554 trace: :chef      => :checkout                 {:snt, 1}
15:56.555 trace: :checkout  => {:task, #PID<0.301.0>}    :acai1157
15:56.555 trace: :checkout  => {:task, #PID<0.302.0>}    :acai1189
15:57.311 trace: :stock     => :chef                     {:snt, 3}
15:57.555 trace: :checkout  => :chef                     {:ask, 1}
15:57.555 trace: :checkout  => :chef                     {:ask, 1}
15:58.560 trace: :chef      => :checkout                 {:snt, 1}
15:58.561 trace: :chef      => :stock                    {:ask, 2}
15:58.562 trace: :chef      => :checkout                 {:snt, 1}
15:58.562 trace: :checkout  => {:task, #PID<0.322.0>}    :acai1317
15:58.563 trace: :checkout  => {:task, #PID<0.324.0>}    :acai2754
15:59.066 trace: :stock     => :chef                     {:snt, 2}
15:59.562 trace: :checkout  => :chef                     {:ask, 1}
15:59.563 trace: :checkout  => :chef                     {:ask, 1}
16:00.568 trace: :chef      => :checkout                 {:snt, 1}
16:00.569 trace: :chef      => :stock                    {:ask, 2}
16:00.570 trace: :checkout  => {:task, #PID<0.343.0>}    :acai2786
```


### logs/stock.log
Contains more detailed information about Stock GenStage behaviour.

Example:
```
15:50.760 stock: Producing 5 pulps...
15:51.016 stock:  => %Acai.Pulp{id: :pulp2370, produced_by: :stock, quality: 6}
15:51.267 stock:  => %Acai.Pulp{id: :pulp2434, produced_by: :stock, quality: 14}
15:51.519 stock:  => %Acai.Pulp{id: :pulp2466, produced_by: :stock, quality: 63}
15:51.772 stock:  => %Acai.Pulp{id: :pulp2498, produced_by: :stock, quality: 33}
15:52.023 stock:  => %Acai.Pulp{id: :pulp2530, produced_by: :stock, quality: 32}
15:52.024 stock: Finished producing. Total: 5
15:53.037 stock: Producing 2 pulps...
15:53.289 stock:  => %Acai.Pulp{id: :pulp2562, produced_by: :stock, quality: 68}
15:53.541 stock:  => %Acai.Pulp{id: :pulp2594, produced_by: :stock, quality: 29}
15:53.542 stock: Finished producing. Total: 7
15:54.043 stock: Producing 2 pulps...
15:54.294 stock:  => %Acai.Pulp{id: :pulp2658, produced_by: :stock, quality: 28}
15:54.546 stock:  => %Acai.Pulp{id: :pulp2722, produced_by: :stock, quality: 53}
15:54.547 stock: Finished producing. Total: 9
15:56.553 stock: Producing 3 pulps...
15:56.805 stock:  => %Acai.Pulp{id: :pulp1221, produced_by: :stock, quality: 15}
15:57.057 stock:  => %Acai.Pulp{id: :pulp1253, produced_by: :stock, quality: 55}
15:57.309 stock:  => %Acai.Pulp{id: :pulp1285, produced_by: :stock, quality: 23}
15:57.310 stock: Finished producing. Total: 12
15:58.560 stock: Producing 2 pulps...
15:58.812 stock:  => %Acai.Pulp{id: :pulp1349, produced_by: :stock, quality: 21}
15:59.064 stock:  => %Acai.Pulp{id: :pulp1381, produced_by: :stock, quality: 71}
15:59.065 stock: Finished producing. Total: 14
16:00.568 stock: Producing 2 pulps...
```

### logs/chef.log
Contains more detailed information about Chef GenStage behaviour.

Example:
```
15:52.031 chef: Receiving pulp2370,pulp2434 and producing acais...
15:52.532 chef:  => %Acai{flavor: 60, id: :acai1029, pulp: %Acai.Pulp{id: :pulp2370, produced_by: :stock, quality: 6}}
15:53.035 chef:  => %Acai{flavor: 95, id: :acai1093, pulp: %Acai.Pulp{id: :pulp2434, produced_by: :stock, quality: 14}}
15:53.036 chef: Finished producing. Total: 2
15:53.037 chef: Receiving pulp2466,pulp2498 and producing acais...
15:53.539 chef:  => %Acai{flavor: 99, id: :acai1125, pulp: %Acai.Pulp{id: :pulp2466, produced_by: :stock, quality: 63}}
15:54.041 chef:  => %Acai{flavor: 83, id: :acai2626, pulp: %Acai.Pulp{id: :pulp2498, produced_by: :stock, quality: 33}}
15:54.042 chef: Finished producing. Total: 4
15:54.043 chef: Receiving pulp2530 and producing acais...
15:54.544 chef:  => %Acai{flavor: 51, id: :acai2690, pulp: %Acai.Pulp{id: :pulp2530, produced_by: :stock, quality: 32}}
15:54.546 chef: Finished producing. Total: 5
15:55.549 chef: Receiving pulp2562,pulp2594 and producing acais...
15:56.050 chef:  => %Acai{flavor: 84, id: :acai1157, pulp: %Acai.Pulp{id: :pulp2562, produced_by: :stock, quality: 68}}
15:56.552 chef:  => %Acai{flavor: 33, id: :acai1189, pulp: %Acai.Pulp{id: :pulp2594, produced_by: :stock, quality: 29}}
15:56.553 chef: Finished producing. Total: 7
15:57.555 chef: Receiving pulp2658,pulp2722 and producing acais...
15:58.056 chef:  => %Acai{flavor: 87, id: :acai1317, pulp: %Acai.Pulp{id: :pulp2658, produced_by: :stock, quality: 28}}
15:58.558 chef:  => %Acai{flavor: 96, id: :acai2754, pulp: %Acai.Pulp{id: :pulp2722, produced_by: :stock, quality: 53}}
15:58.559 chef: Finished producing. Total: 9
15:59.562 chef: Receiving pulp1221,pulp1253 and producing acais...
16:00.064 chef:  => %Acai{flavor: 78, id: :acai2786, pulp: %Acai.Pulp{id: :pulp1221, produced_by: :stock, quality: 15}}
16:00.566 chef:  => %Acai{flavor: 78, id: :acai2818, pulp: %Acai.Pulp{id: :pulp1253, produced_by: :stock, quality: 55}}
16:00.567 chef: Finished producing. Total: 11
16:00.568 chef: Receiving pulp1285 and producing acais...
```

### logs/checkout.log
Contains more detailed information about Checkout ConsumerSupervisor behaviour.

Example:
```
15:54.038 checkout: checkout sold %Acai{flavor: 60, id: :acai1029, pulp: %Acai.Pulp{id: :pulp2370, produced_by: :stock, quality: 6}} (total: 1)
15:54.038 checkout: checkout sold %Acai{flavor: 95, id: :acai1093, pulp: %Acai.Pulp{id: :pulp2434, produced_by: :stock, quality: 14}} (total: 2)
15:55.548 checkout: checkout sold %Acai{flavor: 99, id: :acai1125, pulp: %Acai.Pulp{id: :pulp2466, produced_by: :stock, quality: 63}} (total: 3)
15:55.548 checkout: checkout sold %Acai{flavor: 83, id: :acai2626, pulp: %Acai.Pulp{id: :pulp2498, produced_by: :stock, quality: 33}} (total: 4)
15:56.550 checkout: checkout sold %Acai{flavor: 51, id: :acai2690, pulp: %Acai.Pulp{id: :pulp2530, produced_by: :stock, quality: 32}} (total: 5)
15:57.554 checkout: checkout sold %Acai{flavor: 33, id: :acai1189, pulp: %Acai.Pulp{id: :pulp2594, produced_by: :stock, quality: 29}} (total: 6)
15:57.554 checkout: checkout sold %Acai{flavor: 84, id: :acai1157, pulp: %Acai.Pulp{id: :pulp2562, produced_by: :stock, quality: 68}} (total: 7)
15:59.561 checkout: checkout sold %Acai{flavor: 87, id: :acai1317, pulp: %Acai.Pulp{id: :pulp2658, produced_by: :stock, quality: 28}} (total: 8)
15:59.562 checkout: checkout sold %Acai{flavor: 96, id: :acai2754, pulp: %Acai.Pulp{id: :pulp2722, produced_by: :stock, quality: 53}} (total: 9)
```


## Starting the project
```bash
mix run --no-halt
```

## Customizing
### Configurations
On `config/config.exs` there are 2 configurations:
* duration: To specify the simulation duration in milliseconds.
* costs\_in\_millis: To specify the cost of the stages to handle each event. (Now it uses `Process.sleep` so is like simulating an IO block)


### Adding more processes on a specific stage
To do this you can change the `lib/acai/application.ex` and adapt the `costs_in_millis` configuration.

#### Adding the process on Acai.Application#start
Now, the Supervisor children are specificed as:
```elixir
children = [
	Acai.Tracer,
	{Acai.Stock, [name: :stock]},
	{Acai.Chef, [name: :chef, subscribe_to: [
		{:stock, min_demand: 3, max_demand: 5}
	]]},
	{Acai.Checkout, [name: :checkout, subscribe_to: [
		{:chef, min_demand: 0, max_demand: 2}
	]]}
]
```

If we want to add a new `Stock` process we just need to add a new `child_spec` with a different name and subscribe the `Chef` to it:
```elixir
children = [
	Acai.Tracer,
	{Acai.Stock, [name: :stock]},
	{Acai.Stock, [name: :stock2]}, # Added this line
	{Acai.Chef, [name: :chef, subscribe_to: [
		{:stock, min_demand: 3, max_demand: 5},
		{:stock2, min_demand: 3, max_demand: 5} # And this one
	]]},
	{Acai.Checkout, [name: :checkout, subscribe_to: [
		{:chef, min_demand: 0, max_demand: 2}
	]]}
]
```

#### Adapting the configurations
You will have also to inform the cost to handle each event for this new stock stage.
```elixir
config :acai,
  duration: 10_000,
  costs_in_millis: %{
    stock: 250,
    stock2: 250, # Added this line
    chef: 500,
    checkout: 1000
  }
```

#### Conclusion
Now you can run the project and it will all work well, just keep in mind that this new process will be logged into the file `logs/stock2.log`.

PS.: You can do the same to the `Chef` and `Checkout` processes.
