require_relative 'deck.rb'

class Hand
  attr_accessor :cards
  attr_reader :counts_syms, :counts_suits

  def self.from_deck(deck)
    Hand.new(deck.take(5))
  end

  def initialize(cards)
    raise "Not enough cards" unless cards.size == 5
    @cards = cards
    @counts_syms, @counts_suits = digest
  end

  def pair?
    pairs.length == 1 && trips.length == 0
  end

  def two_pair?
    pairs.length == 2
  end

  def pairs
    pairs = []
    @counts_syms.each do |key, val|
      pairs << key if val == 2
    end

    pairs
  end

  def trips?
    trips.length == 1 && pairs.length == 0
  end

  def trips
    trips = []
    @counts_syms.each do |key, val|
      trips << key if val == 3
    end

    trips
  end

  def quads?
    quads.any?
  end

  def quads
    quads = []
    @counts_syms.each do |key, val|
      quads << key if val == 4
    end

    quads
  end

  def full_house?
    pairs.length == 1 && trips.length == 1
  end

  def flush?
    flush.any?
  end

  def flush
    flushes = []
    @counts_suits.each do |key, val|
      flushes << key if val == 5
    end

    flushes
  end

  def straight?
    poker_values = []
    @cards.each do |card|
      poker_values << card.poker_value
    end
    poker_values.sort!
    first = poker_values[0]
    pot_straight = (first..(first + 4)).to_a

    poker_values == pot_straight
  end

  def straight_flush?
    straight? && flush?
  end

  def digest
    symbols = Hash.new { |h,k| h[k] = 0 }
    suits = Hash.new { |h,k| h[k] = 0 }

    cards.each do |card|
      symbols[card.symbol] += 1
      suits[card.suit] += 1
    end

    [symbols , suits]
  end


end
