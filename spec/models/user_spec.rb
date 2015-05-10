RSpec.describe User, type: :model do
  it { is_expected.to have_many(:owned_books).dependent(:destroy) }
  it { is_expected.to have_many(:borrowed_books).dependent(:nullify) }

  it { is_expected.to delegate_method(:lent_books).to(:owned_books) }

  describe '.without' do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }
    subject { described_class }

    it { expect(subject.without(user1)).not_to include(user1) }
    it { expect(subject.without(user1)).to include(user2) }
  end
end
