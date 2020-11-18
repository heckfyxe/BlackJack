require_relative 'rules'

class Player
  attr_reader :name, :cards, :money

  def initialize(name, card_holder)
    @name = name
    @card_holder = card_holder
    prepare_for_new_game
    @money = Rules::BANK
  end

  def show_cards
    print "#{@name}: "
    puts @cards.map(&:name).join(' ')
  end

  def show_money
    puts "#{name}: #{money} долларов"
  end

  def prepare_for_new_game
    @cards = Array.new(2) { @card_holder.pop }
  end

  def show_points
    puts "#{name}: #{points} points"
  end

  def points
    points = @cards.map(&:points).sum
    points += 10 if @cards.include?('Т') && points + 10 <= 21
    points
  end

  def add_card
    raise 'Нельзя добавить четвёртую карту' if @cards.length == 3

    @cards << @card_holder.pop
  end

  def do_rate
    @money -= Rules::RATE
  end

  def add_money
    @money += Rules::RATE * 2
  end
end
