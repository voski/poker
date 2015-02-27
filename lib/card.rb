class Card
  attr_reader :symbol, :suit

  POKER_VALUE = {
    :deuce => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 11,
    :queen => 12,
    :king  => 13,
    :ace => 14
  }

  SUIT_STRINGS = {
    :clubs    => "♣",
    :diamonds => "♦",
    :hearts   => "♥",
    :spades   => "♠"
  }

  SYMBOL_STRINGS = {
    :deuce => "2",
    :three => "3",
    :four  => "4",
    :five  => "5",
    :six   => "6",
    :seven => "7",
    :eight => "8",
    :nine  => "9",
    :ten   => "10",
    :jack  => "J",
    :queen => "Q",
    :king  => "K",
    :ace   => "A"
  }

  def initialize(symbol, suit)
    raise 'Invalid symbol' unless SYMBOL_STRINGS.keys.include?(symbol)
    @symbol = symbol
    raise 'Invalid suit' unless SUIT_STRINGS.keys.include?(suit)
    @suit = suit
  end

  def poker_value
    POKER_VALUE[symbol]
  end

  def self.suits
    SUIT_STRINGS.keys
  end

  def self.symbols
    SYMBOL_STRINGS.keys
  end

  def to_s
    SYMBOL_STRINGS[symbol] + SUIT_STRINGS[suit]
  end
end
