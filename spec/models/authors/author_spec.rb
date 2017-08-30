require 'rails_helper'

RSpec.describe Authors::Author, type: :model do
  describe '#valid?' do
    before(:each) do
      @author = build(:author)
    end

    it 'is valid with valid attributes' do
      expect(@author).to be_valid
    end

    it 'is not valid without a name' do
      @author.name = nil
      expect(@author).not_to be_valid
    end
  end
end
