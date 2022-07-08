defmodule Cards do
  def hello do
    "Hi there!"
    # in commandl line: iex -S mix (if we use this instead of just 'iex', then our module is compiled and included in the elixir interactive shell)
    # calling this method works in either syntax: Cards.hello() or Cards.hello
    # to recompile code, in the shell, type 'recompile'
  end



  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]
    # cards = for value <- values do # this is the incorrect method, nested comprehensions will return return nested arrays and we don't want that (unless we fix it using the List.flatten/1 function)
    #   for suit <- suites do # this is a 'list comprehension'. It's essentially a 'for loop' in elixir
    #   "#{value} of #{suit}"
    #   end
    # end
    # List.flatten(cards)
    for suit <- suits, value <- values do # this is the MUCH better cleaner way to handle nested loops
      "#{value} of #{suit}"
    end
  end
  # deck = Cards.create_deck()
  # Cards.shuffle(deck) |> IO.inspect()
  # the above needs to be outside the module at the bottom to work


  def shuffle(deck) do
    Enum.shuffle(deck)
    # iex: 'deck = Cards.create_deck' > enter > 'Cards.shuffle(deck)' > output
  end



  def contains?(deck, card) do
    # adding a ? mark to a method name is convention that the method returns a boolean. The ? mark does nothing to the method
    Enum.member?(deck, card)
  end


  def deal(deck, hand_size) do
    Enum.split(deck, hand_size) # returns a tuple with two values {the hand is index 0, the remainder of the deck is index 1}, these can get destructured to their own variables
  end
  # deck = Cards.create_deck()
  # {hand, rest_of_deck} = Cards.deal(deck, 3)
  # IO.puts hand
  # the above needs to be outside the module at the bottom to work



  def save deck, filename do # this is shorthand syntax, but can look confusing without the parenthesis
    binary = :erlang.term_to_binary(deck) # we are invoking erlang code. The purpose of this line is to take the deck argument and turn it into an object that can be actually saved to the file system (not literal binary)
    File.write(filename, binary) #after we encode the file into a variable, we pass it to File.write
  end
  def load(filename) do
    # {status, binary} = File.read(filename)
    # case status do
    #   :ok -> :erlang.binary_to_term binary # this is basically the reverse of the 'save' function, this is also shorthand syntax
    #   :error -> "That file does not exist" # whatever is on the right side of this arrow gets returned
    # end
    case File.read(filename) do # this is a smarter way to do the same thing, using pattern matching in our case statement to check for the correct response AND assign a new variable at once ("binary" or "reason")
      {:ok, binary} -> :erlang.binary_to_term binary # we're killing two birds with one stone using this syntax: comparison and assignment
      {:error, _reason} -> "That file does not exist" # to fulfill pattern matching requirements, we keep the variable there, but if it's a useless variable, we prefix it with _ or just replace it with _ all together
    end
  end



  def create_hand(hand_size) do
      Cards.create_deck() |> Cards.shuffle() |> Cards.deal(hand_size) # with pipe operators, the first/only arg of each function is passed in from the previous func, so argument order is important
  end


  
end




# defmodule Cards do
#   @moduledoc """
#   Documentation for `Cards`.
#   """

#   @doc """
#   Hello world.

#   ## Examples

#       iex> Cards.hello()
#       :world

#   """
#   def hello do
#     :world
#   end
# end
