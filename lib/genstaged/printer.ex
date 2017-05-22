defmodule Genstaged.Printer do
  use GenStage

  @doc "Starts the consumer."
  def start_link() do
    GenStage.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    max_demand = Enum.random([1000, 500, 10]) |> IO.inspect
    {:consumer, :ok, subscribe_to: [{Genstaged.Broadcaster, max_demand: max_demand}]}
  end

  def handle_events(events, _from, state) do
    if length(events) != 1 do
      IO.puts "[CONSUMER] #{inspect(self())}: #{length(events)} events, #{List.first(events)}-#{List.last(events)}"
    else
      IO.puts "[CONSUMER] #{inspect(self())}: #{inspect(events)}"
    end

    Process.sleep(1)

    {:noreply, [], state}
  end
end
