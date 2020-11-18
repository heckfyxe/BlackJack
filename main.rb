require_relative 'card_holder'
require_relative 'user'
require_relative 'dealer'

class Main
  def initialize(username)
    @card_holder = CardHolder.new
    @dealer = Dealer.new(@card_holder)
    @user = User.new(username, @card_holder)
    @players = [@user, @dealer]
  end

  def launch_game
    loop do
      show_players_status
      until game_end?
        command = user_command
        next if command == 2 && !add_card(@user)
        break if command == 3

        dealer_turn
      end
      do_rates
      winner&.add_money
      show_winner(winner)
      perform_user_play_again
    end
  end

  def do_rates
    @players.each(&:do_rate)
  end

  def game_end?
    @user.cards.length == 3 && @dealer.cards.length == 3
  end

  def add_card(user)
    user.add_card
    true
  rescue RuntimeError => e
    puts e.message
    false
  end

  def user_command
    puts '1. Пропустить'
    puts '2. Добавить карту'
    puts '3. Открыть карты'
    command = gets.chomp.to_i
    raise 'Unknown command' unless (1..3).include?(command)

    command
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def dealer_turn
    @dealer.add_card if @dealer.cards.length < 3 && @dealer.points < 17
  end

  def show_players_status
    @players.each do |player|
      player.show_cards
      player.show_money
      player.show_points
    end
  end

  def prepare_for_new_game
    @card_holder.shuffle_cards
    @players.each(&:prepare_for_new_game)
  end

  def want_user_play_again?
    print 'Хочешь поиграть снова?(Да/Нет) '
    answer = gets.chomp
    case answer
    when 'Да'
      true
    when 'Нет'
      false
    else
      raise 'Неизвестная команда'
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def perform_user_play_again
    want_user_play_again? ? prepare_for_new_game : exit
  end

  def winner
    points = @players.collect { |player| player.points <= 21 ? (player.points - 21).abs : 1000 }
    min_point, max_point = points.minmax
    return nil if min_point == max_point

    winner_index = points.index(min_point)
    @players[winner_index]
  end

  def show_winner(winner)
    puts winner.nil? ? 'Ничья' : "#{winner.name} выиграл!"
    @players.each do |player|
      print "#{player.name}: "
      player.cards.each { |card| print "#{card.name} " }
      puts "#{player.points} баллов"
      player.show_money
    end
  end
end

print 'Как тебя зовут? '
name = gets.chomp
Main.new(name).launch_game
