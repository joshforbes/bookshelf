require 'rails_helper'

RSpec.describe Tags::Tag, type: :model do
  describe '#valid?' do
    before(:each) do
      @tag = build(:tag)
    end

    it 'is valid with valid attributes' do
      expect(@tag).to be_valid
    end

    it 'is not valid without a name' do
      @tag.name = nil
      expect(@tag).not_to be_valid
    end

    it 'is not valid if name is not unique' do
      another_tag = create(:tag)
      @tag.name = another_tag.name
      expect(@tag).not_to be_valid
    end
  end
end
