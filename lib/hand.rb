require_relative 'deck.rb'
require 'byebug'

class Hand
  HAND_VALUES = {
    :high_card       => 1,
    :pair            => 2,
    :two_pair        => 3,
    :trips           => 4,
    :straight        => 5,
    :flush           => 6,
    :full_house      => 7,
    :quads           => 8,
    :straight_flush  => 9,
  }

  attr_accessor :cards
  attr_reader :counts_syms, :counts_suits, :hand_type, :pair_breaker, :ordered_card_values,
  def self.from_deck(deck)
    Hand.new(deck.take(5))
  end

  def initialize(cards)
    raise "Not enough cards" unless cards.size == 5
    @cards = cards
    @counts_syms, @counts_suits = digest
    @hand_type = determine_value
    @ordered_card_values = ordered_card_values
  end

  def determine_value
    HAND_VALUES.keys.reverse.each do |poker_hand|
      if self.send("#{poker_hand}?")
        return poker_hand
      end
    end
  end

  def high_card?
    hands = [pair?, trips?, quads?, full_house?, straight?, flush?, two_pair?]
    hands.none?
  end

  def pair?
    pairs.length == 1 && trips.length == 0
  end

  def two_pair?
    pairs.length == 2
  end

  def pairs
    pairs = []
    @counts_syms.each do |key, val| #key is sybol for example deuce, or king0
      pairs << key if val == 2
    end
    @pair_breaker = pairs
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

    if first != 2
      pot_straight = (first..(first + 4)).to_a
    elsif poker_values[-1] == 14 #we have an ace
      poker_values[-1] = 1
      pot_straight = (1..5).to_a
    else
      pot_straight = (first..(first + 4)).to_a
    end

    poker_values.sort == pot_straight
  end

  def straight_flush?
    straight? && flush?
  end

  def ordered_card_values
    card_values = []
    cards.each do |card|
      card_values << card.poker_value
    end

    card_values.sort!
  end


  def <=>(other_hand)
    case HAND_VALUES[hand_type] <=> HAND_VALUES[other_hand.hand_type]
    when 0
      case hand_type
      when :trips
        Card.poker_value(self.trips[0]) <=> Card.poker_value(other_hand.trips[0])
      when :full_house
        Card.poker_value(self.trips[0]) <=> Card.poker_value(other_hand.trips[0])
      when :quads
        Card.poker_value(self.quads[0]) <=> Card.poker_value(other_hand.quads[0])
      when :pair
        our_value , their_value = Card.poker_value(self.pair_breaker[0]) , Card.poker_value(other_hand.pair_breaker[0])
        case  our_value <=> their_value
        when -1
          return -1
        when 1
          return 1
        when 0
          their_ordered_values = other_hand.ordered_values
          @ordered_card_values -= our_value
          their_ordered_values -= their_value
          @ordered_card_values <=> their_ordered_values
        end
      when :two_pair

      else
        ordered_card_values <=> other_hand.ordered_card_values
      end
    else
      HAND_VALUES[hand_type] <=> HAND_VALUES[other_hand.hand_type]
    end
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
