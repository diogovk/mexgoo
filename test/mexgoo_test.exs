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
    %{players: players} = game |> Game.state
    assert [%Player{life: 20}, %Player{life: 20}] = players
  end

  test "Should allow player update", %{game: game} do
    assert %Player{life: 20} = game |> Game.player(0)
    game |> Game.update_player(0, &(%{ &1 | life: 0 }))
    assert %Player{life: 0} = game |> Game.player(0)
  end

  #test "The game should end when one of the players has less than 20 life", %{game: game} do
  #  ended? = game |> Game.state |> Map.get(:ended?)
  #  assert ended? == false
  #  player1 = game |> Game.update_player(1, ) |> Map.put(:lifepoints, 0) |> Game.update_player
  #  Game.set_lifetotal(
  #end
end
