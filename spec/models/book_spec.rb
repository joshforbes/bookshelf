require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'Validation' do
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
end
