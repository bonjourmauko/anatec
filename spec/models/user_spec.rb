RSpec.describe User, type: :model do
  it { is_expected.to have_many(:owned_books).dependent(:destroy) }
  it { is_expected.to have_many(:borrowed_books).dependent(:nullify) }
end
