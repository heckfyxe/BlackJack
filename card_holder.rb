require_relative 'card'

class CardHolder
  def shuffle_cards
    @cards = Card.all_combinations
    @cards.shuffle!
  end

  def pop
    @cards.pop
  end
end
