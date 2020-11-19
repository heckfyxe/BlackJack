require_relative 'dealer'
require_relative 'game'

class TextInterface
  def initialize(game)
    @game = game
  end

  def launch_game
    loop do
      show_players_status
      until @game.players_hands_full?
        command = user_command
        puts('Нельзя довавить карту!') if command == 2 && !@game.add_card(@game.user)
        break if command == 3

        @game.dealer_turn
      end
      @game.do_rates
      winner = @game.winner
      winner&.add_money
      show_winner(winner)
      perform_user_play_again
    end
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

  def show_winner(winner)
    puts winner.nil? ? 'Ничья' : "#{winner.name} выиграл!"
    show_players_status(hide_dealer_status: false)
  end

  def show_players_status(hide_dealer_status: true)
    @game.players.each do |player|
      need_hide = player.is_a?(Dealer) && hide_dealer_status
      cards = need_hide ? @game.player_cards_as_hidden(player) : @game.player_cards(player)
      puts "#{player.name}: #{cards}"
      puts "#{player.name}: #{player.money} долларов"
      puts "#{player.name}: #{player.points} points" unless need_hide
    end
  end

  def perform_user_play_again
    want_user_play_again? ? @game.prepare_for_new_game : exit
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
end

print 'Как тебя зовут? '
name = gets.chomp
game = Game.new(name)
interface = TextInterface.new(game)
interface.launch_game
