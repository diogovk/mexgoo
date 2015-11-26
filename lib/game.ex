
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

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end
end
