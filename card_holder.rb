require_relative 'card'

class CardHolder
  RANKS = Array.new(13) { |i| i + 2 <= 10 ? (i + 2).to_s : %w[В Д К T][i - 10] }
  SUITS = %w[♦ ♣ ♥ ♠].freeze

  def initialize
    @cards = []
    shuffle_cards
  end

  def shuffle_cards
    RANKS.each do |rank|
      SUITS.each { |suit| @cards << Card.new(rank, suit) }
    end
    @cards.shuffle!
  end

  def pop
    @cards.pop
  end
end
