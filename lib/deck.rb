require_relative 'card.rb'

class Deck
  attr_accessor :cards

  def initialize(shuffle = false)
    @cards = []
    Card.symbols.each do |symbol|
      Card.suits.each do |suit|
      @cards << Card.new(symbol, suit)
      end
    end
    shuffle! if shuffle
  end

  def take(n)
    pulled = []
    n.times do
      pulled << self.cards.pop
    end
    pulled
  end

  def return(new_cards)
    raise "Too many cards" if new_cards.count + cards.count > 52

    new_cards.each do |card|
      @cards.unshift(card)
    end
  end

  def shuffle!
    @cards.shuffle!
  end

end
