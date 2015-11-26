defmodule MexgooTest do
  use ExUnit.Case
  doctest Mexgoo
  alias Mexgoo.Game
  alias Mexgoo.Player

  setup do
    { :ok, game } = Mexgoo.Game.start_link(%Player{ name: "Player1"}, %Player{ name: "Player2"} )
    { :ok, game: game}
  end

  test "Both players should start with 20 life each", %{game: game} do
    players = game |> Game.state |> Map.get(:players)
    assert [%Player{lifepoints: 20}, %Player{lifepoints: 20}] = players
  end

end
