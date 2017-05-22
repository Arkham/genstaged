defmodule Genstaged do
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Genstaged.Producer, [0]),
      worker(Genstaged.ProducerConsumer, []),
      worker(Genstaged.Consumer, [], id: 1),
      worker(Genstaged.Consumer, [], id: 2)
    ]

    opts = [strategy: :one_for_one, name: Genstaged.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
