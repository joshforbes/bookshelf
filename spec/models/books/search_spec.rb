require 'rails_helper'

RSpec.describe Books::Search, search: true do
  describe 'searching' do
    it 'searches books by title' do
      book = create(:book, title: 'Head First Design Patterns')
      create(:book, title: 'Domain Driven Design')
      SearchHelpers.reindex_search(Books::Search)

      results = Books::Search.search('design patterns')

      expect(results.map(&:title)).to eq([book.title])
    end

    it 'searches books by description' do
      book = create(:book, description: 'A book about computers')
      create(:book, description: 'A book about money')
      SearchHelpers.reindex_search(Books::Search)

      results = Books::Search.search('computers')

      expect(results.map(&:title)).to eq([book.title])
    end

    it 'searches books by author' do
      book = create(:book).add_author('Eric Evans')
      create(:book).add_author('Dave Thomas')
      SearchHelpers.reindex_search(Books::Search)

      results = Books::Search.search('evans')

      expect(results.map(&:title)).to eq([book.title])
    end

    it 'searches books by tag' do
      book = create(:book).add_tag('Ruby')
      create(:book).add_tag('PHP')
      SearchHelpers.reindex_search(Books::Search)

      results = Books::Search.search('ruby')

      expect(results.map(&:title)).to eq([book.title])
    end
  end

  describe 'filtering' do
    it 'filters by tag' do
      book = create(:book, title: 'Head First Design Patterns').add_tag('Ruby')
      create(:book, title: 'Domain Driven Design').add_tag('PHP')
      SearchHelpers.reindex_search(Books::Search)

      results = Books::Search.search(where: { tags: ['Ruby'] })

      expect(results.map(&:title)).to eq([book.title])
    end

    it 'filters by author' do
      book = create(:book).add_author('Eric Evans')
      create(:book).add_author('Dave Thomas')
      SearchHelpers.reindex_search(Books::Search)

      results = Books::Search.search(where: { authors: ['Eric Evans'] })

      expect(results.map(&:title)).to eq([book.title])
    end
  end

end