defmodule PubsubQueueTest do
  use ExUnit.Case
  doctest PubsubQueue

  test "greets the world" do
    assert PubsubQueue.hello() == :world
  end
end
