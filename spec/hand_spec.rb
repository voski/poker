require 'rspec'
require 'hand'

RSpec.describe Hand do
  describe '#initialize' do
    let(:test_cards_ok) { Deck.new(true).take(5) }
    let(:test_card_bad) { Deck.new(true).take(3) }
    it "Should take an array of cards" do
      expect(Hand.new(test_cards_ok).cards).to eq(test_cards_ok)
    end

    it 'Raises error if initialized with less than 5 cards' do
      expect { Hand.new(test_cards_bad).cards }.to raise_error
    end
  end

  describe '#digest' do
    let(:digest_hand) { [
      Card.new(:queen, :spades),
      Card.new(:five,  :hearts),
      Card.new(:deuce, :spades),
      Card.new(:three, :spades),
      Card.new(:three,  :clubs)
    ] }
    let(:test_hand) { Hand.new(digest_hand) }

    it 'produces the right symbols hash' do
      expect(test_hand.counts_syms).to eq({
                                    :queen => 1,
                                    :five  => 1,
                                    :deuce => 1,
                                    :three => 2,
                                  })
    end

    it 'produces the right suits hash' do
      expect(test_hand.counts_suits).to eq({
                                    :spades => 3,
                                    :hearts => 1,
                                    :clubs => 1,
                                  })
    end



  end

  describe '#check_hands' do
    let(:high_card_hand) { [
      Card.new(:queen, :spades),
      Card.new(:five,  :hearts),
      Card.new(:deuce, :spades),
      Card.new(:three, :spades),
      Card.new(:four,  :spades)
    ] }

    let(:pair_hand) { [
      Card.new(:queen, :spades),
      Card.new(:queen, :hearts),
      Card.new(:deuce, :spades),
      Card.new(:three, :spades),
      Card.new(:four,  :spades)
    ] }

    let(:two_pair_hand) { [
      Card.new(:queen, :spades),
      Card.new(:queen, :hearts),
      Card.new(:deuce, :spades),
      Card.new(:deuce, :hearts),
      Card.new(:four,  :spades)
    ] }

    let(:trips_hand) { [
      Card.new(:queen, :spades),
      Card.new(:queen, :hearts),
      Card.new(:queen, :clubs),
      Card.new(:three, :spades),
      Card.new(:four,  :spades)
    ] }

    let(:quads_hand) { [
      Card.new(:queen, :spades),
      Card.new(:queen, :hearts),
      Card.new(:queen, :clubs),
      Card.new(:queen, :diamonds),
      Card.new(:four,  :spades)
    ] }

    let(:full_house_hand) { [
      Card.new(:queen, :spades),
      Card.new(:queen, :hearts),
      Card.new(:queen, :clubs),
      Card.new(:three, :spades),
      Card.new(:three, :hearts)
    ] }

    let(:flush_hand) { [
      Card.new(:queen, :spades),
      Card.new(:king,  :spades),
      Card.new(:deuce, :spades),
      Card.new(:three, :spades),
      Card.new(:four,  :spades)
    ] }

    let(:straight_hand) { [
      Card.new(:ace,   :spades),
      Card.new(:king,  :hearts),
      Card.new(:jack, :spades),
      Card.new(:queen, :spades),
      Card.new(:ten,  :spades)
    ] }

    let(:straight_flush_hand) { [
      Card.new(:six,   :spades),
      Card.new(:five,  :spades),
      Card.new(:deuce, :spades),
      Card.new(:three, :spades),
      Card.new(:four,  :spades)
    ] }

    context 'Recognizes a pair' do
      it "Recognizes a pair" do
        expect(Hand.new(pair_hand).pair?).to eq(true)
      end

      it 'Does not return false positive' do
        expect(Hand.new(high_card_hand).pair?).to_not eq(true)
      end
    end

    context 'Recognizes a 3 of a kind' do
      it 'recognizes trips'  do
        expect(Hand.new(trips_hand).trips?).to eq(true)
      end

      it 'Does not return false positive' do
        expect(Hand.new(high_card_hand).trips?).to_not eq(true)
      end
    end

    context 'Recognizes a two pair' do
      it 'recognizes two pair'  do
        expect(Hand.new(two_pair_hand).two_pair?).to eq(true)
      end

      it 'Does not return false positive' do
        expect(Hand.new(high_card_hand).two_pair?).to_not eq(true)
      end
    end

    context 'Recognizes a flush' do
      it 'recognizes flush'  do
        expect(Hand.new(flush_hand).flush?).to eq(true)
      end

      it 'Does not return false positive' do
        expect(Hand.new(high_card_hand).flush?).to_not eq(true)
      end
    end

    context 'Recognizes a straight' do
      it 'recognizes straight ace high'  do
        expect(Hand.new(straight_hand).straight?).to eq(true)
      end

      it 'recognizes straight ace low' do
      end

      it 'Does not return false positive' do
        expect(Hand.new(high_card_hand).straight?).to_not eq(true)
      end
    end

    context 'Recognizes a straight flush' do
      it 'recognizes straight flush'  do
        expect(Hand.new(straight_flush_hand).straight_flush?).to eq(true)
      end

      it 'Does not return false positive' do
        expect(Hand.new(high_card_hand).straight_flush?).to_not eq(true)
      end
    end

    context 'Recognizes a four of a kind' do
      it 'recognizes quads'  do
        expect(Hand.new(quads_hand).quads?).to eq(true)
      end

      it 'Does not return false positive' do
        expect(Hand.new(high_card_hand).quads?).to_not eq(true)
      end
    end

    context 'Recognizes a full house' do
      it 'recognize full house'  do
        expect(Hand.new(full_house_hand).full_house?).to eq(true)
      end

      it 'Does not return false positive' do
        expect(Hand.new(high_card_hand).full_house?).to_not eq(true)
      end
    end
  end



end
