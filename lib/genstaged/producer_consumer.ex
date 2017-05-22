defmodule Genstaged.ProducerConsumer do
  use GenStage

  require Integer

  def start_link do
    GenStage.start_link(__MODULE__, :empty, name: __MODULE__)
  end

  def init(state) do
    IO.puts "#{inspect self()} producer consumer"
    {:producer_consumer, state, subscribe_to: [Genstaged.Producer]}
  end

  def handle_events(events, _from, state) do
    numbers =
      events
      |> Enum.filter(&Integer.is_even/1)

    {:noreply, numbers, state}
  end
end
