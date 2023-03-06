defmodule PubSubQueue do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    {:ok, []}
  end

  def handle_cast({:push, message}, state) do
    {:noreply, state ++ [message]}
  end

  def handle_call(:pop,  _from, []) do
    {:reply, [], []}
  end

  def handle_call(:pop,  _from, state) do
    [message | tail] = state
    {:reply, message, tail}
  end

  def get_message() do
    GenServer.call(__MODULE__, :pop)
  end

  def push_message(message) do
    GenServer.cast(__MODULE__, {:push, message})
  end
end
