# Commandline: 'mix test'
defmodule CardsTest do
  use ExUnit.Case
  doctest Cards # this is called Doc Testing, and it's VERY productive
  ## If this testing module sees any module documentation with an example section inside of it,
  ## it will run that chunk of code pretending that it's on the elixir shell, and run the assertion off the expected result written, like so:

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should
    be in the hand.
  ## Examples
      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """


  ## There are two distinctive types of test that we can run
  ## These test uses assertion to test some singular and particular fact
  test "create_deck makes 20 cards" do
    deck_length = length(Cards.create_deck)
    assert deck_length == 20
  end

  test "shuffling a deck reandomizes it" do
    deck = Cards.create_deck
    assert deck != Cards.shuffle(deck)
    # refute deck == Cards.shuffle(deck) # this is basically the same as the line above, refute is the opposite of assert
  end


end
