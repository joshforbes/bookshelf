require 'rails_helper'

RSpec.describe Books::Book, type: :model do
  describe '#valid?' do
    before(:each) do
      @book = build(:book)
    end

    it 'is valid with valid attributes' do
      expect(@book).to be_valid
    end

    it 'is not valid without a isbn' do
      @book.isbn = nil
      expect(@book).not_to be_valid
    end

    it 'is not valid without a title' do
      @book.title = nil
      expect(@book).not_to be_valid
    end

    it 'is not valid without a description' do
      @book.title = nil
      expect(@book).not_to be_valid
    end
  end

  describe '#add_author' do
    let(:book) { create(:book) }

    it 'adds an author to the book' do
      book.add_author('Test Author')

      expect(book.authors.count).to eq(1)
      expect(book.authors.first.name).to eq('Test Author')
    end

    it 'can add a second author' do
      book.add_author('Test Author')
      book.add_author('Another Author')

      expect(book.authors.count).to eq(2)
      expect(book.authors.second.name).to eq('Another Author')
    end

    it 'adds an author to the book that already exists but does not create a new author record' do
      author = create(:author)
      book.add_author(author.name)

      expect(book.authors.first.name).to eq(author.name)
      expect(Authors::Author.count).to eq(1)
    end
  end
end
