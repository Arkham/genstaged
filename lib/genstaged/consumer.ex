defmodule Genstaged.Consumer do
  use GenStage

  def start_link do
    GenStage.start_link(__MODULE__, 0)
  end

  def init(state) do
    IO.puts "#{inspect self()} consumer"
    {:consumer, state, subscribe_to: [Genstaged.ProducerConsumer]}
  end

  def handle_events(events, _from, state) do
    Process.sleep(1000)

    for event <- events do
      IO.inspect {self(), event, state}
    end

    {:noreply, [], state + length(events)}
  end
end
