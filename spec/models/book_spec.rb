RSpec.describe Book, type: :model do
  it { is_expected.to belong_to(:owner) }
  it { is_expected.to belong_to(:borrower) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:author) }

  let(:owner)            { create(:user) }
  let(:borrower)         { create(:user) }
  let(:someone)          { create(:user) }
  let(:owned_book)       { create(:book, owner: owner) }
  let(:lent_book)        { create(:book, owner: owner, borrower: borrower) }
  subject(:book)         { owned_book }

  describe '#lend' do
    it 'lends the book to someone' do
      expect { book.lend(borrower) }
        .to change { book.reload.borrower }
        .from(nil)
        .to(borrower)
      expect(book).to be_lent
    end

    it 'does not lend the book to the owner' do
      expect { book.lend(owner) }.not_to change { book.reload.borrower }
      expect(book).not_to be_lent
    end

    context 'lent book' do
      subject(:book) { lent_book }

      it 'does not lend the book' do
        expect { book.lend(someone) }.not_to change { book.reload.borrower }
        expect(book).to be_lent
      end
    end
  end

  describe '#return' do
    before(:each) { book.lend(borrower) }

    it "returns the book to it's owner" do
      expect { book.return }
        .to change { book.reload.borrower }
        .from(borrower)
        .to(nil)
      expect(book).not_to be_lent
    end
  end
end
