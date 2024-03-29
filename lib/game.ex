
defmodule Mexgoo.Game do
  use GenServer
  alias Mexgoo.Player
  alias Mexgoo.Gamestate

  @doc """
  Starts a game
  """
  def start_link(player1 = %Player{},  player2 = %Player{} , opts \\ []) do
    GenServer.start_link(__MODULE__, [player1, player2], opts)
  end

  def init([player1, player2]) do
    {:ok, %Gamestate{players: [player1, player2]}}
  end

  def state(server) do
    GenServer.call(server, :state)
  end

  def player(server, number) do
    GenServer.call(server, {:player, number})
  end

  def update_player(server, number, fun) do
    GenServer.call(server, {:update_player, number, fun})
  end

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:player, number}, _from, state = %Gamestate{players: players}) do
    {:reply, Enum.fetch!(players, number), state}
  end

  def handle_call({:update_player, number, fun}, _from, state = %Gamestate{players: players}) do
    updated_players = players |> List.update_at(number, fun)
    {:reply, :ok, %{state | players: updated_players}}
  end
end
