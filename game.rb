require_relative 'card_holder'
require_relative 'dealer'
require_relative 'player'

class Game
  attr_reader :players, :user

  def initialize(username)
    @card_holder = CardHolder.new
    @dealer = Dealer.new
    @user = Player.new(username)
    @players = [@user, @dealer]

    prepare_for_new_game
  end

  def do_rates
    @players.each(&:do_rate)
  end

  def players_hands_full?
    @players.all?(&:hand_full?)
  end

  def add_card(user)
    user.add_card(pop_card)
    true
  rescue RuntimeError
    false
  end

  def pop_card
    @card_holder.pop
  end

  def dealer_turn
    @dealer.add_card(pop_card) if !@dealer.hand_full? && @dealer.points < 17
  end

  def player_cards(player)
    player.cards.map(&:name).join(' ')
  end

  def player_cards_as_hidden(player)
    cards_length = player.cards.length
    Array.new(cards_length) { '**' }.join(' ')
  end

  def prepare_for_new_game
    @card_holder.shuffle_cards
    @players.each do |player|
      cards = Array.new(2) { @card_holder.pop }
      player.prepare_for_new_game(cards)
    end
  end

  def winner
    points = @players.collect { |player| player.points <= 21 ? (player.points - 21).abs : 1000 }
    min_point, max_point = points.minmax
    return nil if min_point == max_point

    winner_index = points.index(min_point)
    @players[winner_index]
  end
end
