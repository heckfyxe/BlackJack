require_relative 'player'

class Dealer < Player
  def initialize(card_holder)
    super('Дилер', card_holder)
  end
end
