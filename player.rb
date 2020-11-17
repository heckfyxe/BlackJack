class Player
  attr_reader :name, :cards

  def initialize(name, card_holder)
    @name = name
    @card_holder = card_holder
    @cards = Array.new(2) { card_holder.pop }
    @money = Rules::BANK
  end

  def show_cards
    print "#{@name}: "
    puts @cards.map { |card| card.name }.join(' ')
  end

  def points
    @cards.map { |card| card.points }.sum + 10 * @cards.count('Т')
  end

  def add_card
    raise 'Cannot add fourth card' if @cards.length == 3
    @cards << @card_holder.pop
  end

  def do_rate
    @money -= Rules::RATE
  end

  def add_money
    @money += Rules::RATE * 2
  end
end