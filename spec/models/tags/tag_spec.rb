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

  describe '#cleanup' do
    it 'deletes the tag if it is not being used' do
      @tag = create(:tag)

      @tag.cleanup

      expect(Tags::Tag.count).to eq(0)
    end

    it 'does not delete the tag if it is being used' do
      @tag = create(:tag)
      @book = create(:book)
      @book.tags << @tag

      @tag.cleanup

      expect(Tags::Tag.count).to eq(1)
    end
  end
end
