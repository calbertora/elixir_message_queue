defmodule Messenger do
  def send_messages(0) do
    {:error, "We need least 1 message"}
  end

  def send_messages(quantity) do
    1..quantity |> Enum.each(fn id ->
      number = Enum.random(0..1)

      message = case number do
        0 -> {id, :hello}
        1 -> {id, :world}
      end

      PubSubQueue.push_message(message)
    end)
    {:ok, "Generating Messages"}
  end
end
