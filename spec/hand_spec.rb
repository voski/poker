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
    let(:high_card_hand_lose) { Hand.new([
      Card.new(:queen, :spades),
      Card.new(:five,  :hearts),
      Card.new(:deuce, :spades),
      Card.new(:three, :spades),
      Card.new(:four,  :spades)
    ]) }

    let(:high_card_hand) { Hand.new([
      Card.new(:queen, :spades),
      Card.new(:seven,  :hearts),
      Card.new(:deuce, :spades),
      Card.new(:three, :spades),
      Card.new(:four,  :spades)
    ]) }

    let(:high_card_hand_lose) { Hand.new([
      Card.new(:jack, :spades),
      Card.new(:five,  :hearts),
      Card.new(:deuce, :spades),
      Card.new(:three, :spades),
      Card.new(:four,  :spades)
    ]) }

    let(:pair_hand) { Hand.new([
      Card.new(:queen, :spades),
      Card.new(:queen, :hearts),
      Card.new(:deuce, :spades),
      Card.new(:three, :spades),
      Card.new(:four,  :spades)
    ]) }

    let(:pair_hand_lose) { Hand.new([
      Card.new(:jack, :spades),
      Card.new(:jack, :hearts),
      Card.new(:deuce, :spades),
      Card.new(:three, :spades),
      Card.new(:four,  :spades)
    ]) }

    let(:two_pair_hand) { Hand.new([
      Card.new(:queen, :spades),
      Card.new(:queen, :hearts),
      Card.new(:deuce, :spades),
      Card.new(:deuce, :hearts),
      Card.new(:four,  :spades)
    ]) }

    let(:two_pair_hand_lose) { Hand.new([
      Card.new(:jack, :spades),
      Card.new(:jack, :hearts),
      Card.new(:deuce, :spades),
      Card.new(:deuce, :hearts),
      Card.new(:four,  :spades)
    ]) }

    let(:trips_hand) { Hand.new([
      Card.new(:queen, :spades),
      Card.new(:queen, :hearts),
      Card.new(:queen, :clubs),
      Card.new(:three, :spades),
      Card.new(:four,  :spades)
    ]) }

    let(:trips_hand_lose) { Hand.new([
      Card.new(:jack, :spades),
      Card.new(:jack, :hearts),
      Card.new(:jack, :clubs),
      Card.new(:three, :spades),
      Card.new(:four,  :spades)
    ]) }

    let(:quads_hand) { Hand.new([
      Card.new(:queen, :spades),
      Card.new(:queen, :hearts),
      Card.new(:queen, :clubs),
      Card.new(:queen, :diamonds),
      Card.new(:four,  :spades)
    ]) }

    let(:quads_hand_lose) { Hand.new([
      Card.new(:nine, :spades),
      Card.new(:nine, :hearts),
      Card.new(:nine, :clubs),
      Card.new(:nine, :diamonds),
      Card.new(:four,  :spades)
    ]) }

    let(:full_house_hand) { Hand.new([
      Card.new(:queen, :spades),
      Card.new(:queen, :hearts),
      Card.new(:queen, :clubs),
      Card.new(:three, :spades),
      Card.new(:three, :hearts)
    ]) }

    let(:full_house_hand_lose) { Hand.new([
      Card.new(:deuce, :spades),
      Card.new(:deuce, :hearts),
      Card.new(:deuce, :clubs),
      Card.new(:three, :spades),
      Card.new(:three, :hearts)
    ]) }

    let(:flush_hand) { Hand.new([
      Card.new(:queen, :spades),
      Card.new(:king,  :spades),
      Card.new(:deuce, :spades),
      Card.new(:three, :spades),
      Card.new(:five,  :spades)
    ]) }

    let(:flush_hand_lose) { Hand.new([
      Card.new(:queen, :hearts),
      Card.new(:king,  :hearts),
      Card.new(:deuce, :hearts),
      Card.new(:three, :hearts),
      Card.new(:four,  :hearts)
    ]) }

    let(:straight_hand) { Hand.new([
      Card.new(:ace,   :spades),
      Card.new(:king,  :hearts),
      Card.new(:jack, :spades),
      Card.new(:queen, :spades),
      Card.new(:ten,  :spades)
    ]) }

    let(:straight_hand_ace_low) { Hand.new([
      Card.new(:ace,   :spades),
      Card.new(:deuce,  :hearts),
      Card.new(:three, :spades),
      Card.new(:four, :spades),
      Card.new(:five,  :spades)
    ]) }

    let(:straight_flush_hand) { Hand.new([
      Card.new(:six,   :spades),
      Card.new(:five,  :spades),
      Card.new(:deuce, :spades),
      Card.new(:three, :spades),
      Card.new(:four,  :spades)
    ]) }

    context 'Creates a sorted array of the poker values of the cards' do
      it "Does it on a flush" do
        expect(flush_hand.ordered_card_values).to eq([2, 3, 5, 12, 13])
      end
    end

    context 'Determines hand type' do
      it 'Finds a flush' do
        expect(flush_hand.hand_type).to eq(:flush)
      end

      it 'Finds a Straight flush' do
        expect(straight_flush_hand.hand_type).to eq(:straight_flush)
      end

      it 'Finds a high card hand' do
        expect(high_card_hand.hand_type).to eq(:high_card)
      end
    end

    context 'It compares two hands' do

      it 'Knows which pair wins' do
          expect(pair_hand<=>pair_hand_lose).to eq(1)
      end

      it 'Knows a pair beats a high card' do
        expect(high_card_hand<=>two_pair_hand).to eq(-1)
      end

      it 'Knows if two hand types are equal' do
        expect(flush_hand <=> flush_hand).to eq(0)
      end

      it 'Knows a straight flush beats a flush' do
        expect(straight_flush_hand<=>flush_hand).to eq(1)
      end

      it 'Knows which trip wins' do
        expect(trips_hand_lose<=>trips_hand).to eq(-1)
      end

      it 'Knows which flush wins' do
        expect(flush_hand_lose<=>flush_hand).to eq(-1)
      end

      it 'Knows which straight wins' do
        expect(straight_hand_ace_low<=>straight_hand).to eq(-1)
      end

      it 'Knows which high card hand wins' do
        expect(high_card_hand_lose<=>high_card_hand).to eq(-1)
      end

      it 'Knows which quad wins' do
        expect(quads_hand_lose<=>quads_hand).to eq(-1)
      end

      it 'Knows which full house wins' do
        expect(full_house_hand<=>full_house_hand_lose).to eq(1)
      end
    end

    context 'Recognizes high card hand' do
      it 'Recognizes high card hand' do
        expect(high_card_hand.high_card?).to eq(true)
      end

      it 'Does not return false positive' do
        expect(straight_hand.high_card?).to_not eq(true)
      end
    end

    context 'Recognizes a pair' do
      it "Recognizes a pair" do
        expect(pair_hand.pair?).to eq(true)
      end

      it 'Does not return false positive' do
        expect(high_card_hand.pair?).to_not eq(true)
      end
    end

    context 'Recognizes a 3 of a kind' do
      it 'recognizes trips'  do
        expect(trips_hand.trips?).to eq(true)
      end

      it 'Does not return false positive' do
        expect(high_card_hand.trips?).to_not eq(true)
      end
    end

    context 'Recognizes a two pair' do
      it 'recognizes two pair'  do
        expect(two_pair_hand.two_pair?).to eq(true)
      end

      it 'Does not return false positive' do
        expect(high_card_hand.two_pair?).to_not eq(true)
      end
    end

    context 'Recognizes a flush' do
      it 'recognizes flush'  do
        expect(flush_hand.flush?).to eq(true)
      end

      it 'Does not return false positive' do
        expect(high_card_hand.flush?).to_not eq(true)
      end
    end

    context 'Recognizes a straight' do
      it 'recognizes straight ace high'  do
        expect(straight_hand.straight?).to eq(true)
      end

      it 'recognizes straight ace low' do
        expect(straight_hand_ace_low.straight?).to eq(true)
      end


      it 'Does not return false positive' do
        expect(high_card_hand.straight?).to_not eq(true)
      end
    end

    context 'Recognizes a straight flush' do
      it 'recognizes straight flush'  do
        expect(straight_flush_hand.straight_flush?).to eq(true)
      end

      it 'Does not return false positive' do
        expect(high_card_hand.straight_flush?).to_not eq(true)
      end
    end

    context 'Recognizes a four of a kind' do
      it 'recognizes quads'  do
        expect(quads_hand.quads?).to eq(true)
      end

      it 'Does not return false positive' do
        expect(high_card_hand.quads?).to_not eq(true)
      end
    end

    context 'Recognizes a full house' do
      it 'recognize full house'  do
        expect(full_house_hand.full_house?).to eq(true)
      end

      it 'Does not return false positive' do
        expect(high_card_hand.full_house?).to_not eq(true)
      end
    end
  end
end
