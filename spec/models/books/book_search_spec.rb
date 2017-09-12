require 'rails_helper'

RSpec.describe Books::BookSearch, search: true do
  it 'searches' do
    create(:book, title: 'Apple')
    reindex_search(Books::BookSearch)
    pp Books::BookSearch.search('Apple')
    expect(Books::BookSearch.search('Apple').map(&:title)).to eq(['Apple'])
  end
end