defmodule LiveCommerce.PubSubListener do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @impl true
  def init(state) do
    Phoenix.PubSub.subscribe(System.get_env("APP_PUBSUB") |> String.to_atom(), "topic_name")

    {:ok, state}
  end

  @impl true
  def handle_info(%{message: message}, state) do
    IO.puts("Menssage received: #{message}")
    {:noreply, state}
  end

  @impl true
  def handle_info(_, state) do
    {:noreply, state}
  end
end

