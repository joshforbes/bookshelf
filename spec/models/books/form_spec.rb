require 'rails_helper'

RSpec.describe Books::CreateForm do
  describe '#valid?' do
    before(:each) do
      @params = { isbn: '123456789', title: 'Test', description: 'Test description', authors: ['Test Author'] }
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

    it 'is not valid without authors' do
      @params['authors'] = nil
      form = Books::CreateForm.new(@params)

      expect(form).not_to be_valid
    end
  end

  describe '#save' do
    let(:params) { { isbn: '123456789', title: 'Test', description: 'Test description', authors: ['Test Author'] } }

    it 'persists a new book' do
      form = Books::CreateForm.new(params)

      book = form.save

      expect(book.isbn).to eq('123456789')
      expect(book.persisted?).to be(true)
    end

    it 'adds an author to the book' do
      form = Books::CreateForm.new(params)

      book = form.save

      expect(book.authors.count).to eq(1)
      expect(book.authors.first.name).to eq('Test Author')
      expect(book.authors.first.persisted?).to be(true)
    end
  end
end
