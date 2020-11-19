require_relative 'card'

class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def add_card(card)
    raise 'Нельзя добавить четвёртую карту' if full?

    @cards << card
  end

  def remove_all_cards
    @cards = []
  end

  def points
    points = @cards.map(&:points).sum
    points += 10 if @cards.collect(&:rank).include?(Card::RANKS.last) && points + 10 <= 21
    points
  end

  def full?
    @cards.length == 3
  end
end
