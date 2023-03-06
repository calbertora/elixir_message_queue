defmodule Processor do
  def start_workers(0), do: {:error, "We need at least 1 worker"}
  def start_workers(n) when n < 0, do: {:error, "We need at least 1 worker"}
  def start_workers(n) when n > 0 do
    Registry.start_link(keys: :unique, name: :processor)

    Enum.each(1..n, fn _ ->
      pid = spawn(Processor, :worker_loop, [])
      Registry.register(:processor, pid, pid)
    end)

    start_processing()
  end

  def start_processing() do
    workers = Registry.keys(:processor, self())
    process_message(PubSubQueue.get_message(), workers)
  end

  defp process_message([], _), do: {:ok, "All messages processed"}
  defp process_message(message, workers) do
    new_workers = round_robin(workers)
    worker = hd(new_workers)
    send(worker, {message, worker})
    process_message(PubSubQueue.get_message(), new_workers)
  end

  defp round_robin(workers) do
    [first_worker | rest] = workers
    rest ++ [first_worker]
  end

  def worker_loop() do
    receive do
      message ->
        case message do
          {{id, :hello}, worker} -> IO.puts "Hello, I'm the process #{inspect worker} and I am processing message #{id}, Hello!"
          {{id, :world}, worker} -> IO.puts "Hello, I'm the process #{inspect worker} and I am processing message #{id}, World!"
          _ -> IO.puts "Unknown message received."
        end
        :timer.sleep(3_000)
        worker_loop()
    end
  end
end
