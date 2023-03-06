# PubsubQueue

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `pubsub_queue` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:pubsub_queue, "~> 0.1.0"}
  ]
end
```
To use it:
In a iex type:

```elixir
iex(1)> PubSubQueue.start_link([])
{:ok, #PID<0.161.0>}
iex(2)> Messenger.send_messages(30)
{:ok, "Generating Messages"}
iex(3)> Processor.start_workers 3
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/pubsub_queue>.

