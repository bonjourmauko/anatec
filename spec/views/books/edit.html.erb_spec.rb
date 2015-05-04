require 'rails_helper'

RSpec.describe "books/edit", type: :view do
  before(:each) do
    @book = assign(:book, Book.create!(
      :author => nil,
      :title => "MyString",
      :user => nil,
      :user => nil
    ))
  end

  it "renders the edit book form" do
    render

    assert_select "form[action=?][method=?]", book_path(@book), "post" do

      assert_select "input#book_author_id[name=?]", "book[author_id]"

      assert_select "input#book_title[name=?]", "book[title]"

      assert_select "input#book_user_id[name=?]", "book[user_id]"

      assert_select "input#book_user_id[name=?]", "book[user_id]"
    end
  end
end
