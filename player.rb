require_relative 'rules'
require_relative 'hand'

class Player
  attr_reader :name, :money

  def initialize(name)
    @name = name
    @hand = Hand.new
    @money = Rules::BANK
  end

  def prepare_for_new_game(cards)
    raise 'Нужно две карты' if cards.length != 2

    @hand.remove_all_cards
    cards.each do |card|
      @hand.add_card(card)
    end
  end

  def cards
    @hand.cards
  end

  def points
    @hand.points
  end

  def hand_full?
    @hand.full?
  end

  def add_card(card)
    @hand.add_card(card)
  end

  def do_rate
    @money -= Rules::RATE
  end

  def add_money
    @money += Rules::RATE * 2
  end
end
