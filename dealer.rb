class Dealer < Player

  def initialize(card_holder)
    super('Дилер', card_holder)
  end

  def show_cards
    print "#{@name}: "
    @cards.length.times { print '** ' }
  end
end