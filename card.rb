class Card
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
