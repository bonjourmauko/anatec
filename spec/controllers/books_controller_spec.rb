RSpec.describe BooksController, type: :controller do
  let(:owner)   { create(:user) }
  let(:borrower) { create(:user) }

  # Authentication
  before(:each) { sign_in(owner) }

  describe 'GET #index' do
    let(:owned_book) { create(:book, owner: owner, borrower: nil) }
    let(:lent_book) { create(:book, owner: owner, borrower: borrower) }
    let(:borrowed_book) { create(:book, owner: borrower, borrower: owner) }

    it 'assign own books as @owned_books' do
      get :index
      expect(assigns(:owned_books)).to eq([owned_book])
    end

    it 'assign lent books as @lent_books' do
      get :index
      expect(assigns(:lent_books)).to eq([lent_book])
    end

    it 'assigns borrowed books as @borrowed_books' do
      get :index
      expect(assigns(:borrowed_books)).to eq([borrowed_book])
    end
  end

  describe 'GET #new' do
    it 'assigns a new book as @book' do
      get :new
      expect(assigns(:book)).to be_a_new(Book)
    end
  end

  describe 'POST #create' do
    let(:valid_params) { attributes_for(:book) }
    let(:invalid_params) { valid_params.merge!(title: nil) }

    context 'with valid params' do
      it 'creates a new Book' do
        expect {
          post :create, book: valid_params
        }.to change { owner.owned_books.count }.by(1)
      end

      it 'assigns a newly created book as @book' do
        post :create, book: valid_params
        expect(assigns(:book)).to be_a(Book)
        expect(assigns(:book)).to be_persisted
      end

      it 'redirects to #index' do
        post :create, book: valid_params
        expect(response).to redirect_to(books_path)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved book as @book' do
        post :create, book: invalid_params
        expect(assigns(:book)).to be_a_new(Book)
      end

      it "re-renders the 'new' template" do
        post :create, book: invalid_params
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PATCH #lend' do
    let!(:book) { create(:book, owner: owner) }
    let(:params) { { borrower_id: borrower.id } }

    it 'lends a book' do
      expect {
        patch :lend, id: book.to_param, book: params
      }.to change { owner.lent_books.count }.by(1)
    end

    it 'assigns to-be-lent book as @book' do
      patch :lend, id: book.to_param, book: params
      expect(assigns(:book)).to eq(book)
    end

    it 'assigns to-be-borrower user as @borrower' do
      patch :lend, id: book.to_param, book: params
      expect(assigns(:borrower)).to eq(borrower)
    end

    it 'redirects to #index' do
      patch :lend, id: book.to_param, book: params
      expect(response).to redirect_to(books_path)
    end
  end

  describe 'PATCH #return' do
    let!(:book) { create(:book, owner: borrower, borrower: owner) }

    it 'returns a book' do
      expect {
        patch :return, id: book.to_param
      }.to change { owner.borrowed_books.count }.by(-1)
    end

    it 'assigns to-be-returned book as @book' do
      patch :return, id: book.to_param
      expect(assigns(:book)).to eq(book)
    end

    it 'redirects to #index' do
      patch :return, id: book.to_param
      expect(response).to redirect_to(books_path)
    end
  end
end
