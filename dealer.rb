require_relative 'player'

class Dealer < Player
  def initialize(card_holder)
    super('Дилер', card_holder)
  end

  def show_points; end

  def show_cards
    print "#{@name}: "
    @cards.length.times { print '** ' }
    puts
  end
end
