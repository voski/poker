require 'rspec'
require 'deck'

RSpec.describe Deck do
  let(:fresh_deck) {Deck.new}
  describe '#initialize' do
    it 'Holds 52 cards' do
      expect(fresh_deck.cards.count).to eq(52)
    end
  end

  describe '#take(n)' do
    let!(:first) { fresh_deck.cards[-1] }
    let!(:second) { fresh_deck.cards[-2] }
    it 'Takes n cards from top' do

      expect(fresh_deck.take(2)).to eq([first, second])
    end
  end

  describe '#return(new_cards)' do
    let!(:first) { fresh_deck.cards[-1] }
    context 'Deck cant have more than 52 cards' do
      it 'Raises an error when card count excceds 52' do
        expect{ fresh_deck.return(first) }.to raise_error
      end
    end

    context 'Adds new cards to bottom of deck' do
      let!(:card1) { fresh_deck.cards.pop }
      let!(:card2) { fresh_deck.cards.pop }
      it 'Places cards at bottom of deck' do
        new_cards = [card1, card2]
        fresh_deck.return(new_cards)
        expect(fresh_deck.cards[0..1]).to eq(new_cards.reverse)
      end
    end
  end

  describe '#shuffle' do
    it 'Shuffles deck' do
      expect(fresh_deck.shuffle!).to_not eq(fresh_deck)
    end
  end
end 
