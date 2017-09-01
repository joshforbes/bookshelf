require 'rails_helper'

RSpec.describe Books::TagBookForm do
  describe '#valid?' do
    it 'is valid with valid attributes' do
      form = Books::TagBookForm.new({ book_id: 1, name: 'Computers' })

      expect(form).to be_valid
    end

    it 'is not valid without a book_id' do
      form = Books::TagBookForm.new({ book_id: nil, name: 'Computers' })

      expect(form).not_to be_valid
    end

    it 'is not valid without a name' do
      form = Books::TagBookForm.new({ book_id: 1, name: nil })

      expect(form).not_to be_valid
    end
  end

  describe '#save' do
    it 'adds a tag to a book' do
      book = create(:book)
      form = Books::TagBookForm.new({ book_id: book.id, name: 'Computers'})

      form.save

      book = form.book
      expect(book.tags.count).to eq(1)
      expect(book.tags.first.name).to eq('Computers')
    end
  end
end
