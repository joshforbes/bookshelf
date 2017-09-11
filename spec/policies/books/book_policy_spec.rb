require 'rails_helper'

RSpec.describe Books::BookPolicy do
  subject { Books::BookPolicy.new(user, book) }
  let(:book) { create(:book) }

  context 'for a user' do
    let(:user) { create(:user) }

    it { expect(subject.create?).to be(false) }
    it { expect(subject.destroy?).to be(false) }
  end

  context 'for a admin' do
    let(:user) { create(:user, :admin) }

    it { expect(subject.create?).to be(true) }
    it { expect(subject.destroy?).to be(true) }
  end

end