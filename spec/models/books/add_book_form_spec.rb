require 'rails_helper'

RSpec.describe Books::AddBookForm do
  describe '#valid?' do
    it 'is valid with valid attributes' do
      form = Books::AddBookForm.new(isbn: '123456789')
      form.instance_variable_set(:@result, isbn: '123456789')

      expect(form).to be_valid
    end

    it 'is not valid without a isbn' do
      form = Books::AddBookForm.new(isbn: nil)

      expect(form).not_to be_valid
    end
  end

  describe '#save' do
    let(:params) { { isbn: '123456789' } }

    it 'persists a new book' do
      form = Books::AddBookForm.new(params, FakeLookup.new)

      form.save

      book = form.book
      expect(book.isbn).to eq('123456789')
      expect(book.persisted?).to be(true)
    end

    it 'adds an author to the book' do
      form = Books::AddBookForm.new(params, FakeLookup.new)

      form.save

      book = form.book
      expect(book.authors.count).to eq(2)
      expect(book.authors.first.name).to eq('David Chelimsky')
      expect(book.authors.first.persisted?).to be(true)
    end
  end
end
