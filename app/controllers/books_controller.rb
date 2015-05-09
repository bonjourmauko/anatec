class BooksController < ApplicationController
  # GET /books
  def index
    @owned_books    = current_user.owned_books
    @lent_books     = current_user.lent_books
    @borrowed_books = current_user.borrowed_books
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # POST /books
  def create
    @book = current_user.owned_books.build(new_book_params)

    if @book.save
      redirect_to books_path, notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  # PATCH /books/1/lend
  def lend
    @book     = current_user.owned_books.find(params[:id])
    @borrower = User.find(lend_book_params[:borrower_id])

    @book.lend(@borrower)

    redirect_to books_path, notice: 'Book was successfully lent.'
  end

  # PATCH /books/1/return
  def return
    @book = current_user.borrowed_books.find(params[:id])

    @book.return

    redirect_to books_path, notice: 'Book was successfully returned.'
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def new_book_params
    params.require(:book).permit(:title, :author)
  end

  def lend_book_params
    params.require(:book).permit(:borrower_id)
  end
end
