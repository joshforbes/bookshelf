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

    it 'is not valid with a published_year that does not have a length of 4' do
      @book.published_year = 12345
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

  describe '#add_tag' do
    let(:book) { create(:book) }

    it 'adds an tag to the book' do
      book.add_tag('New Tag')

      expect(book.tags.count).to eq(1)
      expect(book.tags.first.name).to eq('New Tag')
    end

    it 'can add a second tag' do
      book.add_tag('Test Tag')
      book.add_tag('Another Tag')

      expect(book.tags.count).to eq(2)
      expect(book.tags.second.name).to eq('Another Tag')
    end

    it 'adds an tag to the book that already exists but does not create a new tag record' do
      tag = create(:tag)
      book.add_tag(tag.name)

      expect(book.tags.first.name).to eq(tag.name)
      expect(Tags::Tag.count).to eq(1)
    end

    it 'can not add the same tag to the book twice' do
      book.add_tag('New Tag')
      book.add_tag('New Tag')

      expect(book.tags.count).to eq(1)
      expect(book.tags.first.name).to eq('New Tag')
      expect(Tags::Tag.count).to eq(1)
    end
  end

  describe '#remove_tag' do
    it 'removes the tag from the book' do
      @tag = create(:tag)
      @book = create(:book)
      @book.tags << @tag

      @book.remove_tag(@tag)

      expect(@book.tags.count).to eq(0)
    end

    it 'removes the tag from the book and deletes the tag if nothing else has that tag' do
      @tag = create(:tag)
      @book = create(:book)
      @book.tags << @tag

      @book.remove_tag(@tag)

      expect(@book.tags.count).to eq(0)
      expect(Tags::Tag.count).to eq(0)
    end

    it 'removes the tag from the book but does not delete the tag if another object uses that tag' do
      @tag = create(:tag)
      @book_one = create(:book)
      @book_one.tags << @tag
      @book_two = create(:book)
      @book_two.tags << @tag

      @book_one.remove_tag(@tag)

      expect(@book_one.tags.count).to eq(0)
      expect(@book_two.tags.count).to eq(1)
      expect(Tags::Tag.count).to eq(1)
    end
  end

  describe '#rentable?' do
    it 'is true if the book is not currently rented' do
      book = create(:book)

      rentable = book.rentable?

      expect(rentable).to be(true)
    end

    it 'is false if the book is currently rented' do
      book = create(:book)
      create(:rental, book: book)

      rentable = book.rentable?

      expect(rentable).to be(false)
    end
  end

  describe '#owned_by' do
    it 'sets the owner of the book' do
      user = create(:user)
      book = create(:book)

      book = book.owned_by(user)

      expect(book.owner_id).to eq(user.id)
    end

    it 'changes the owner of the book' do
      new_owner = create(:user)
      book = create(:book, :with_owner)

      book = book.owned_by(new_owner)

      expect(book.owner_id).to eq(new_owner.id)
    end
  end

  describe '#remove_owner' do
    it 'removes the owner of the book' do
      book = create(:book, :with_owner)

      book = book.remove_owner

      expect(book.owner_id).to be(nil)
    end

    it 'does nothing if the book is not owned' do
      book = create(:book)

      book = book.remove_owner

      expect(book.owner_id).to be(nil)
    end
  end
end
