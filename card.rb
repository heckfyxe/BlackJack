class Card
  RANKS = Array.new(13) { |i| i + 2 <= 10 ? (i + 2).to_s : %w[В Д К T][i - 10] }
  SUITS = %w[♦ ♣ ♥ ♠].freeze

  def self.all_combinations
    RANKS.collect_concat do |rank|
      SUITS.collect { |suit| Card.new(rank, suit) }
    end
  end

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def name
    rank + suit
  end

  # rubocop:disable Style/CaseLikeIf
  def points
    if ('2'..'10').include?(rank)
      rank.to_i
    elsif rank == 'T'
      1
    else
      10
    end
  end
  # rubocop:enable Style/CaseLikeIf
end
