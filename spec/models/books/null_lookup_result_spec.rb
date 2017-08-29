require 'rails_helper'

RSpec.describe Books::NullLookupResult do
  describe '#exists?' do
    it 'does not exist' do
      null_result = Books::NullLookupResult.new

      expect(null_result.exists?).to be(false)
    end
  end

  describe '#to_book' do
    it 'returns an book hash with all nil values' do
      null_result = Books::NullLookupResult.new

      nil_book = null_result.to_book

      expect(nil_book).to eq({ isbn: nil, title: nil, description: nil, pages: nil, published_date: nil })
    end
  end
end
