require 'rails_helper'

RSpec.describe Books::CreateForm do
  describe '#valid?' do
    before(:each) do
      @params = { isbn: '123456789', title: 'Test', description: 'Test description' }
    end

    it 'is valid with valid attributes' do
      form = Books::CreateForm.new(@params)

      expect(form).to be_valid
    end

    it 'is not valid without a isbn' do
      @params['isbn'] = nil
      form = Books::CreateForm.new(@params)

      expect(form).not_to be_valid
    end

    it 'is not valid without a title' do
      @params['title'] = nil
      form = Books::CreateForm.new(@params)

      expect(form).not_to be_valid
    end

    it 'is not valid without a description' do
      @params['description'] = nil
      form = Books::CreateForm.new(@params)

      expect(form).not_to be_valid
    end
  end

  describe '#save' do
    it 'persists a new book' do
      form = Books::CreateForm.new(isbn: '123456789', title: 'Test', description: 'Test description')

      book = form.save

      expect(book.isbn).to eq('123456789')
      expect(book.persisted?).to be(true)
    end
  end
end
