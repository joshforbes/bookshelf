require 'rails_helper'

RSpec.describe Books::CreateForm do
  describe '#valid?' do
    it 'is valid with valid attributes' do
      form = Books::CreateForm.new(isbn: '123456789')

      expect(form).to be_valid
    end

    it 'is not valid without a isbn' do
      form = Books::CreateForm.new(isbn: nil)

      expect(form).not_to be_valid
    end
  end

  describe '#save' do
    it 'persists a new book' do
      stub_const('Books::Lookup', FakeLookup)
      form = Books::CreateForm.new(isbn: '9781934356371')

      book = form.save

      expect(book.isbn).to eq('9781934356371')
      expect(book.persisted?).to be(true)
    end

    it 'returns false if the save fails' do

    end

  end
end
