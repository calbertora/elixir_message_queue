defmodule Processor do
  def start_workers(0, _queue), do: {:error, "We need at least 1 worker"}
  def start_workers(n, _queue) when n < 0, do: {:error, "We need at least 1 worker"}
  def start_workers(n, queue) when n > 0 do
    Registry.start_link(keys: :unique, name: __MODULE__)

    Enum.each(1..n, fn _ ->
      pid = spawn(__MODULE__, :worker_loop, [queue])
      Registry.register(__MODULE__, pid, [])
    end)
  end

  def worker_loop(queue) do
    receive do
      message ->
        case message do
          :hello -> IO.puts "Processing message, Hello!"
          :world -> IO.puts "Processing message, World!"
          _ -> IO.puts "Unknown message received."
        end
        :timer.sleep(1_000)
        worker_loop(queue)
    end
  end
end
