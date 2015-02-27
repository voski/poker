require 'rspec'
require 'card'

RSpec.describe Card do
  let(:card) {Card.new(:queen, :spades)}

  describe '#initialize' do
    context 'Assign valid symbol/suit' do
      it 'assigns suit' do
        expect(card.suit).to eq(:spades)
      end
      it 'assigns symbol' do
        expect(card.symbol).to eq(:queen)
      end
    end

    context 'Assign invalid symbol' do
      it 'raises an error' do
        expect { Card.new(:one, :spades) }.to raise_error(RuntimeError, 'Invalid symbol')
      end
    end

    context 'Assign invalid suit' do
      it 'raises an error' do
        expect { Card.new(:deuce, :spade) }.to raise_error
      end
    end
  end

  describe '#poker_value' do
    it 'returns value of card' do
      expect(card.poker_value).to eq(12)
    end
  end

  describe '#to_s' do
    it 'returns a string with symbol and suit' do
      expect(card.to_s).to eq('Q♠')
    end
  end

end
