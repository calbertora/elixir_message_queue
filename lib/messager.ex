defmodule Messager do
  def send_messages(0, _queue) do
    {:error, "We need least 1 message"}
  end

  def send_messages(quantity, queue) do
    1..quantity |> Enum.each(fn _ ->
      number = Enum.random(0..1)

      message = case number do
        0 -> :hello
        1 -> :world
      end

      send(queue, message)
    end)
    {:ok, "Generating Messages"}
  end
end
